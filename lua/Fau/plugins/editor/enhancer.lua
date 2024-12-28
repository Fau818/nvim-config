-- DESC: This module is for enhancing neovim features.

---@type LazySpec[]
return {
  -- ==================== Quickfix ====================
  {
    -- DESC: Quickfix list enhancer.
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim"  -- Not necessary, but for loading telescope keybinds first!
    },
    config = function() require("Fau.configs.editor.enhancer.trouble") end,
    event = "LspAttach",
    cmd = "Trouble",
    tag = Fau_vim.plugin.trouble.tag,
  },


  -- ==================== Key Binding ====================
  {
    -- DESC: Key binding helper.
    "folke/which-key.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("Fau.configs.editor.enhancer.whichkey") end,
    event = "UIEnter",
  },


  -- ==================== Terminal ====================
  {
    -- DESC: Terminal enhancer.
    "akinsho/toggleterm.nvim",
    config = function() require("Fau.configs.editor.enhancer.terminal") end,
    keys = { "<C-t>", "<LEADER>gg", "<LEADER>gb" },
    cmd = { "ToggleTerm", "TermExec" },
  },
}
