-- =============================================
-- ========== Plugin Loading
-- =============================================
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then Fau_vim.load_plugin_error("mason") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type MasonSettings
local config = {
  -- The directory in which to install packages.
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },

  -- Where Mason should put its bin location in your PATH. Can be one of:
  -- - "prepend" (default, Mason's bin location is put first in PATH)
  -- - "append" (Mason's bin location is put at the end of PATH)
  -- - "skip" (doesn't modify PATH)
  ---@type '"prepend"' | '"append"' | '"skip"'
  PATH = "skip",

  log_level = vim.log.levels.INFO,

  max_concurrent_installers = 4,

  registries = {
    "github:mason-org/mason-registry",
    "lua:Fau.core.lsp.custom_source",
  },

  providers = { "mason.providers.registry-api", "mason.providers.client" },

  github = { download_url_template = "https://github.com/%s/releases/download/%s/%s", },

  pip = { upgrade_pip = false, install_args = {} },

  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,

    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "double",

    width  = 0.9,
    height = 0.85,

    icons = {
      -- The list icon to use for installed packages.
      package_installed = "✓",  -- "◍"
      -- The list icon to use for packages that are installing, or queued for installation.
      package_pending = "➜",
      -- The list icon to use for packages that are not installed.
      package_uninstalled = "✗",
    },

    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
      toggle_package_install_log = "<CR>",
      toggle_help = "?",
    },
  },
}


mason.setup(config)
