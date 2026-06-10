---@type LazyPluginSpec
return {
  ---@module "scissors"
  "chrisgrieser/nvim-scissors",

  keys = {
    { "<LEADER>Es", "<CMD>ScissorsEditSnippet<CR>", desc = "Edit Snippets" },
    { "<LEADER>En", "<CMD>ScissorsAddNewSnippet<CR>", desc = "Add New Snippet" },
  },

  ---@type Scissors.Config
  opts = {
    snippetDir = fvim.nvim_config_path .. "/snippets",

    editSnippetPopup = {
      height = 0.4,
      width = 0.6,
      border = "double",
      keymaps = {
        cancel = "q",
        saveChanges = "<CR>",  -- alternatively, can also use `:w`
        goBackToSearch = "<BS>",
        deleteSnippet = "<C-BS>",
        duplicateSnippet = "<C-d>",
        openInFile = "<C-o>",
        insertNextPlaceholder = "<C-p>",  -- insert & normal mode
        showHelp = "?",
      },
    },

    snippetSelection = {
      picker = "auto",  ---@type "auto"|"fzf-lua"|"telescope"|"snacks"|"vim.ui.select"

      fzfLua = nil,  -- Use default.
      telescope = nil,  -- Use default.
    },

    jsonFormatOpts = { sort_keys = true, indent = "  " },

    backdrop = { enabled = true, blend = 60 },

    icons = { scissors = "󰩫" },
  },
}
