return {
  n = {
    ["<C-r>"] = { "<CMD>RunFile toggleterm<CR>", "Run File in Toggleterm" },

    ["<LEADER>r"] = {
      name = "+Runcode",

      t = { "<CMD>RunFile term<CR>",   "Run File in Terminal" },
      T = { "<CMD>RunFile toggle<CR>", "Run File Toggle" },
      f = { "<CMD>RunFile float<CR>",  "Run File in Float" },

      c = { "<CMD>RunClose<CR>", "Run Close" },

      p = { "<CMD>RunProject toggleterm<CR>", "Run Project in Toggleterm" },


      e = {
        name = "+Edit Config",

        f = { "<CMD>CRFiletype<CR>", "Edit FileType Config" },
        p = { "<CMD>CRProjects<CR>", "Edit Project Config" },
      }
    }
  }
}
