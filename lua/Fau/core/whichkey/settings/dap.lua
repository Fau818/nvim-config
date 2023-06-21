return {
  n = {
    -- From lunarvim
    ["\\"] = {
      name = "+Debug",
      t = { require('dap').toggle_breakpoint, "Toggle Breakpoint" },
      b = { require('dap').step_back,         "Step Back" },
      c = { require('dap').continue,          "Continue" },
      C = { require('dap').run_to_cursor,     "Run To Cursor" },
      d = { require('dap').disconnect,        "Disconnect" },
      g = { require('dap').session,           "Get Session" },
      i = { require('dap').step_into,         "Step Into" },
      o = { require('dap').step_over,         "Step Over" },
      u = { require('dap').step_out,          "Step Out" },
      p = { require('dap').pause,             "Pause" },
      r = { require('dap').repl.toggle,       "Toggle Repl" },
      s = { require('dap').continue,          "Start" },
      q = { require('dap').close,             "Quit" },
      U = { require('dapui').toggle,          "Toggle UI" },
    },

  }
}
