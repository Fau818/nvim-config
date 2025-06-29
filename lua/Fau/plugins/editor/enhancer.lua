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


  -- ==================== Immersive ====================
  {
    -- DESC: Dim inactive portions of the code to focus on coding.
    "folke/twilight.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.configs.editor.enhancer.twilight") end,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = { { "<LEADER><LEADER>t", "<CMD>Twilight<CR>", desc = "Twilight: Toggle" } }
  },


  {
    -- DESC: distraction-free coding for Neovim (zen-mode).
    "folke/zen-mode.nvim",
    config = function() require("Fau.configs.editor.enhancer.zen-mode") end,

    cmd = "ZenMode",
    keys = { { "<LEADER><LEADER>z", "<CMD>ZenMode<CR>", desc = "ZenMode: Toggle" } }
  },


  -- ==================== Code Runner ====================
  {
    -- DESC: Easily run code in Neovim.
    "CRAG666/code_runner.nvim",
    config = function() require("Fau.configs.editor.enhancer.code_runner") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects", "CrStopHr" },
    keys = { "<C-r>", "<LEADER>r" },
  },


  -- ==================== Snacks ====================
  {
    "folke/snacks.nvim",
    priority = 1000,
    config = function() require("Fau.configs.editor.enhancer.snacks") end
  },


}
