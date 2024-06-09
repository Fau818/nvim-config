local Pkg     = require("mason-core.package")
local path    = require("mason-core.path")
local configs = require("lspconfig.configs")


if not configs["delance"] then configs["delance"] = require("Fau.core.lsp.settings.delance_default") end


return Pkg.new({
  name = "delance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = function() vim.notify("Please install delance manually") end,
})
