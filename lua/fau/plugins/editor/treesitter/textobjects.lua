return {
  select = {
    enable = true,
    lookahead = true,  -- automatically jump forward to textobj, similar to targets.vim

    keymaps = {
      -- NOTE: Manually set in lua/fau/plugins/editor/treesitter/init.lua
      -- You can use the capture groups defined in textobjects.scm
      -- ["af"] = { query = "@function.outer", desc = "Range: Around Function" },
      -- ["if"] = { query = "@function.inner", desc = "Range: Inner Function" },
      --
      -- ["ac"] = { query = "@class.outer", desc = "Range: Around Class" },
      -- ["ic"] = { query = "@class.inner", desc = "Range: Inner Class" },
      --
      -- ["as"] = { query = "@conditional.outer", desc = "Range: Around Scope" },
      -- ["is"] = { query = "@conditional.inner", desc = "Range: Inner Scope" },
    },

    selection_modes = {
      ["@function.outer"] = "v",
      ["@function.inner"] = "v",

      ["@class.outer"] = "v",
      ["@class.inner"] = "v",

      ["@conditional.inner"] = "v",
      ["@conditional.outer"] = "v",
    },

    -- include_surrounding_whitespace = function(query_string, selection_modes) end,
    include_surrounding_whitespace = false,
  },


  swap = {
    enable = false,
    swap_next     = { ["<leader>s"] = { query = "@parameter.inner", desc = "Textobjects: Swap Parameter with Next" }, },
    swap_previous = { ["<leader>S"] = { query = "@parameter.inner", desc = "Textobjects: Swap Parameter with Prev" }, },
  },


  move = {
    enable = true,
    set_jumps = true,  -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]]"] = { query = { "@function.outer", "@class.outer" }, desc = "Goto: Next Code Block Start" },
      ["]f"] = { query = "@function.outer",                     desc = "Goto: Next Function Start" },
      ["]c"] = { query = "@class.outer",                        desc = "Goto: Next Class Start" },
    },
    goto_next_end = {
      ["]}"] = { query = { "@function.outer", "@class.outer" }, desc = "Goto: Next Code Block End" },
      ["]F"] = { query = "@function.outer",                     desc = "Goto: Next Function End" },
      ["]C"] = { query = "@class.outer",                        desc = "Goto: Next Class End" },
    },
    goto_previous_start = {
      ["[["] = { query = { "@function.outer", "@class.outer" }, desc = "Goto: Prev Code Block Start" },
      ["[f"] = { query = "@function.outer",                     desc = "Goto: Prev Function Start" },
      ["[c"] = { query = "@class.outer",                        desc = "Goto: Prev Class Start" },
    },
    goto_previous_end = {
      ["[{"] = { query = { "@function.outer", "@class.outer" }, desc = "Goto: Prev Code Block End" },
      ["[F"] = { query = "@function.outer",                     desc = "Goto: Prev Function End" },
      ["[C"] = { query = "@class.outer",                        desc = "Goto: Prev Class End" },
    },
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
