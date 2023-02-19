return {
  settings = {
    pylsp = {
      configurationSources = {},

      plugins = {
        autopep8    = { enabled = false },
        flake8      = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes    = { enabled = false },
        pylint      = { enabled = false },
        mccabe      = { enabled = false },
        preload     = { enabled = false },
        rope_autoimport = { enabled = false },
        rope_completion = { enabled = false },
        yapf = { enabled = false },

        jedi = {
          auto_import_modules = {
            "os", "time",
            "numpy", "pandas"
          },
          -- extra_paths = {},
          -- env_vars = ,
          -- environment = "",
        },

        jedi_completion = {
          enabled = false,
          include_params = true,
          include_class_objects = true,
          include_function_objects = true,
          fuzzy = true,
          eager = true,
          -- resolve_at_most = 25,
          -- cache_for = {},
        },

        jedi_definition = {
          enabled = false,
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
