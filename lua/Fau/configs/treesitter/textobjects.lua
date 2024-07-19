return {
  select = {
    enable = true,
    lookahead = true,  -- automatically jump forward to textobj, similar to targets.vim

    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = { query = "@function.outer", desc = "Around Function" },
      ["if"] = { query = "@function.inner", desc = "Innder Function" },

      ["ac"] = { query = "@class.outer", desc = "Around Class" },
      ["ic"] = { query = "@class.inner", desc = "Innder Class" },

      ["aC"] = { query = "@comment.outer", desc = "Around Comment" },
      ["iC"] = { query = "@comment.inner", desc = "Inner Comment" },

      ["as"] = { query = "@block.outer", desc = "Around Section" },
      ["is"] = { query = "@block.inner", desc = "Inner Section" },
    },

    selection_modes = {
      ["@function.outer"] = "V",
      ["@function.inner"] = "V",

      ["@class.outer"] = "V",
      ["@class.inner"] = "V",

      ["@comment.outer"] = "V",
      ["@comment.inner"] = "V",
    },

    -- include_surrounding_whitespace = function(query_string, selection_modes) end,
    include_surrounding_whitespace = false,
  },


  swap = {
    enable = false,
    swap_next     = { ["<leader>s"] = { query = "@parameter.inner", desc = "Swap Parameter with Next" }, },
    swap_previous = { ["<leader>S"] = { query = "@parameter.inner", desc = "Swap Parameter with Prev" }, },
  },


  move = {
    enable = true,
    set_jumps = true,  -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]]"] = { query = { "@function.outer", "@class.outer" }, desc = "Next Code Block Start" },
      ["]f"] = { query = "@function.outer",                     desc = "Next Function Start" },
      ["]c"] = { query = "@class.outer",                        desc = "Next Class Start" },
      ["]z"] = { query = "@fold", query_group = "folds",        desc = "Next Fold Start" },
      ["]s"] = { query = "@scope", query_group = "locals",      desc = "Next Scope Start" },
    },
    goto_next_end = {
      ["]}"] = { query = { "@function.outer", "@class.outer" }, desc = "Next Code Block End" },
      ["]F"] = { query = "@function.outer",                     desc = "Next Function End" },
      ["]C"] = { query = "@class.outer",                        desc = "Next Class End" },
      ["]Z"] = { query = "@fold", query_group = "folds",        desc = "Next Fold End" },
      ["]S"] = { query = "@scope", query_group = "locals",      desc = "Next Scope End" },
    },
    goto_previous_start = {
      ["[["] = { query = { "@function.outer", "@class.outer" }, desc = "Prev Code Block Start" },
      ["[f"] = { query = "@function.outer",                     desc = "Prev Function Start" },
      ["[c"] = { query = "@class.outer",                        desc = "Prev Class Start" },
      ["[z"] = { query = "@fold", query_group = "folds",        desc = "Prev Fold Start" },
      ["[s"] = { query = "@scope", query_group = "locals",      desc = "Prev Scope Start" },
    },
    goto_previous_end = {
      ["[{"] = { query = { "@function.outer", "@class.outer" }, desc = "Prev Code Block End" },
      ["[F"] = { query = "@function.outer",                     desc = "Prev Function End" },
      ["[C"] = { query = "@class.outer",                        desc = "Prev Class End" },
      ["[Z"] = { query = "@fold", query_group = "folds",        desc = "Prev Fold End" },
      ["[S"] = { query = "@scope", query_group = "locals",      desc = "Prev Scope End" },
    },

    -- Below will go to either the start or the end, whichever is closer.
    -- Use if you want more granular movements
    -- Make it even more gradual by adding multiple queries and regex.
    -- goto_next = { ["]d"] = "@conditional.outer", },
    -- goto_previous = { ["[d"] = "@conditional.outer", }
  },


  lsp_interop = {
    enable = false,
    border = "rounded",
    floating_preview_opts = {},
    peek_definition_code = {
      ["<leader>df"] = "@function.outer",
      ["<leader>dF"] = "@class.outer",
    },
  },
}
