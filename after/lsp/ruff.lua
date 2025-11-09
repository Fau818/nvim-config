---@type vim.lsp.Config
return {
  init_options = {
    settings = {
      configuration = string.format("%s/configuration/pyproject.toml", fvim.nvim_config_path),
      configurationPreference = nil,  -- Use default.

      -- exclude = {},  -- Use default.
      -- lineLength = nil,  -- Use default.
      fixAll = true,
      organizeImports = true,
      showSyntaxErrors = true,

      logLevel = "info",  ---@type "trace"|"debug"|"info"|"warn"|"error"
      -- logFile = nil,  -- Use default.

      codeAction = {
        disableRuleComment = { enable = true },
        fixViolation = { enable = true },
      },

      lint = {
        enable = true,
        preview = false,
        -- select = {},  -- Use default.
        -- extend_select = {},  -- Use default.
        -- ignore = {},  -- Use default.
      },

      format = {
        preview = false,
        backend = "internal",  ---@type "internal" | "uv"
      },
    },
  },
}
