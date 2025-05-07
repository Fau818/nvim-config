-- =============================================
-- ========== Plugin Configurations
-- =============================================
local null_ls = require("null-ls")



-- =============================================
-- ========== Initialization
-- =============================================
-- local h = require("null-ls.helpers")
-- local methods = require("null-ls.methods")
local code_actions = null_ls.builtins.code_actions
local diagnostics  = null_ls.builtins.diagnostics
local formatting   = null_ls.builtins.formatting
local hover        = null_ls.builtins.hover
local completion   = null_ls.builtins.completion


-- TODO: Use a language module to manage the config for each language.

-- =============================================
-- ========== Configuration
-- =============================================
local sources = {
  -- -----------------------------------
  -- -------- Lua
  -- -----------------------------------
  -- stylua = formatting.stylua.with({
  --  extra_args = { "--config-path", vim.fn.expand(Fau_vim.config_path .. "/configuration/stylua.toml") },
  -- }),

  -- lua_format = formatting.lua_format.with({
  --  extra_args = { "--config", vim.fn.expand("~/.config/nvim/configuration/.lua-format") }
  -- }),


  -- -----------------------------------
  -- -------- Python
  -- -----------------------------------
  flake8 = require("none-ls.diagnostics.flake8").with({
    extra_args = { "--config", Fau_vim.config_path .. "/configuration/tox.ini" },
  }),

  -- pydocstyle = require("none-ls.diagnostics.pydocstyle").with({
  --   extra_args = { "--config", Fau_vim.config_path .. "/configuration/tox.ini" },
  -- }),

  -- djlint = null_ls.builtins.diagnostics.djlint.with({
  --   filetypes = { "django", "jinja.html", "htmldjango", "html" }
  -- }),
  -- curlylint = require("none-ls.diagnostics.curlylint").with({
  --   filetypes = { "jinja.html", "htmldjango", "html" }
  -- }),

  -- mypy = null_ls.builtins.diagnostics.mypy,
  -- vulture = null_ls.builtins.diagnostics.vulture,

  -- black = require("none-ls.formatting.black"),


  -- -----------------------------------
  -- -------- C++
  -- -----------------------------------
  -- clang_format = null_ls.builtins.formatting.clang_format.with({
  --   extra_args = { "--style", "file:" .. Fau_vim.config_path .. "/configuration/.clang-format" }
  -- }),
}


local function get_available_sources()
  local available_sources = {}
  for source_name, source_config in pairs(sources) do
    if vim.fn.executable(source_name) == 1 then table.insert(available_sources, source_config) end
  end

  return available_sources
end


local config = { sources = get_available_sources() }


null_ls.setup(config)
