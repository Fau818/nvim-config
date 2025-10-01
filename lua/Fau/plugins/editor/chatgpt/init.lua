---@type LazySpec
return {
  -- DESC: ChatGPT in Neovim!
  "jackMort/ChatGPT.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "folke/trouble.nvim", "nvim-telescope/telescope.nvim" },
  cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
  -- event = "VeryLazy",
  keys = require("Fau.plugins.editor.chatgpt.lazy_keys"),

  config = function() require("Fau.plugins.editor.chatgpt.config") end,
}
