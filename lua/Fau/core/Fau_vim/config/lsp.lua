return {
  configured_ft = {},

  -- TODO: Configured in `ftplugin/`.
  packages = {
    lua    = { "lua-language-server" },
    python = { "pylance", "flake8", "pydocstyle" },
    json   = { "json-lsp" },
    sh     = { "bash-language-server" },
    yaml   = { "yaml-language-server" },
    go     = { "gopls" },
    html   = { "html-lsp" },
    docker = { "dockerfile-language-server" },
    dockerfile = { "dockerfile-language-server" },
  },
}
