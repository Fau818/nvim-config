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

  -- TODO: Configure obsidian.nvim more thoroughly.
  {
    ---@module "obsidian"
    "obsidian-nvim/obsidian.nvim",
    -- version = "*",  -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },

    ---@type obsidian.config
    opts = {
      legacy_commands = false,  -- this will be removed in the next major release
      workspaces = {
        {
          name = "personal",
          path = vim.env.IOBSIDIAN or "",
        },
      },
      attachments = {
        folder = "/Attachments/images/",
      },

      -- see below for full list of options 👇
      footer = { enabled = true }
    },

    config = function(_, opts)
      require("obsidian").setup(opts)

      _G.fvim_obsidian_image_resolver = function(path, src)
        if require("obsidian.api").path_is_note(path) then
          return require("obsidian.api").resolve_image_path(src)
        end
      end
    end,
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

  {
    ---@module "otter"
    "jmbuhr/otter.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "markdown",

    ---@type OtterConfig
    opts = {
      lsp = {
        diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
        -- root_dir = nil,  -- Use default.
      },

      buffers = {
        set_filetype = true,
        write_to_disk = false,
        preambles = {},
        postambles = {},
        ignore_pattern = { python = "^(%s*[%%!].*)" },
      },

      strip_wrapping_quote_characters = { "'", '"', "`" },
      handle_leading_whitespace = true,

      -- extensions = nil,  -- Use default.

      debug = false,
      verbose = { no_code_found = false },
    },

    config  = function(_, opts)
      local otter = require("otter")
      otter.setup(opts)

      vim.api.nvim_create_autocmd("FileType", { pattern = "markdown", callback = function(args) otter.activate() end })
    end,
  },

}
