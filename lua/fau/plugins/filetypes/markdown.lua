-- DESC: This module is for markdown filetype.

---@type LazySpec[]
return {
  {
    -- DESC: Quick table creation and editing in markdown.
    "dhruvasagar/vim-table-mode",
    init = function()
      vim.g.table_mode_corner = "|"

      vim.g.table_mode_map_prefix = "<LEADER>T"
      vim.g.table_mode_realign_map = "<LEADER>Ta"
      vim.g.table_mode_delete_row_map = false
      vim.g.table_mode_delete_column_map = false
      vim.g.table_mode_insert_column_before_map = false
      vim.g.table_mode_insert_column_after_map = false
      vim.g.table_mode_add_formula_map = false
      vim.g.table_mode_eval_formula_map = false
      vim.g.table_mode_echo_cell_map = false
      vim.g.table_mode_sort_map = false
      vim.g.table_mode_tableize_map = false
      vim.g.table_mode_tableize_d_map = false
    end,
    ft = "markdown",
    cmd = { "TableModeToggle", "TableModeEnable", "TableModeDisable", "Tableize", "TableModeRealign", "TableAddFormula", "TableEvalFormulaLine", "TableSort" }
  },

  {
    -- DESC: Follow markdown links (including anchors) with Enter.
    "jghauser/follow-md-links.nvim",
    ft = "markdown",
  },

  {
    -- DESC: A floating window markdown previewer for Neovim.
    ---@module "glow"
    "ellisonleao/glow.nvim",
    config = function()
      local config = {
        border = "double",  -- floating window border config
        width  = 99999,
        height = 99999,
        width_ratio = 0.85,  -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.85,
      }
      require("glow").setup(config)
      vim.keymap.set("n", "<LEADER>rf", "<CMD>Glow<CR>", { buffer = true, desc = "Glow: Show" })
    end,
    ft = "markdown",
    cmd = "Glow",
  },

  {
    -- DESC: A markdown previewer using a web browser.
    "iamcco/markdown-preview.nvim",
    enabled = vim.fn.executable("yarn") == 1,
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
    end,
    config = function()
      -- TODO: Do this in code_runner.
      vim.keymap.set("n", "<C-r>", "<CMD>MarkdownPreview<CR>", { buffer = true, desc = "Markdown Preview: Preview" })
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  },

}
