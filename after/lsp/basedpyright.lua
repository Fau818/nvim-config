local root_markers = { { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" }, ".git" }

---Find the root of the running client that owns `bufname`: the one whose project dir or live interpreter env dir contains it, longest match first.
---@param bufname string
---@return string? root_dir The owning client's root, or nil if no client contains the file.
local function find_owner_root(bufname)
  local best_root, best_len = nil, -1
  for _, client in ipairs(vim.lsp.get_clients({ name = "basedpyright" })) do
    local root_dir = client.config.root_dir
    local python_bin = vim.tbl_get(client.settings or {}, "python", "pythonPath")
    -- NOTE: Conda and out-of-project venvs keep site-packages under the env dir, not under the root.
    local env_dir = python_bin and vim.fn.fnamemodify(python_bin, ":h:h")

    for _, dir in ipairs(env_dir and { root_dir, env_dir } or { root_dir }) do
      if #dir > best_len and vim.fs.relpath(dir, bufname) then best_root, best_len = root_dir, #dir end
    end
  end
  return best_root
end

---@type vim.lsp.Config
return {
  ---Reusing an owner's root makes `reuse_client` attach to it instead of starting a second server.
  ---The library dir keeps the marker walk out of an unrelated repo above it (Homebrew's `.git`).
  root_dir = function(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(find_owner_root(bufname) or fvim.python.library_root(bufnr) or vim.fs.root(bufnr, root_markers))
  end,

  ---Set it before initialization, so the server never analyzes the project on the wrong interpreter.
  ---basedpyright finds only `.venv` by itself, and `${env:VIRTUAL_ENV}` is one value for every project.
  before_init = function(_, config)
    if not config.root_dir then return end

    local python_path, shadowed_venv = fvim.python.resolve_path(config.root_dir)
    if shadowed_venv then
      fvim.notify(("Conda env and local venv both found for %s\n  using:   %s\n  ignored: %s"):format(
        vim.fn.fnamemodify(config.root_dir, ":~"),
        python_path,
        shadowed_venv
      ), vim.log.levels.WARN)
    end

    local settings = config.settings or {}
    settings.python = settings.python or {}
    settings.python.pythonPath = python_path
    config.settings = settings
  end,

  -- SEE: https://docs.basedpyright.com/latest/configuration/language-server-settings/
  settings = {
    python = { pythonPath = nil, venvPath = nil },
    basedpyright = {
      disableLanguageServices = false,
      disableOrganizeImports = true,  -- Ruff does this.
      disableTaggedHints = false,

      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,

        diagnosticMode = "openFilesOnly",  ---@type "openFilesOnly" | "workspace"
        logLevel = "Information",  ---@type "Error" | "Warning" | "Information" | "Trace"

        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          callArgumentNamesMatching = false,
          functionReturnTypes = true,
          genericTypes = false,
        },

        useTypingExtensions = false,
        -- fileEnumerationTimeout = nil,  -- Use default.
        autoFormatStrings = true,  -- NOTE: Neovim doesn't support it yet. Planned for 0.12.

        -- configFilePath = nil,  -- Use default.


        -- ══════════════════ pyproject.toml ══════════════════

        exclude = nil,  -- NOTE: Use default; and don't change it if it's not necessary since there a special mechianism only works when exclude is nil.
        -- extraPaths = nil,  -- Use default.
        -- stubPath = nil,  -- Use default.
        stubPath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/python-type-stubs/stubs"),
        -- typeshedPaths = nil,  -- Use default.
        -- baselineFile = nil,  -- Use default.

        useLibraryCodeForTypes = true,

        typeCheckingMode = "recommended",  ---@type "off"|"basic"|"standard"|"strict"|"recommended"|"all"

        ---@type table<string, "error"|"warning"|"information"|"hint"|"none"|boolean>
        diagnosticSeverityOverrides = {
          reportUnusedCallResult = "none",
          reportUnusedParameter  = "hint",
          reportUnusedVariable   = "hint",
          reportUnusedImport     = "hint",

          reportUnreachable      = "information",

          reportMissingTypeStubs = "hint",
          reportMissingTypeArgument = "hint",
          reportMissingParameterType = "hint",

          reportUnannotatedClassAttribute = "hint",

          reportAny = "none",
          reportUnknownVariableType = "none",
          reportUnknownArgumentType = "none",
          reportUnknownMemberType = "none",
          reportUnknownParameterType = "none",

          reportArgumentType = "warning",

          reportConstantRedefinition = "information",
          reportOperatorIssue = "warning",

          reportAttributeAccessIssue = "warning",
        }
      },
    },
  },
}
