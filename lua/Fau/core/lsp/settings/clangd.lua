return {
  settings = {
    clangd = {
      -- arguments = { },
      checkUpdates = false,
      detectExtensionConflicts = true,
      -- fallbackFlags = {  },
      onConfigChanged = "prompt",  -- values: prompt|restart|ignore  (if clangd 12+, will be ignored)
      -- path = "clangd",
      restartAfterCrash = true,  -- Auto restart clangd (up to 4 times) if it crashes.
      semanticHighlighting = true,  -- Enable semantic highlighting in clangd.
      serverCompletionRanking = true,
      -- trace = ""
    }
  },

  cmd = {
    "clangd",

    -- "--all-scopes-completion=false"
    "--header-insertion=never",

    "--clang-tidy",

    "--completion-parse=always",
    "--completion-style=bundled",

    "--function-arg-placeholders=false",

    "--header-insertion-decorators",
  },

}
