-- ==================== Lazy Installation ====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",  -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



-- ==================== Configuration ====================
-- ---------- Keymaps
local ViewConfig = require("lazy.view.config")
ViewConfig.keys.hover = "<C-d>"

-- ---------- Options
---@type LazyConfig
local config = {
  root = nil,  -- Use default.

  defaults = { lazy = false, cond = not vim.g.vscode },

  ---@type LazySpec
  spec = {
    { import = "fau.plugins" },
    { import = "fau.plugins.editor" },
    { import = "fau.plugins.coding" },
    { import = "fau.plugins.filetypes" },
    { import = "fau.plugins.lsp" },
  },
  local_spec = true,

  lockfile    = nil,  -- Use default.
  concurrency = nil,  -- Use default.

  git = {
    log = { "--since=3 days ago" },
    timeout = 120,
    url_format = nil,  -- Use default.
    filter = true,
    throttle = nil,  -- Use default.
    cooldown = 0,
  },
  pkg   = nil,  -- Use default.
  rocks = nil,  -- Use default.
  dev   = nil,  -- Use default.

  install = { missing = true, colorscheme = { "tokyonight", "habamax" } },

  ui = {
    size = { width = 0.9, height = 0.85 },
    wrap = true,
    border = "double",
    backdrop = 60,

    title = " 💤lazy.nvim ", title_pos = "center",

    pills = true,  ---@type boolean

    icons    = nil,  -- Use default.
    browser  = nil,  -- Use default.
    throttle = nil,  -- Use default.

    custom_keys = {
      -- Open a terminal for the plugin dir
      ["<localleader>D"] = { function(plugin) require("lazy.util").float_term(nil, { cwd = plugin.dir }) end, desc = "Open Terminal in Plugin Dir" },
      -- Open lazygit log
      ["<localleader>L"] = { function(plugin) require("lazy.util").float_term({ "lazygit", "log" }, { cwd = plugin.dir }) end, desc = "Lazygit Log" },
      -- Inspect plugin
      ["<localleader>i"] = { function(plugin) require("lazy.util").notify(vim.inspect(plugin), { title = "Inspect " .. plugin.name, lang = "lua" }) end, desc = "Inspect Plugin" },
    },
  },

  headless = nil,  -- Use default.

  diff = { cmd = vim.fn.has("mac") == 1 and "browser" or "diffview.nvim" },

  checker = {
    enabled      = true,
    concurrency  = nil,   ---@type number? set to 1 to check for updates very slowly
    notify       = true,  -- get a notification when new updates are found
    frequency    = 3600,  -- check for updates every hour
    check_pinned = false,
  },

  change_detection = { enabled = true, notify = true },

  performance = nil,  -- Use default.
  readme      = nil,  -- Use default.
  state       = nil,  -- Use default.
  profiling   = nil,  -- Use default.
}

require("lazy").setup(config)


vim.keymap.set("n", "<LEADER>ll", require("lazy").home, { desc = "Lazy: Open" })
