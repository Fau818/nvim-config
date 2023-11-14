-- NOTE: This module is for markdown filetype.

---@type LazySpec[]
local markdown = {
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
  },

  {
    "ellisonleao/glow.nvim",
    config = function()
      local config = {
        border = "double", -- floating window border config

        width  = 99999,
        height = 99999,
        width_ratio = 0.85, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.85,
      }
      require("glow").setup(config)
    end,
    ft = "markdown",
    cmd = "Glow",
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  },

}


return markdown
