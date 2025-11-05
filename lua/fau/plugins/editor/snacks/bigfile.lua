---@class snacks.bigfile.Config
return {
  enabled = true,
  notify  = true,

  size = fvim.file.large_file_size,
  line_length = fvim.file.large_file_line,

  -- Enable or disable features when big file detected
  ---@param ctx {buf: integer, ft:string}
  setup = function(ctx)
    -- ==================== From Snacks ====================
    if vim.fn.exists(":NoMatchParen") ~= 0 then vim.cmd([[NoMatchParen]]) end
    Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
    vim.schedule(function() if vim.api.nvim_buf_is_valid(ctx.buf) then vim.bo[ctx.buf].syntax = ctx.ft end end)

    -- ==================== Custom ====================
    -- DIsable Snacks
    vim.b.snacks_indent = false
    vim.b.snacks_words  = false

    -- Disable mini
    vim.b.minitrailspace_disable  = true
    vim.b.miniindentscope_disable = true
    vim.b.minianimate_disable     = true

    -- Disable undo
    vim.opt_local.undofile   = false

    -- Extra ...
    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false
    vim.opt_local.mousemoveevent = false
  end,
}
