local Terminal = require("toggleterm.terminal").Terminal

-- ==================== Custom Layouts ====================
local full_screen = { border = "none", width = 888888, height = 888888 }


-- ==================== Custom Terminal ====================
local custom_terminal = {
  -- cmd = string -- command to execute when creating the terminal e.g. 'top'
  -- display_name = string -- the name of the terminal
  -- direction = string -- the layout for the terminal, same as the main config options
  -- dir = string -- the directory for the terminal
  -- close_on_exit = bool -- close the terminal window when the process exits
  -- highlights = table -- a table with highlights
  -- env = table -- key:value table with environmental variables passed to jobstart()
  -- clear_env = bool -- use only environmental variables from `env`, passed to jobstart()
  -- on_open = fun(t: Terminal) -- function to run when the terminal opens
  -- on_close = fun(t: Terminal) -- function to run when the terminal closes
  -- auto_scroll = boolean -- automatically scroll to the bottom on terminal output
  -- -- callbacks for processing the output
  -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits

  lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    count = 101,
    direction = "float",
    float_opts = full_screen,
  }),

  btop = Terminal:new({
    cmd = "btop",
    count = 102,
    dir = "git_dir",
    direction = "float",
    float_opts = full_screen,
  }),

  float = Terminal:new({
    count = 11,
    dir = "git_dir",
    direction = "float",
    float_opts = full_screen,
  }),

  horizontal = Terminal:new({
    count = 12,
    dir = "git_dir",
    direction = "horizontal",
  }),

  vertical = Terminal:new({
    count = 13,
    dir = "git_dir",
    direction = "vertical",
  }),
}

vim.keymap.set("n", "<LEADER>gg", function() custom_terminal.lazygit:toggle() end, { desc = "Toggle Lazygit" })
vim.keymap.set("n", "<LEADER>gb", function() custom_terminal.btop:toggle() end,    { desc = "Toggle btop" })
-- vim.keymap.set("n", "<C-q>1",     function() custom_terminal.float:toggle()      end, { desc = "Toggle Float Terminal" })
-- vim.keymap.set("n", "<C-q>2",     function() custom_terminal.horizontal:toggle() end, { desc = "Toggle Horizontal Terminal" })
-- vim.keymap.set("n", "<C-q>3",     function() custom_terminal.vertical:toggle()   end, { desc = "Toggle Vertical Terminal" })
