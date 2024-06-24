local conda = require("Fau.configs.editor.telescope.config.extensions.conda")

return {
  fzf = {
    fuzzy = true,                    -- false will only do exact matching
    override_generic_sorter = true,  -- override the generic sorter
    override_file_sorter = true,     -- override the file sorter
    case_mode = "smart_case",        ---@type "smart_case"|"ignore_case"|"respect_case"
  },

  conda = { anaconda_path = conda.get_conda_path() },
}
