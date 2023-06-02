local util = require('lspconfig.util')


local root_files = {
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac', -- AutoTools
}


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

    "--offset-encoding=utf-16",
  },

  root_dir = function(fname)
    local root = util.root_pattern(unpack(root_files))(fname)
    if root and root ~= vim.env.HOME then return root end
    return util.find_git_ancestor(fname)
  end,
}
