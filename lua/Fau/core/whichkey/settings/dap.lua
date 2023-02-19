return {
  n = {
    -- From lunarvim
    ["\\"] = {
      name = "+Debug",
      t = { "<CMD>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
      b = { "<CMD>lua require'dap'.step_back()<CR>",         "Step Back" },
      c = { "<CMD>lua require'dap'.continue()<CR>",          "Continue" },
      C = { "<CMD>lua require'dap'.run_to_cursor()<CR>",     "Run To Cursor" },
      d = { "<CMD>lua require'dap'.disconnect()<CR>",        "Disconnect" },
      g = { "<CMD>lua require'dap'.session()<CR>",           "Get Session" },
      i = { "<CMD>lua require'dap'.step_into()<CR>",         "Step Into" },
      o = { "<CMD>lua require'dap'.step_over()<CR>",         "Step Over" },
      u = { "<CMD>lua require'dap'.step_out()<CR>",          "Step Out" },
      p = { "<CMD>lua require'dap'.pause()<CR>",             "Pause" },
      r = { "<CMD>lua require'dap'.repl.toggle()<CR>",       "Toggle Repl" },
      s = { "<CMD>lua require'dap'.continue()<CR>",          "Start" },
      q = { "<CMD>lua require'dap'.close()<CR>",             "Quit" },
      U = { "<CMD>lua require'dapui'.toggle()<CR>",          "Toggle UI" },
    },

  }
}
