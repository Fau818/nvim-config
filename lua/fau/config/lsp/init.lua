local M = {}

-- =============================================
-- ========== Fields
-- =============================================
---@type table<string, boolean> Keep track of filetypes that have been configured
M.configured_ft = {}

---@type table<string, string[]> Auto installed LSP servers for specific filetypes
M.packages = {
  css        = { "css-lsp" },
  docker     = { "dockerfile-language-server" },
  dockerfile = { "dockerfile-language-server" },
  go         = { "gopls" },
  html       = { "html-lsp" },
  json       = { "json-lsp" },
  jsonc      = { "json-lsp" },
  lua        = { "lua-language-server" },
  python     = { "basedpyright", "ruff" },
  sh         = { "bash-language-server" },
  toml       = { "tombi" },
  yaml       = { "yaml-language-server" },
  zsh        = { "bash-language-server" },
}



-- =============================================
-- ========== Functions
-- =============================================
---Apply a series of text transformations
---@param text string
---@param transformers function[]
---@return string
local function apply_transformations(text, transformers)
  local result = text
  for _, transform in ipairs(transformers) do result = transform(result) end
  return result
end


---Create inlay hint handler with custom text processors
---@param transformers function[]
---@return function
local function inlay_hint_handler(transformers)
  return function(err, result, ctx, config)
    if not result then vim.lsp.handlers["textDocument/inlayHint"](err, result, ctx, config); return end

    for _, hint in ipairs(result) do
      if type(hint.label) == "string" then
        hint.label = apply_transformations(hint.label, transformers)
      elseif type(hint.label) == "table" then
        -- BUG: Wrong inferred type from lua_ls.
        ---@diagnostic disable-next-line: param-type-mismatch
        for _, part in ipairs(hint.label) do
          if type(part) == "table" and part.value and type(part.value) == "string" then
            part.value = apply_transformations(part.value, transformers)
          end
        end
      end
    end

    vim.lsp.handlers["textDocument/inlayHint"](err, result, ctx, config)
  end
end


---@type vim.lsp.client.on_attach_cb
function M.on_attach(client, bufnr)
  local TRUNCATE_LEN = 25
  local transformers = {
    function(text) return text:sub(1, 2) == ": " and ": " .. text:sub(3):gsub(": ", ":") or text:gsub(": ", ":") end,
    -- Remove spaces around `|` symbol.
    function(text) return text:gsub("%s*|%s*", "|") end,
    -- Truncate long hints.
    function(text) return #text <= TRUNCATE_LEN and text or text:sub(1, TRUNCATE_LEN) .. "  " end
  }

  client.handlers["textDocument/inlayHint"] = inlay_hint_handler(transformers)
end


---Setup a LSP server
---@param server string server name
---@param opts vim.lsp.ClientConfig? configuration
local function _setup_server(server, opts)
  opts = opts or {}

  if vim.lsp.is_enabled(server) then return end

  -- Setup LSP.
  vim.lsp.config(server, opts)
  vim.lsp.enable(server, true)
end

---@type fun(server: string, opts?: vim.lsp.ClientConfig)
M.setup_server = vim.schedule_wrap(_setup_server)


---Restart LSP servers
---@param bufnr integer? buffer number
function M.restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  -- SPECIAL: LSP is not configured.
  local filetype = vim.bo[bufnr].filetype
  if not M.configured_ft[filetype] then
    local success = pcall(M.mason.setup_by_ft, filetype)
    if success then fvim.notify("Starting LSP servers for " .. filetype .. "...") end
    return
  end

  fvim.notify("Restarting LSP servers ...")
  -- REF: https://github.com/neovim/nvim-lspconfig/blob/master/plugin/lspconfig.lua `LspRestart` command.
  -- Get active clients for current buffer (excluding copilot).
  local clients = vim.iter(vim.lsp.get_clients({ bufnr = bufnr })):map(function(client) if client.name ~= "copilot" then return client.name end end):totable()

  -- Disable all clients first.
  for _, name in ipairs(clients) do
    if vim.lsp.config[name] == nil then fvim.notify(("Invalid server name '%s'"):format(name))
    else vim.lsp.enable(name, false)
    end
  end

  -- Restart clients after 500ms.
  vim.defer_fn(function() for _, name in ipairs(clients) do vim.schedule(function() vim.lsp.enable(name, true) end) end end, 500)
end


return M
