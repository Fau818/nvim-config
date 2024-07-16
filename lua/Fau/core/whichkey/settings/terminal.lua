local terminal = require("Fau.core.terminal.custom_terminal")
if not terminal then Fau_vim.notify("Load custom terminal error!", vim.log.levels.ERROR) return end


---@type wk.Spec
return {
  { "<LEADER>gg", terminal.lazygit, desc = "Toggle Lazygit" },
  { "<LEADER>gb", terminal.btop,    desc = "Toggle btop" },

  { "<F1>", terminal.float,      desc = "Toggle Float Terminal" },
  { "<F2>", terminal.horizontal, desc = "Toggle Horizontal Terminal" },
  { "<F3>", terminal.vertical,   desc = "Toggle Vertical Terminal" },
}
