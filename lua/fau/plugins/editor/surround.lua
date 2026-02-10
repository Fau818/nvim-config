---@type LazySpec
return {
  -- DESC: Quickly add, modify, and remove surround.
  ---@module "nvim-surround"
  "kylechui/nvim-surround",
  vscode = true,

  keys = {
    { "s",  mode = { "n", "x" }, desc = "+Surround" }, { "S",  mode = { "n", "x" }, desc = "+SURROUND" },
    { "cs", desc = "+Change Surround" }, { "ds", desc = "+Delete Surround" },
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

    keymaps = {
      insert      = false,
      insert_line = false,

      normal          = "s",
      normal_cur      = "ss",
      normal_line     = false,
      normal_cur_line = "S",

      visual      = "s",
      visual_line = "S",

      delete = "ds",

      change      = "cs",
      change_line = "cS",
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
