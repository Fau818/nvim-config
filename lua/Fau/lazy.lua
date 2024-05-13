-- =============================================
-- ========== Lazy Install
-- =============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Keymaps
-- -----------------------------------
local ViewConfig = require("lazy.view.config")
ViewConfig.keys.hover = "<C-d>"


-- -----------------------------------
-- -------- Options
-- -----------------------------------
---@type LazyConfig
local config = {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false,
    cond = not vim.g.vscode,
  },

  -- leave nil when passing the spec as the first argument to setup()
  spec = "Fau.plugins",
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  ---@type number limit the maximum amount of concurrent tasks
  concurrency = jit.os:find("Windows") and (vim.loop.available_parallelism() * 2) or 50,

  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    filter = true,
  },

  dev = {
    -- directory where you store your local plugin projects
    path = "~/projects",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },

  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "tokyonight", "habamax" },
  },

  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.9, height = 0.85 },
    wrap = true, -- wrap the lines in the ui
    border = "double",
    title = nil, ---@type string only works when border is not "none"
    title_pos = "center", ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    icons = nil,  -- Fau: use defaults
    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- Open a terminal for the plugin dir
      ["<localleader>D"] = function(plugin) require("lazy.util").float_term(nil, { cwd = plugin.dir }) end,
      -- Open lazygit log
      ["<localleader>L"] = function(plugin) require("lazy.util").float_term({ "lazygit", "log" }, { cwd = plugin.dir }) end,
    }
  },

  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = Fau_vim.os_name == "Darwin" and "browser" or "diffview.nvim",
  },

  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = false,
  },

  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },

  performance = {
    cache = { enabled = true },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {},
    },
  },

  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },

  state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
  build = { warn_on_override = true },

  -- Enable profiling of lazy.nvim. This will add some overhead,
  -- so only enable this when you are debugging lazy.nvim
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
  },
}


require("lazy").setup(config)
