-- =============================================
-- ========== Treesitter Utilities
-- =============================================
local _installed = {}  ---@type table<string,boolean>
local _queries   = {}  ---@type table<string,boolean>


---Get treesitter installed parsers.
---@param update? boolean Whether to update the installed parsers cache.
---@return table<string,boolean> installed Indicates whether a parser for a language is installed.
local function ts_get_installed(update)
  if update then
    _installed, _queries = {}, {}
    local installed_parsers = require("nvim-treesitter").get_installed("parsers")
    for _, lang in ipairs(installed_parsers) do _installed[lang] = true end
  end
  return _installed
end


---Check whether a parser for a language is installed.
local function ts_is_installed(lang) return ts_get_installed()[lang] == true end


---Check whether a query type is available for a language.
---@param lang string Language name.
---@param query "highlights"|"indents"|"folds"|"injections"|"locals" Query type.
---@return boolean
local function ts_has_query(lang, query)
  local key = lang .. ":" .. query
  if _queries[key] == nil then _queries[key] = vim.treesitter.query.get(lang, query) ~= nil end
  return _queries[key]
end


---Ensure that the `tree-sitter` CLI is installed.
---@param callback fun() Function to call after ensuring installation.
local function _ensure_ts_cli(callback)
  if vim.fn.executable("tree-sitter") == 1 then return callback() end

  local pkg_name = "tree-sitter-cli"
  fvim.lsp.mason.mason_install(pkg_name, nil, function(success, err)
    if success then fvim.notify(("Mason: %s was successfully installed."):format(pkg_name)) return callback()
    else fvim.notify(("Mason: %s failed to install."):format(pkg_name), vim.log.levels.ERROR)
    end
  end)
end


---Install treesitter parser(s) for specific language(s).
---@param lang string|string[] Language name or list of language names.
local function ts_install(lang, callback)
  _ensure_ts_cli(vim.schedule_wrap(function()
    require("nvim-treesitter").install(lang, { summary = true }):await(function(err)
      if err then vim.notify(err, vim.log.levels.ERROR, { title = "nvim-treesitter" })
      else
        fvim.notify("Neovim needs to be restarted to load the newly installed parser.", vim.log.levels.INFO, { title = "nvim-treesitter" })
        if vim.fn.has("nvim-0.12") == 1 then
          fvim.notify("Restarting Neovim in 3 seconds...", vim.log.levels.INFO, { title = "nvim-treesitter" })
          vim.defer_fn(function() vim.cmd("restart") end, 3000)
        end  -- TEMP: Restart Neovim to load the newly installed parser.
        ts_get_installed(true)
        if type(callback) == "function" then callback() end
      end
    end)
  end))
end


local function ts_ensure_install(lang, callback)
  if ts_is_installed(lang) then callback()
  else ts_install(lang, callback)
  end
end



-- =============================================
-- ========== Treesitter Plugin Specs
-- =============================================
---@type LazySpec[]
return {
  {
    ---@module "nvim-treesitter"
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- NOTE: Don't use `build = ":TSUpdate"` since it can't auto install parsers when nvim-treesitter is installed.
    build = function()
      local treesitter = require("nvim-treesitter")
      treesitter.update(nil, { summary = false })
    end,
    dependencies = "mason-org/mason-lspconfig.nvim",  -- Make sure `tree-sitter-cli` can be installed automatically.
    cond = true,
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate", "TSUninstall", "TSLog" },
    event = { "BufReadPost", "BufNewFile" },

    ---@class fvim.TSConfig
    opts = {
      -- install_dir = nil,  -- Use default.

      -- ==================== Custom Fields ====================
      ensure_installed = {
        "vim", "vimdoc", "regex","query",
        "bash", "toml", "yaml",
        "cpp", "lua", "python",
        "json", "jsonc",
        "markdown", "markdown_inline",
        "gitignore", "gitcommit", "diff", "git_rebase",
      },

      auto_install = true,  -- Automatically install missing parsers when entering buffer.

      highlight = {
        enable = true,
        disable = function(bufnr) return fvim.utils.is_large_file(bufnr) end,
      },
      indent    = {
        enable = true,
        disable = function(bufnr)
          if vim.bo[bufnr].filetype == "python" then return true end
          return fvim.utils.is_large_file(bufnr)
        end,
      },
      fold      = {
        enable = false,
        disable = function(bufnr) return fvim.utils.is_large_file() end,
      },
    },

    ---@param opts fvim.TSConfig
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")
      local parsers = require("nvim-treesitter.parsers")
      treesitter.setup(opts)

      ts_get_installed(true)  -- Initialization
      -- Install Missing Parsers
      local missing_langs = vim.tbl_filter(function(filetype) return not ts_is_installed(filetype) end, opts.ensure_installed or {})
      if #missing_langs > 0 then ts_install(missing_langs) end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype, lang = args.match, vim.treesitter.language.get_lang(args.match)
          if not lang or not parsers[lang] then return end

          local function ts_buf_enable()
            if opts.highlight.enable and not opts.highlight.disable(args.buf) and ts_has_query(lang, "highlights") then pcall(vim.treesitter.start, args.buf) end
            if opts.indent.enable and not opts.indent.disable(args.buf) and ts_has_query(lang, "indents") then vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
            if opts.fold.enable and not opts.fold.disable(args.buf) and ts_has_query(lang, "folds") then vim.wo[args.buf].foldexpr = "v:lua.vim.treesitter.foldexpr()" end
          end

          -- BUG: If a parser is installed, vim.treesitter.query.get still return `nil`.
          -- \    Which means ts features won't be enabled on the first time after installation.
          -- HACK: Restart neovim.
          if opts.auto_install then ts_ensure_install(lang, ts_buf_enable)
          else ts_buf_enable()
          end
        end,
      })
    end,
  },

  {
    ---@module "nvim-treesitter-textobjects"
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    cond = true,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { mode = { "n", "x", "o" }, "]]", function() require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer", "textobjects") end, desc = "Textobjects: Next Block" },
      { mode = { "n", "x", "o" }, "[[", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@block.outer", "textobjects") end, desc = "Textobjects: Prev Block" },
      { mode = { "n", "x", "o" }, "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end, desc = "Textobjects: Next Function" },
      { mode = { "n", "x", "o" }, "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, desc = "Textobjects: Prev Function" },
      { mode = { "n", "x", "o" }, "]c", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end, desc = "Textobjects: Next Class" },
      { mode = { "n", "x", "o" }, "[c", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end, desc = "Textobjects: Prev Class" },
    },

    ---@type TSTextObjects.UserConfig
    opts = {
      -- select = { lookahead  = true, lookbehind = false, selection_modes = {}, include_surrounding_whitespace = false },
      -- move = { set_jumps = true },
    },
  },

  {
    -- DESC: Show context of the current buffer contents.
    ---@module "treesitter-context"
    "nvim-treesitter/nvim-treesitter-context",
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    event = { "BufReadPost", "BufNewFile" },
    ---@type TSContext.UserConfig
    opts = {
      enable = true,             -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false,       -- Enable multiwindow support.
      max_lines = 8,             -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,     -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20,  -- Maximum number of lines to collapse for a single context line
      trim_scope = "outer",      -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",           -- Line used to calculate context. Choices: 'cursor', 'topline'
      separator = nil,
      zindex = 20,               -- The Z-index of the context window
      on_attach = function(buffer) return not fvim.utils.is_large_file(buffer) end,
    }
  },

  { "RRethy/nvim-treesitter-endwise", ft = { "Ruby", "Lua", "Vimscript", "Bash", "Elixir", "Fish", "Julia" } },
}
