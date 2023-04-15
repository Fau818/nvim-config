return {
  settings = {
    clangd = {
      -- arguments = { },
      -- path = "clangd",

      checkUpdates = false,
      restartAfterCrash = true,  -- Auto restart clangd (up to 4 times) if it crashes.

      onConfigChanged = "prompt",  -- values: prompt|restart|ignore  (if clangd 12+, will be ignored)
      semanticHighlighting = true,  -- Enable semantic highlighting in clangd.
      serverCompletionRanking = true,

      detectExtensionConflicts = true,
    }
  },

  cmd = {
    "clangd",

    "--header-insertion=never",

    "--clang-tidy",

    "--completion-parse=always",
    "--completion-style=bundled",

    "--function-arg-placeholders=false",

    "--header-insertion-decorators",
  },

}
