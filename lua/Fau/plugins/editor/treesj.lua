---@type LazySpec
return {
  -- DESC: Splitting and joining block of code.
  ---@module "treesj"
  "Wansmer/treesj",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cond = true,

  cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
  keys = { { "sj", "<CMD>TSJToggle<CR>", mode = "n", desc = "Treesj: Split and Join" } },

  opts = {
    ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
    use_default_keymaps = false,

    ---@type boolean Node with syntax error will not be formatted
    check_syntax_error = true,

    ---If line after join will be longer than max value,
    ---@type number If line after join will be longer than max value, node will not be formatted
    max_join_length = 200,

    ---Cursor behavior:
    ---hold - cursor follows the node/place on which it was called
    ---start - cursor jumps to the first symbol of the node being formatted
    ---end - cursor jumps to the last symbol of the node being formatted
    ---@type "hold"|"start"|"end"
    cursor_behavior = "hold",

    ---@type boolean Notify about possible problems or not
    notify = true,

    ---@type boolean Use `dot` for repeat action
    dot_repeat = true,

    ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
    on_error = nil,

    ---@type table Presets for languages
    langs = { python = { dictionary = { join = { space_in_brackets = true } } } },
  },
}
