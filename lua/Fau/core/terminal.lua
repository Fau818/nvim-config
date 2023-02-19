-- =============================================
-- ========== Plugin Loading
-- =============================================
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then Fau_vim.load_plugin_error("toggleterm") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  size = function(term)
    if term.direction == "horizontal" then return 10
    elseif term.direction == "vertical" then return vim.o.columns * 0.3
    end
  end,
  open_mapping = [[<C-t>]],

  hide_numbers = true, -- hide the number column in toggleterm buffers

  shade_terminals = false,
  shading_factor = 5, -- the degree by which to darken to terminal color

  start_in_insert = true,

  insert_mappings = true,   -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals

  direction = "float", -- string, values: vertical | horizontal | tab | float

  persist_mode = true,  -- if set to true (default) the previous terminal mode will be remembered
  persist_size = false, -- if set tot true, the previous terminal window size will be remembered (for horizontal and vertical)

  close_on_exit = true, -- close the terminal window when the process exits

  shell = vim.o.shell, -- change the default shell

  auto_scroll = true, -- automatically scroll to the bottom on terminal output

  float_opts = {
    border = "curved", -- values: single | double | shadow | curved | none
    winblend = 0,  -- keep this equal 0 if use transparent theme
  },

  on_open = function() vim.cmd("startinsert!") end,

  winbar = {
    enabled = false,
  },

  highlights = {
    Normal      = { link = "Normal", },
    NormalFloat = { link = "NormalFloat", },
    FloatBorder = { link = "FloatBorder" },
  },
}


toggleterm.setup(config)


-- Load custom functions
Fau_vim.functions.terminal = require "Fau.core.Fau_vim.functions.terminal"
