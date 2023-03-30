return {
  settings = {
    pylsp = {
      configurationSources = {},

      plugins = {
        flake8 = {
          enabled = false,
          config = Fau_vim.config_path .. "/configuration/tox.ini",
          -- exclude = nil,
          -- executable = nil,
          -- filename = nil,
          -- hangClosing = nil,
          -- ignore = nil,
          -- maxComplexity = nil,
          -- maxLineLength = nil,
          -- indentSize = nil,
          -- perFileIgnores = nil,
          -- select = nil,
        },

        pydocstyle = {
          enabled = false,
          -- convention = nil,
          -- addIgnore = nil,
          -- addSelect = nil,
          -- ignore = {
          --   "D100", "D101", "D102", "D103", "D104", "D105",
          --   "D107", "D200", "D203", "D212", "D414", "D417",
          -- },
          -- select = nil,
          -- match = nil,
          -- matchDir = nil,
        },

        preload = {
          enabled = true,
          modules = { "numpy" }
        },


        rope_autoimport = {
          enabled = false,
          memory = true
        },
        rope_completion = {
          enabled = false,
          eager = true
        },


        autopep8 = { enabled = false },
        pycodestyle = { enabled = false, },
        pyflakes    = { enabled = false },
        pylint      = { enabled = false },
        mccabe      = { enabled = false },
        yapf = { enabled = false },

        jedi = {
          auto_import_modules = {},
          extra_paths = { "/usr/local/lib/python3.10/site-packages" },
          env_vars = nil,
          environment = nil,
        },

        jedi_completion = {
          enabled = true,
          include_params = false,
          include_class_objects    = true,
          include_function_objects = true,
          fuzzy = true,
          eager = true,
          resolve_at_most = 25,
          cache_for = { "numpy", "pandas", "torch", "matplotlib", "sklearn" },
        },

        jedi_definition = {
          enabled = true,
          follow_imports = true,
          follow_builtin_imports = true,
          follow_builtin_definitions = true,
        },

        jedi_hover = { enabled = true },
        jedi_references = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_symbols = {
          enabled = true,
          all_scopes = true,
          include_import_symbols = true,
        },


      }
    }
  }
}
