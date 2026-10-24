---Check whether a mode is one of the Visual modes.
---@param mode string
---@return boolean
local function is_visual(mode) return mode == "v" or mode == "V" or mode == "\22" end


---Send a selection to the Claude Code client once it is connected.
---@param win integer The window the selection belongs to.
---@param sel? table What to send; the cursor position of `win` when nil.
local function broadcast(win, sel)
  local MAX_TRY, TIMEOUT = 5, 200
  local claudecode, selection = require("claudecode"), require("claudecode.selection")

  local tries = 0
  local function try()
    tries = tries + 1
    if not claudecode.is_claude_connected() then
      if tries < MAX_TRY then return vim.defer_fn(try, TIMEOUT) end
      return fvim.notify("Failed to broadcast selection to Claude Code client after " .. MAX_TRY .. " tries.", vim.log.levels.WARN)
    end
    pcall(vim.api.nvim_win_call, win, function() selection.send_selection_update(sel or selection.get_cursor_position()) end)
  end

  vim.defer_fn(try, TIMEOUT * 2)
end


---Mention the current file, or its selected lines, in the Claude Code prompt.
local function send_to_cc()
  local win = vim.api.nvim_get_current_win()

  -- HACK: Use a mention instead of the builtin send command since the CLI keeps one global `at_mentioned` handler,
  -- \     owned by whichever prompt box mounted last (e.g. the agents page), so the command lands in the wrong box.
  local mention = "@" .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  if is_visual(vim.fn.mode()) then
    local first, last = vim.fn.line("v"), vim.fn.line(".")
    if first > last then first, last = last, first end
    mention = mention .. "#L" .. first .. (first == last and "" or "-" .. last)
  end

  require("claudecode.terminal").send_to_terminal(mention .. " ", { submit = false, focus = true })
  broadcast(win)
end


---Focus the Claude Code window and tell the client what is selected in the current window.
local function focus_cc()
  local win, sel = vim.api.nvim_get_current_win(), nil

  -- HACK: From Visual mode `ClaudeCodeFocus` queues an <Esc> to leave it, which only runs once the terminal has
  -- \     focus, so the CLI receives it and interrupts the running task. Leave Visual mode ourselves first.
  if is_visual(vim.fn.mode()) then
    sel = require("claudecode.selection").get_visual_selection()  -- Read it before leaving Visual mode.
    vim.cmd("normal! \27")
  end

  vim.api.nvim_command("ClaudeCodeFocus")
  broadcast(win, sel)
end


---@type LazyPluginSpec
return {
  ---@module "claudecode"
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim", "folke/sidekick.nvim", },
  enabled = vim.fn.executable("claude") == 1,
  event = "VeryLazy",

  keys = {
    { "<C-.>", focus_cc, desc = "Claude Code: Focus", mode = { "n", "x" } },
    { "<LEADER>ct", send_to_cc, desc = "Claude Code: Send", mode = { "n", "x" } },
    { "<LEADER>ct", "<CMD>ClaudeCodeTreeAdd<CR>", desc = "Claude Code: Send (File Tree)", mode = { "n", "x" }, ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" } },

    -- { "<C-y>", accept_diff, desc = "Claude Code: Accept Diff", mode = "n" },
    -- { "<C-n>", reject_diff, desc = "Claude Code: Reject Diff", mode = "n" },
  },

  init = function()
    local group = vim.api.nvim_create_augroup("ClaudeCodeDiffKeymaps", { clear = true })

    -- Set up keymaps for diff buffers.
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "ClaudeCodeDiffOpened",
      callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) then return end

        vim.keymap.set("n", "q", "<NOP>", { buffer = args.buf, silent = true })
        vim.keymap.set("n", "<C-y>", "<CMD>ClaudeCodeDiffAccept<CR>", { buffer = args.buf, silent = true })
        vim.keymap.set("n", "<C-n>", "<CMD>ClaudeCodeDiffDeny<CR>",   { buffer = args.buf, silent = true })
      end,
    })
  end,

  ---@type ClaudeCodeConfig
  opts = {
    -- Server Configuration
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = "info",  -- "trace", "debug", "info", "warn", "error"
    terminal_cmd = nil,  -- Custom terminal command (default: "claude")

    ---@type boolean When true, successful sends will focus the Claude terminal if already connected
    focus_after_send = true,

    -- Selection Tracking
    track_selection = true,
    visual_demotion_delay_ms = fvim.settings.debounce.general,

    terminal = {
      split_side = "right",  ---@type "left" | "right"
      split_width_percentage = 0.30,
      diff_split_width_percentage = nil,
      fix_streamed_paste = "auto",

      auto_close = true,
      auto_insert = true,
      provider = "snacks",
      ---@module "snacks"
      ---@type snacks.win.Config
      snacks_win_opts = {
        -- NOTE: Uncomment the following 3 lines to use a floating window instead of a split.
        -- position = "float",
        -- width = 0.88,
        -- height = 0.85,
        keys = {
          hide           = { "<C-.>", function(self) self:hide() end, mode = { "n", "t" }, desc = "Hide" },
          hide_ctrl_q    = { "<C-q>", function(self) self:hide() end, mode = "n", desc = "Hide" },
          stopinsert     = { "<C-q>", function() vim.cmd.stopinsert() end, mode = "t", desc = "Stop Insert" },
          -- claude_hide_ct = { "<C-t>", function(self) self:hide() end, mode = "t", desc = "Hide" },
        },
        style = "terminal",
        border = "double",
        title = "  Claude Code  ",
      },
    },

    -- Diff Integration
    diff_opts = {
      layout = "vertical",  ---@type "vertical" | "horizontal" | "unified"
      open_in_new_tab = true,
      keep_terminal_focus = false,  -- If true, moves focus back to terminal after diff opens
      hide_terminal_in_new_tab = false,
      auto_resize_terminal = true,
    },
  },
}
