---@class snacks.bigfile.Config
return {
  enabled = true,
  notify  = true,

  size = Fau_vim.file.large_file_size,
  line_length = 1000,

  -- Enable or disable features when big file detected
  ---@param ctx {buf: integer, ft:string}
  setup = function(ctx)
    if vim.fn.exists(":NoMatchParen") ~= 0 then vim.cmd([[NoMatchParen]]) end
    Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
    vim.b.minianimate_disable = true

    vim.schedule(function() if vim.api.nvim_buf_is_valid(ctx.buf) then vim.bo[ctx.buf].syntax = ctx.ft end end)
  end,
}
