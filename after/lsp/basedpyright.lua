local root_markers = { { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" }, ".git" }

local venv_names = { ".venv", "venv.nosync", "venv" }

---First `venv_names` entry under `root_dir` that actually holds an interpreter.
---@param root_dir string
---@return string? python_bin
local function venv_python(root_dir)
  for _, name in ipairs(venv_names) do
    local python_bin = root_dir .. "/" .. name .. "/bin/python"
    if vim.fn.executable(python_bin) == 1 then return python_bin end
  end
end

---Root of the running client whose project dir or live interpreter's env dir contains `bufname`
---(conda and out-of-project venvs keep site-packages and stdlib under the env dir, not the root).
---Longest match wins; reading it live keeps this in step with `reconfigure_python_path`.
---@param bufname string
---@return string? root_dir
local function owner_root(bufname)
  local best_root, best_len = nil, -1
  for _, client in ipairs(vim.lsp.get_clients({ name = "basedpyright" })) do
    local root_dir = client.config.root_dir
    local python_bin = vim.tbl_get(client.settings or {}, "python", "pythonPath")
    local env_dir = python_bin and vim.fn.fnamemodify(python_bin, ":h:h")
    for _, dir in ipairs(env_dir and { root_dir, env_dir } or { root_dir }) do
      if #dir > best_len and vim.fs.relpath(dir, bufname) then best_root, best_len = root_dir, #dir end
    end
  end
  return best_root
end

---Where to root a dependency file that no client owns yet. Stopping at the library dir keeps
---the marker walk from climbing into an unrelated repo above it (Homebrew's own `.git`). The
---third pattern is the stdlib dir itself -- `typing.py` and friends sit directly under it.
---@param bufname string
---@return string? root_dir
local function library_boundary(bufname)
  return bufname:match("^(.*/site%-packages)/")
    or bufname:match("^(.*/dist%-packages)/")
    or bufname:match("^(.*/lib/python%d+%.%d+)/")
end

---@type vim.lsp.Config
return {
  -- Matching an owning client's root_dir is what makes the default `reuse_client` attach to
  -- it instead of spawning a second server. Else a library boundary, else the marker walk.
  root_dir = function(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(owner_root(bufname) or library_boundary(bufname) or vim.fs.root(bufnr, root_markers))
  end,

  -- basedpyright only finds `<root_dir>/.venv` unaided; other names silently fall back to `python3`
  -- on PATH, breaking every import with no other symptom. `VIRTUAL_ENV` is only read as a literal
  -- `${env:VIRTUAL_ENV}` off Neovim's own env -- one value for every project. So resolve per root
  -- here; nil leaves the PATH tiers in charge, and a conda mapping still wins (fau/autocmd.lua).
  before_init = function(_, config)
    if not config.root_dir then return end

    local settings = config.settings or {}
    settings.python = settings.python or {}
    settings.python.pythonPath = venv_python(config.root_dir)
    config.settings = settings
  end,

  -- NOTE: LSP settings may be ignored. (More info in the link below.)
  -- SEE: https://docs.basedpyright.com/v1.36.1/configuration/config-files/#overriding-language-server-settings
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

        -- ==================== pyproject.toml ====================
        exclude = nil,  -- NOTE: Use default; and don't change it if it's not necessary since there a special mechianism only works when exclude is nil.
        -- extraPaths = nil,  -- Use default.
        -- stubPath = nil,  -- Use default.
        stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
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
