-- =============================================
-- ========== Plugin Loading
-- =============================================
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then Fau_vim.load_plugin_error("toggleterm") return end



-- =============================================
-- ========== Configuration
-- =============================================
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
  shading_factor = 5,  -- the degree by which to darken to terminal color

  start_in_insert = true,
  hide_numbers = true,  -- hide the number column in toggleterm buffers

  insert_mappings = true,    -- whether or not the open mapping applies in insert mode
  terminal_mappings = true,  -- whether or not the open mapping applies in the opened terminals

  ---@type "vertical"|"horizontal"|"tab"|"float"
  direction = "float",

  persist_mode = false,  -- if set to true (default) the previous terminal mode will be remembered
  persist_size = false,  -- if set tot true, the previous terminal window size will be remembered (for horizontal and vertical)

  close_on_exit = true,  -- close the terminal window when the process exits

  shell = vim.o.shell,  -- change the default shell

  auto_scroll = true,  -- automatically scroll to the bottom on terminal output

  float_opts = {
    border = "rounded",  ---@type "single"|"double"|"shadow"|"curved"|"rounded"|"none"
    winblend = 0,  -- keep this equal 0 if use transparent theme
  },

  on_open = function() vim.cmd("startinsert!") end,

  winbar = {
    enabled = false,
    ---@param term Terminal
    name_formatter = function(term) return term.name end,
  },

  responsiveness = {
    -- breakpoint in terms of `vim.o.columns` at which terminals will start to stack on top of each other
    -- instead of next to each other
    -- default = 0 which means the feature is turned off
    horizontal_breakpoint = 135,
  },

  highlights = {
    Normal      = { link = "Normal" },
    NormalFloat = { link = "NormalFloat" },
    FloatBorder = { link = "FloatBorder" },
  },
}


toggleterm.setup(config)
