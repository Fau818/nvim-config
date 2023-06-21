local terminal = require("Fau.core.terminal.custom_terminal")
if not terminal then Fau_vim.notify("Load custom terminal error!", vim.log.levels.ERROR) return end


local terminal_qaq = {
  ["<F1>"] = { terminal.float,      "Toggle Float Terminal" },
  ["<F2>"] = { terminal.horizontal, "Toggle Horizontal Terminal" },
  ["<F3>"] = { terminal.vertical,   "Toggle Vertical Terminal" },
}


return {
  n = {
    terminal_qaq,

    ["<LEADER>"] = {
      gg = { terminal.lazygit, "Toggle Lazygit" },
      lg = { terminal.lazygit, "Toggle Lazygit" },

      gb = { terminal.btop,    "Toggle btop" },
    },
  },


  t = {
    terminal_qaq,

    -- ["<ESC>"] = { "<C-\\><C-n>", "Normal Mode" }
  }
}
