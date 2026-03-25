---@type LazySpec
return {
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
      set_filetype = false,
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
}
