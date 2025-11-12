local treesitter = require("nvim-treesitter.configs")

---@type TSConfig
local config = {
  -- A list of parser names, or "all"
  ensure_installed = {
    "vim", "regex", "bash",
    "cpp", "lua", "python",
    "json", "jsonc",
    "markdown", "markdown_inline",
    "gitignore", "gitcommit",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = function() return fvim.utils.is_large_file() end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = { "gitcommit" },
    additional_vim_regex_highlighting = true,
  },

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection    = "<C-=>",
      node_incremental  = "<C-=>",
      node_decremental  = "<C-->",
      scope_incremental = false,
    },
  },

  indent = {
    -- NOTE: Bad indentation behavior in Python function block.
    -- \ e.g.: for i in range(10): print(i)
    -- \ if you hit the <ENTER> key, an indentation will continuously persist (even if you delete it and hit the <ENTER> again).
    enable = true,
    disable = function()
      if vim.bo.filetype == "python" then return true end
      return fvim.utils.is_large_file()
    end,
  },

  -- nvim-treesitter-endwise plugin
  endwise = { enable = true },

  -- nvim-treesitter-textobjects plugin
  textobjects = require("fau.plugins.editor.treesitter.textobjects"),
}


treesitter.setup(config)
