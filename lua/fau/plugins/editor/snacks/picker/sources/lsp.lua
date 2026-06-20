local preset = require("fau.plugins.editor.snacks.picker.sources.preset")

-- Annotate picker opts to avoid "undefined-field" diagnostics for picker fields
---@alias SnacksPickerOpts table|{ lsp_buf: integer, lsp_ft: string, lsp_show_all?: boolean }


-- =============================================
-- ========== Control Actions
-- =============================================
---Get available control actions based on the server state.
---@param item snacks.picker.Item item from the `lsp_config` source
---@param bufnr integer origin buffer of the picker
---@return string[]
local function get_actions(item, bufnr)
  local has_config = vim.lsp.config[item.name] ~= nil

  -- Running: `disable` requires a `vim.lsp.config` entry, which clients
  -- started manually by plugins (e.g. copilot) may not have.
  if item.attached then
    local actions = { "restart", "stop" }
    -- Attach / detach only the origin buffer, without touching other buffers.
    table.insert(actions, item.buffers and item.buffers[bufnr] and "detach" or "attach")
    if has_config then table.insert(actions, "disable") end
    return actions
  end

  if not has_config then return {} end
  return item.enabled and { "start", "disable" } or { "start" }
end


---Run a control action on a server.
---@param item snacks.picker.Item
---@param action string
---@param bufnr integer origin buffer of the picker
local function lsp_control(item, action, bufnr)
  -- `:lsp enable` is a no-op for an already-enabled config, so toggle it off
  -- first to force a re-scan that attaches existing matching buffers.
  if action == "start" then
    if vim.lsp.is_enabled(item.name) then vim.lsp.enable(item.name, false) end
    fvim.lsp.setup_server(item.name)
    fvim.notify("LSP: start " .. item.name)
    return
  end

  -- Buffer-level operations: the server keeps running for other buffers.
  -- NOTE: A detached buffer is re-attached once its `FileType` event fires again (e.g. `:e`).
  if action == "attach" or action == "detach" then
    local handle = action == "attach" and vim.lsp.buf_attach_client or vim.lsp.buf_detach_client
    for _, client in ipairs(vim.lsp.get_clients({ name = item.name })) do handle(bufnr, client.id) end
    fvim.notify(("LSP: %s %s for current buffer"):format(action, item.name))
    return
  end

  -- Other actions go through the builtin `:lsp` command, SEE `:h lsp-commands`.
  local success, err = pcall(vim.cmd.lsp, { action, item.name })
  if success then fvim.notify(("LSP: %s %s"):format(action, item.name))
  else fvim.notify(tostring(err), vim.log.levels.WARN)
  end
end


---Create a picker action that runs a control action in place and refreshes the list.
---@param action string
---@return snacks.picker.Action.fn
local function control_action(action)
  ---@param picker table|{ opts: SnacksPickerOpts }
  return function(picker, item)
    if not item then return end

    lsp_control(item, action, picker.opts.lsp_buf)
    -- Stop / restart are async, refresh the list after they settle.
    vim.defer_fn(function() picker:find() end, 250)
  end
end


---Check whether a server is relevant to the picker's origin buffer (attached or filetype match).
---CAUTION: Runs in a fast event context (via `transform`), keep it free of API calls.
---@param item snacks.picker.Item
---@param filetype string
---@return boolean
local function is_relevant(item, filetype)
  if item.attached_buf then return true end

  local filetypes = item.config and item.config.filetypes
  return filetypes ~= nil and vim.list_contains(filetypes, filetype)
end


---Toggle between showing servers relevant to the current buffer and all servers.
---@type snacks.picker.Action.fn
---@param picker table|{ opts: SnacksPickerOpts }
local function toggle_all(picker)
  picker.opts.lsp_show_all = not picker.opts.lsp_show_all
  picker:find()
end


---Pick a control action for the selected server via `vim.ui.select`.
---@type snacks.picker.Action.fn
---@param picker table|{ opts: SnacksPickerOpts }
---@param item snacks.picker.Item
local function confirm(picker, item)
  if not item then return end

  local bufnr = picker.opts.lsp_buf
  local actions = get_actions(item, bufnr)
  if #actions == 0 then fvim.notify("LSP: no actions available for " .. item.name, vim.log.levels.WARN) return end

  picker:close()

  vim.ui.select(
    actions, { prompt = "LSP Control: " .. item.name },
    function(choice) if choice then lsp_control(item, choice, bufnr) end end
  )
end


local control_keys = {
  ["<c-e>"] = { "lsp_start",      mode = { "n", "i" }, desc = "Start/Enable Server" },
  ["<c-r>"] = { "lsp_restart",    mode = { "n", "i" }, desc = "Restart Server" },  -- NOTE: Shadows `toggle_regex` in this picker.
  ["<c-s>"] = { "lsp_stop",       mode = { "n", "i" }, desc = "Stop Server" },
  ["<c-x>"] = { "lsp_disable",    mode = { "n", "i" }, desc = "Disable Server" },
  ["<c-b>"] = { "lsp_toggle_all", mode = { "n", "i" }, desc = "Toggle All Servers" },
}



return {
  ---@type snacks.picker.Config
  lsp_config_picker = {
    layout = { preset = preset.default_layout },
    on_show = preset.normal_mode,

    confirm = confirm,

    -- Capture the origin buffer synchronously at open time:
    -- `transform` runs in a fast event context where most APIs are forbidden.
    ---@param opts SnacksPickerOpts
    config = function(opts)
      opts.lsp_buf = vim.api.nvim_get_current_buf()
      opts.lsp_ft = vim.bo.filetype
      return opts
    end,

    -- Only show servers relevant to the origin buffer (toggle with <M-b>).
    -- NOTE: Must return `false` (not nil) to drop an item.
    ---@param ctx table|{ picker: { opts: SnacksPickerOpts } }
    transform = function(item, ctx)
      local opts = ctx.picker.opts
      return opts.lsp_show_all == true or is_relevant(item, opts.lsp_ft)
    end,

    actions = {
      lsp_start      = control_action("start"),
      lsp_restart    = control_action("restart"),
      lsp_stop       = control_action("stop"),
      lsp_disable    = control_action("disable"),
      lsp_toggle_all = toggle_all,
    },

    win = {
      input   = { keys = control_keys },
      list    = { keys = control_keys },
      preview = preset.minimal_preview,
    },
  },
}
