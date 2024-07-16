---@type wk.Spec
return {
  { "<C-r>", "<CMD>RunFile toggleterm<CR>", desc = "Run File in Toggleterm" },

  { "<LEADER>r", group = "Code Runner" },

  { "<LEADER>rt", "<CMD>RunFile term<CR>",   desc = "Run File in Terminal" },
  { "<LEADER>rT", "<CMD>RunFile toggle<CR>", desc = "Run File Toggle" },
  { "<LEADER>rf", "<CMD>RunFile float<CR>",  desc = "Run File in Float" },

  { "<LEADER>rc", "<CMD>RunClose<CR>", desc = "Run Close" },
  { "<LEADER>rp", "<CMD>RunProject toggleterm<CR>", desc = "Run Project in Toggleterm" },
}
