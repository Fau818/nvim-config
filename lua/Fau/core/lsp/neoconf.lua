-- =============================================
-- ========== Plugin Loading
-- =============================================
local neoconf_ok, neoconf = pcall(require, "neoconf")
if not neoconf_ok then Fau_vim.load_plugin_error("neoconf") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  -- name of the local settings files
  local_settings = ".neoconf.json",
  -- name of the global settings file in your Neovim config directory
  global_settings = "neoconf.json",
  -- import existing settinsg from other plugins

  import = {
    vscode = false,  -- local .vscode/settings.json
    coc    = false,  -- global/local coc-settings.json
    nlsp   = false,  -- global/local nlsp-settings.nvim json settings
  },

  -- send new configuration to lsp clients when changing json settings
  live_reload = true,
  -- set the filetype to jsonc for settings files, so you can use comments
  -- make sure you have the jsonc treesitter parser installed!
  filetype_jsonc = true,

  plugins = {
    -- configures lsp clients with settings in the following order:
    -- - lua settings passed in lspconfig setup
    -- - global json settings
    -- - local json settings
    lspconfig = {
      enabled = true,
    },
    -- configures jsonls to get completion in .nvim.settings.json files
    jsonls = {
      enabled = true,
      -- only show completion in json settings for configured lsp servers
      configured_servers_only = false,
    },
    -- configures lua_ls to get completion of lspconfig server settings
    lua_ls = {
      -- by default, lua_ls annotations are only enabled in your neovim config directory
      enabled_for_neovim_config = true,
      -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file
      enabled = false,
    },
  },
}


neoconf.setup(config)
