---@type LazySpec
return {
  -- DESC: Auto remove trailing whitespaces and empty lines.
  ---@module "mini.trailspace"
  "echasnovski/mini.trailspace",
  event = "BufWritePre",

  init = function()
    fvim.format._trim_text_source = "mini"

    vim.api.nvim_create_autocmd("FileType", {
      pattern = fvim.file.excluded_filetypes,
      desc = "Disable trailspace in some filetypes.",
      callback = function() vim.b.minitrailspace_disable = true end,
    })
  end,

  opts = { only_in_normal_buffers = true },
}
