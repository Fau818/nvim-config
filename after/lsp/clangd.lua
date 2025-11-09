---@type vim.lsp.Config
return {
  settings = {
    clangd = {
      enable = true,
      enableCodeCompletion = true,
      enableHover = true,

      -- arguments = {},
      -- fallbackFlags = {},

      inactiveRegions = {
        opacity = 0.25,
        useBackgroundHighlight = false,
      },

      checkUpdates = false,
      detectExtensionConflicts = true,

      restartAfterCrash = true,  -- Auto restart clangd (up to 4 times) if it crashes.
      onConfigChanged = "prompt",  ---@type "prompt"|"restart"|"ignore"
      serverCompletionRanking = true,
    }
  },

  cmd = {
    "clangd",

    "--all-scopes-completion",

    "--background-index",
    "--background-index-priority=low",

    "--enable-config=true",

    "--header-insertion=never",
    "--header-insertion-decorators",

    "--clang-tidy",

    "--completion-parse=always",
    "--completion-style=bundled",

    "--function-arg-placeholders=false",
  },
}
