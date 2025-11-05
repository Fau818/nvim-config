return {
  settings = {
    clangd = {
      -- arguments = { },

      checkUpdates = false,
      restartAfterCrash = true,  -- Auto restart clangd (up to 4 times) if it crashes.

      onConfigChanged = "prompt",  ---@type "prompt"|"restart"|"ignore"
      semanticHighlighting = true,  -- Enable semantic highlighting in clangd.
      serverCompletionRanking = true,

      detectExtensionConflicts = true,
    }
  },

  cmd = {
    "clangd",

    "--enable-config=true",

    "--header-insertion=never",

    "--clang-tidy",

    "--completion-parse=always",
    "--completion-style=bundled",

    "--function-arg-placeholders=false",

    "--header-insertion-decorators",

    "--offset-encoding=utf-16",
  },
}
