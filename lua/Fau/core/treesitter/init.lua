-- =============================================
-- ========== Plugin Loading
-- =============================================
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then Fau_vim.load_plugin_error("nvim-treesitter.configs") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type TSConfig
local config = {
  -- A list of parser names, or "all"
  ensure_installed = {
    "vim",
    "c", "cpp", "lua", "python",
    "regex", "bash", "markdown", "markdown_inline",
    "gitignore", "gitcommit",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = function() return Fau_vim.functions.utils.is_large_file() end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = false, -- set to `false` to disable one of the mappings
      node_incremental  = "<C-=>",
      node_decremental  = "<C-->",
      scope_incremental = false,
    },
  },

  indent = {
    enable = true,
    disable = function() return Fau_vim.functions.utils.is_large_file() end,
  },

  -- nvim-ts-autotag plugin
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },

  -- nvim-treesitter-endwise plugin
  endwise = { enable = true },

  -- nvim-treesitter-textobjects plugin
  textobjects = require("Fau.core.treesitter.textobjects"),

  -- playground plugin
  playground = require("Fau.core.treesitter.playground"),
}


treesitter.setup(config)
