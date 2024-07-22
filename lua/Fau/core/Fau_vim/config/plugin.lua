return {
  copilot = { enable = vim.loop.fs_stat(string.format("%s/github-copilot/hosts.json", Fau_vim.xdg_config_home)) and true or false },

  -- TODO: Remove [TODO date: July 22, 2024]
  trouble = { tag = nil },

  openai  = {
    api_path  = ("%s/apikey"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
    host_path = ("%s/host"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
  },
}
