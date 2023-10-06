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
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_echo_preview_url = 1
      vim.g.table_mode_corner = "|"
      vim.g.table_mode_map_prefix = "<LEADER>T"
      vim.keymap.set("n", "<LEADER>rf", "<CMD>Glow<CR>", { silent=true, buffer=true })
      vim.keymap.set("n", "<C-r>", "<CMD>MarkdownPreview<CR>", { silent=true, buffer=true })
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  },

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        auto_load = true,      -- whether to automatically load preview when
        -- entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete

        syntax = true,         -- enable syntax highlighting, affects performance

        theme = "dark",        -- 'dark' or 'light'

        update_on_change = true,

        app = "webview", -- 'webview', 'browser', string or a table of strings
        -- explained below

        filetype = { "markdown" }, -- list of filetypes to recognize as markdown

        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this
        -- amount of bytes in size
        throttle_time = "auto", -- minimum amount of time in milliseconds
        -- that has to pass before starting new render
      })
    end,
    ft = "markdown",
    lazy = true,  -- BUG: This is not working.
  }

}


return markdown
