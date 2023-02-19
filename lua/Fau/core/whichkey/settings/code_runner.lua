return {
  n = {
    ["<C-r>"] = { "<CMD>update<CR><CMD>RunFile toggleterm<CR>", "Run File in Toggleterm" },

    ["<LEADER>r"] = {
      name = "+Runcode",

      t = { "<CMD>update<CR><CMD>RunFile term<CR>",   "Run File in Terminal" },
      T = { "<CMD>update<CR><CMD>RunFile toggle<CR>", "Run File Toggle" },
      f = { "<CMD>update<CR><CMD>RunFile float<CR>",  "Run File in Float" },

      c = { "<CMD>RunClose<CR>", "Run Close" },

      p = { "<CMD>update<CR><CMD>RunProject toggleterm<CR>", "Run Project in Toggleterm" },


      e = {
        name = "+Edit Config",

        f = { "<CMD>CRFiletype<CR>", "Edit FileType Config" },
        p = { "<CMD>CRProjects<CR>", "Edit Project Config" },
      }
    }
  }
}
