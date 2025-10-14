return {
  ---Get conda path.
  ---@return string?
  get_conda_path = function()
    -- CASE 1: Get from environment variable.
    local conda_root = os.getenv("CONDA_ROOT")
    if conda_root then return conda_root end

    -- CASE 2: Get from the default path list.
    local path_list = nil
    if Fau_vim.os_name == "Darwin" then  -- MacOS
      path_list = { "/usr/local/Caskroom/miniconda/base", "/opt/homebrew/Caskroom/miniconda/base" }
    else  -- Linux
      path_list = {
        ("%s/miniconda3"):format(os.getenv("HOME")),
        ("%s/.local/miniconda3"):format(os.getenv("HOME")),
        ("%s/.local/share/miniconda3"):format(os.getenv("HOME")),
        "/usr/local/miniconda3",
      }
    end
    for _, path in ipairs(path_list) do if vim.uv.fs_stat(path) ~= nil then return path end end
  end,
}
