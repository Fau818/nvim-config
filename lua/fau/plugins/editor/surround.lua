---@type LazySpec
return {
  -- DESC: Quickly add, modify, and remove surround.
  ---@module "nvim-surround"
  "kylechui/nvim-surround",
  vscode = true,

  init = function() vim.g.nvim_surround_no_mappings = true end,

  keys = {
    { "s",  "<Plug>(nvim-surround-normal)",          mode = "n", desc = "Surround" },
    { "ss", "<Plug>(nvim-surround-normal-cur)",      mode = "n", desc = "Surround Line" },
    { "S",  "<Plug>(nvim-surround-normal-cur-line)", mode = "n", desc = "Surround (New Lines)" },

    { "s",  "<Plug>(nvim-surround-visual)",          mode = "x", desc = "Surround" },
    { "S",  "<Plug>(nvim-surround-visual-line)",     mode = "x", desc = "Surround (New Lines)" },

    { "ds", "<Plug>(nvim-surround-delete)",          mode = "n", desc = "Delete Surround" },
    { "cs", "<Plug>(nvim-surround-change)",          mode = "n", desc = "Change Surround" },
    { "cS", "<Plug>(nvim-surround-change-line)",     mode = "n", desc = "Change Surround (New Lines)" },
  },

  ---@type user_options
  opts = {
    surrounds = {
      ["e"] = {
        add = { "**", "**" },
        find = "%*%*[^*]+%*%*",
        delete = "^(%*%*)().-(%*%*)()$",
      },
      ["h"] = {
        add = { "==", "==" },
        find = "==[^=]+==",
        delete = "^(==)().-(==)()$",
      },
    },

    aliases = {
      -- NOTE: `i` for input;  `t/T` for tag;  `f` for function
      ["B"] = "{",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },

    move_cursor = "sticky",  ---@type "begin" | "sticky" | boolean
  },

}
