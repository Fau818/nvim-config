---@type LazyPluginSpec
return {
  -- DESC: Indent guide line with animation.
  ---@module "mini.indentscope"
  "echasnovski/mini.indentscope",
  vscode = true,
  event = { "BufReadPost", "BufNewFile" },

  init = function()
    local group = vim.api.nvim_create_augroup("MiniIndentscopeConfig", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "python",
      desc = "Config mini.indentscope for python.",
      callback = function(args) vim.b[args.buf].miniindentscope_config = { options = { border = "top" } } end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = fvim.file.excluded_filetypes,
      desc = "Disable indentscope in excluded filetypes.",
      callback = function(args) vim.b[args.buf].miniindentscope_disable = true end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      desc = "Disable indentscope in non regular buffers.",
      callback = function(args) vim.b[args.buf].miniindentscope_disable = vim.bo[args.buf].buftype ~= "" end,
    })
  end,

  opts = {
    draw = {
      delay = fvim.settings.debounce.indentscope,
      animation = nil,  -- Use default.
      predicate = nil,  -- Use default.
      priority = 2,
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Textobjects
      object_scope             = "ii",
      object_scope_with_border = "ai",

      -- Motions (jump to respective border line; if not present - body line)
      goto_top    = "[i",
      goto_bottom = "]i",
    },

    -- Options which control scope computation
    options = {
      -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
      border           = "both",
      n_lines          = 10000,
      indent_at_cursor = false,
      try_as_border    = true,
    },

    symbol = fvim.icons.ui.IndentLine,
  },
}
