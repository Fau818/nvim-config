local function send_to_cc()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then vim.api.nvim_command("ClaudeCodeSend") return end
  if mode == "n" then vim.api.nvim_command("ClaudeCodeAdd %") return end

  assert(false, "Mode " .. mode .. " not supported!")
end


---@type LazySpec
return {
  ---@module "claudecode"
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim", "folke/sidekick.nvim", },
  enabled = vim.fn.executable("claude") == 1,
  event = "VeryLazy",

  keys = {
    { "<C-.>", "<CMD>ClaudeCode<CR>", desc = "Claude Code: Toggle", mode = { "n", "x" } },
    { "<LEADER>ct", send_to_cc, desc = "Claude Code: Send", mode = { "n", "x" } },
    { "<LEADER>ct", "<CMD>ClaudeCodeTreeAdd<CR>", desc = "Claude Code: Send (File Tree)", mode = { "n", "x" }, ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" } },

    -- { "<C-y>", accept_diff, desc = "Claude Code: Accept Diff", mode = "n" },
    -- { "<C-n>", reject_diff, desc = "Claude Code: Reject Diff", mode = "n" },
  },

  init = function()
    local group = vim.api.nvim_create_augroup("ClaudeCodeDiffKeymaps", { clear = true })

    -- Set up keymaps for diff buffers.
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = group,
      callback = function(args)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then return end
          if vim.b[args.buf].claudecode_diff_tab_name == nil then return end
          if vim.b[args.buf].claudecode_diff_keymaps_set then return end

          vim.b[args.buf].claudecode_diff_keymaps_set = true

          vim.keymap.set("n", "q", "<NOP>", { buffer = args.buf, silent = true })
          vim.keymap.set("n", "<C-y>", "<CMD>ClaudeCodeDiffAccept<CR>", { buffer = args.buf, silent = true })
          vim.keymap.set("n", "<C-n>", "<CMD>ClaudeCodeDiffDeny<CR>",   { buffer = args.buf, silent = true })
        end)
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
      auto_close = true,
      provider = "snacks",
      ---@module "snacks"
      ---@type snacks.win.Config
      snacks_win_opts = {
        position = "float",
        width = 0.88,
        height = 0.85,
        keys = {
          hide           = { "<C-.>", function(self) self:hide() end, mode = { "n", "t" }, desc = "Hide" },
          hide_ctrl_q    = { "<C-q>", function(self) self:hide() end, mode = "n", desc = "Hide" },
          stopinsert     = { "<C-q>", function() vim.cmd.stopinsert() end, mode = "t", desc = "Stop Insert" },
          claude_hide_ct = { "<C-t>", function(self) self:hide() end, mode = "t", desc = "Hide" },
        },
        border = "double",
        title = "  Claude Code  ",
      },
    },

    -- Diff Integration
    diff_opts = {
      layout = "vertical",  -- "vertical" or "horizontal"
      open_in_new_tab = false,
      keep_terminal_focus = false,  -- If true, moves focus back to terminal after diff opens
      hide_terminal_in_new_tab = false,
    },
  },
}
