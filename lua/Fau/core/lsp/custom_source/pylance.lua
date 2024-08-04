local Pkg     = require("mason-core.package")
local path    = require("mason-core.path")
local configs = require("lspconfig.configs")


if not configs["pylance"] then configs["pylance"] = require("Fau.core.lsp.settings.pylance_default") end


local function installer(ctx)
  -- ==================== Scripts ====================
  -- local sed_binary = Fau_vim.os_name == "Darwin" and "gsed" or "sed"
  -- Download
  local download = [[
    curl -s -c cookies.txt 'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance' > /dev/null &&
    curl -s "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/latest/vspackage"
         -j -b cookies.txt --compressed --output "pylance.vsix"
  ]]
  -- Edit
  local edit = [[ perl -pe 's/if\(!process.*?\)return!\[\];/if(false)return false;/g; s/throw new//g' extension/dist/server.bundle.js > extension/dist/server.nvim.js ]]


  -- ==================== Handle ====================
  ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
  -- Download
  ctx.spawn.bash({ "-c", download:gsub("\n", " ") })
  ctx.spawn.unzip({ "pylance.vsix" })
  -- Patch
  ctx.spawn.bash { "-c", edit:gsub("\n", " ") }
  -- Link
  ctx:link_bin("pylance", ctx:write_node_exec_wrapper("pylance", path.concat { "extension", "dist", "server.nvim.js" }))
end


return Pkg.new({
  name = "pylance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = installer,
})
