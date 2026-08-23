---@type vim.lsp.Config
return { cmd_env = { SHUCK_CONFIG_HOME = vim.fs.joinpath(fvim.nvim_config_path, "configuration") } }
