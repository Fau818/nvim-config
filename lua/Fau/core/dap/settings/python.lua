return {
  adapters = {
    python = {
      type = "executable",
      command = "/usr/local/bin/python3",
      args = { "-m", "debugpy.adapter" },
    }
  },
  configurations = {
    python = {
      {
        -- The first three options are required by nvim-dap
        type = "python",
        request = "launch",
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function() return "/usr/local/bin/python3" end
        -- pythonPath = function()
        --  -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        --  -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        --  -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        --  local cwd = vim.fn.getcwd()
        --  if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        --    return cwd .. "/venv/bin/python"
        --  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        --    return cwd .. "/.venv/bin/python"
        --  else
        --    return "/usr/bin/python"
        --  end
        -- end,
      },
    }
  }
}
