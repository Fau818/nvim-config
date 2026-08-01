local conda = require("fau.functions.conda")
local preset = require("fau.plugins.editor.snacks.picker.sources.preset")

local M = {}


---@type snacks.picker.Config
M.conda_picker = {
  title = "Conda Environment",

  finder = function(opts, ctx) return conda.get_conda_envs() end,

  format = function(item, picker)
    return {
      { string.format("%-12s", item.name), "SnacksPickerFile" },
      { item.path, "SnacksPickerDir" },
    }
  end,

  actions = {
    confirm = function(picker, item)
      local venv_name = os.getenv("CONDA_DEFAULT_ENV")
      local deactivating = venv_name == item.name
      if deactivating then conda.deactivate(item) else conda.activate(item) end
      picker:close()

      -- Reconfigure in place instead of restarting, which would spawn a new client and lose `conda_manual`.
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        local settings = client.settings
        if settings and settings.python then
          local python_path = vim.fs.joinpath(item.path, "bin/python")
          -- Deactivating falls back the way `before_init` would have: mapped env, else local venv, else PATH.
          if deactivating then
            local root_dir = client.config.root_dir
            python_path = root_dir and (conda.python_path_for(root_dir) or fvim.utils.find_venv_python(root_dir))
          end
          fvim.lsp.reconfigure_python_path(client, python_path)
          client.conda_manual = not deactivating or nil  -- deactivating hands the root back to the auto-mapping
        end
      end
    end,
  },

  layout = { preset = "vscode", layout = { height = #conda.get_conda_envs() + 3, max_height = 25 } },
  on_show = preset.normal_mode,
}


return M
