---@type LazySpec
return
{
  -- DESC: Auto remove trailing whitespaces and empty lines.
  "echasnovski/mini.trailspace",
  event = "BufWritePre",

  init = function()
    Fau_vim.functions.format.remove_blank_lines_and_spaces = function()
      local trailspace = require("mini.trailspace")
      trailspace.trim_last_lines(); trailspace.trim()
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = Fau_vim.file.excluded_filetypes,
      group = "Fau_vim",
      desc = "Disable trailspace in some filetypes.",
      callback = function() vim.b.minitrailspace_disable = true end,
    })
  end,

  opts = { only_in_normal_buffers = true },
}
