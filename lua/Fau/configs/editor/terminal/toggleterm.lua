-- =============================================
-- ========== Plugin Configurations
-- =============================================
local toggleterm = require("toggleterm")
local custom_terminal = require("Fau.configs.editor.terminal.custom_terminal")

---@type ToggleTermConfig
local config = {
  ---@diagnostic disable-next-line: assign-type-mismatch
  size = function(term)
    if term.direction == "horizontal" then return 10
    elseif term.direction == "vertical" then return vim.o.columns * 0.3
    end
  end,

  open_mapping = [[<C-t>]],

  autochdir = false,  -- when neovim changes it current directory the terminal will change it's own when next it's opened

  shade_terminals = false,
  shading_factor  = 0,  -- the degree by which to darken to terminal color
  shading_ratio   = 0,

  hide_numbers      = true,
  start_in_insert   = true,
  insert_mappings   = true,    -- whether or not the open mapping applies in insert mode
  terminal_mappings = true,  -- whether or not the open mapping applies in the opened terminals

  direction = "float",  ---@type "vertical"|"horizontal"|"tab"|"float"

  persist_mode = false,  -- if set to true (default) the previous terminal mode will be remembered
  persist_size = false,  -- if set tot true, the previous terminal window size will be remembered (for horizontal and vertical)

  auto_scroll   = true,  -- automatically scroll to the bottom on terminal output
  shell         = vim.o.shell,  -- change the default shell
  clear_env     = false,
  close_on_exit = true,  -- close the terminal window when the process exits

  float_opts = {
    border = "rounded",  ---@type "single"|"double"|"shadow"|"curved"|"rounded"|"none"
    winblend = 0,  -- keep this equal 0 if use transparent theme
  },

  winbar = {
    enabled = false,
    ---@param term Terminal
    name_formatter = function(term) return term.name end,
  },

  responsiveness = { horizontal_breakpoint = 135 },

  highlights = {
    Normal      = { link = "Normal" },
    NormalFloat = { link = "NormalFloat" },
    FloatBorder = { link = "FloatBorder" },
  },

  -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
  -- on_open   = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close  = fun(t: Terminal), -- function to run when the terminal closes
  -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  -- on_exit   = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits

  -- on_open = function() vim.cmd("startinsert!") end,
}

toggleterm.setup(config)



-- =============================================
-- ========== Custom Terminal
-- =============================================
vim.keymap.set("n", "<LEADER>gg", custom_terminal.lazygit, { silent = true, desc = "Toggle Lazygit" })
vim.keymap.set("n", "<LEADER>gb", custom_terminal.btop,    { silent = true, desc = "Toggle btop" })

-- vim.keymap.set("n", "<C-q>1", custom_terminal.float,      { silent = true, desc = "Toggle Float Terminal" })
-- vim.keymap.set("n", "<C-q>2", custom_terminal.horizontal, { silent = true, desc = "Toggle Horizontal Terminal" })
-- vim.keymap.set("n", "<C-q>3", custom_terminal.vertical,   { silent = true, desc = "Toggle Vertical Terminal" })
