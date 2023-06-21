local terminal = {
  ["<F1>"] = { Fau_vim.functions.terminal.float,      "Toggle Float Terminal" },
  ["<F2>"] = { Fau_vim.functions.terminal.horizontal, "Toggle Horizontal Terminal" },
  ["<F3>"] = { Fau_vim.functions.terminal.vertical,   "Toggle Vertical Terminal" },
}

return {
  n = {
    terminal,

    ["<LEADER>"] = {
      gg = { Fau_vim.functions.terminal.lazygit, "Toggle Lazygit" },
      lg = { Fau_vim.functions.terminal.lazygit, "Toggle Lazygit" },

      gb = { Fau_vim.functions.terminal.btop,    "Toggle btop" },
    },
  },



  t = {
    terminal,

    -- ["<ESC>"] = { "<C-\\><C-n>", "Normal Mode" }
  }
}
