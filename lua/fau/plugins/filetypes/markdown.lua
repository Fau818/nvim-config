-- DESC: This module is for markdown filetype.

---@type LazySpec[]
return {
  {
    -- DESC: Quick table creation and editing in markdown.
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle", "TableModeEnable", "TableModeDisable", "Tableize", "TableModeRealign", "TableAddFormula", "TableEvalFormulaLine", "TableSort" },
    ft = "markdown",

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
    enabled = vim.fn.executable("glow") == 1,
    cmd = "Glow",
    ft = "markdown",
    keys = { { "<LEADER>rf", "<CMD>Glow<CR>", desc = "Glow: Show", buffer = true, ft = "markdown" } },

    ---@type Config
    opts = {
      border = "double",  -- floating window border config
      width  = 99999,
      height = 99999,
      width_ratio = 0.85,  -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
      height_ratio = 0.85,
    }
  },

  {
    -- DESC: A markdown previewer using a web browser.
    "iamcco/markdown-preview.nvim",
    enabled = vim.fn.executable("yarn") == 1,
    build = "cd app && yarn install",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = "markdown",
    keys = { { "<C-r>", "<CMD>MarkdownPreview<CR>", desc = "Markdown Preview: Preview", buffer = true, ft = "markdown" } },

    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
    end,
  },

}
