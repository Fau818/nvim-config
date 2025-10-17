return {
  copilot = { enable = vim.uv.fs_stat(string.format("%s/github-copilot", Fau_vim.xdg_config_home)) and true or false },

  openai  = {
    api_path  = ("%s/apikey"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
    host_path = ("%s/host"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
  },
}
