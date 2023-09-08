local Pkg     = require("mason-core.package")
local path    = require("mason-core.path")
local configs = require("lspconfig.configs")


if not configs["pylance"] then configs["pylance"] = require("Fau.core.lsp.settings.pylance") end


local function installer(ctx)
  local get_pylance = [[
    curl -s -c cookies.txt 'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance' > /dev/null &&
    curl -s 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/latest/vspackage'
      -j -b cookies.txt --compressed --output 'pylance.vsix' &&
    unzip pylance.vsix > /dev/null
  ]]

  local get_patcher = [[git clone https://github.com/MyFedora/pyspeer.git]]

  local patch_pylance = [[
    cd pyspeer && yarn --emoji=false && yarn --emoji=false rollup -c &&
    cd ../extension/dist &&
    cat ../../pyspeer/dist/pyspeer.min.js server.bundle.js > magic.js
  ]]

  local patch_pylance_tail = [[cd extension/dist && node magic.js > server.bundle.js || true]]  -- NOTE: will return 1, so || true

  get_pylance = get_pylance:gsub("\n", " ")
  get_patcher = get_patcher:gsub("\n", " ")
  patch_pylance = patch_pylance:gsub("\n", " ")
  patch_pylance_tail = patch_pylance_tail:gsub("\n", " ")

  ctx.receipt:with_primary_source(ctx.receipt.unmanaged)

  ctx.spawn.bash({ "-c", get_pylance })
  ctx.spawn.bash({ "-c", get_patcher })
  ctx.spawn.bash({ "-c", patch_pylance })
  ctx.spawn.bash({ "-c", patch_pylance_tail })

  ctx:link_bin("pylance", ctx:write_node_exec_wrapper("pylance", path.concat { "extension", "dist", "server.bundle.js" }))
end


return Pkg.new({
  name = "pylance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = installer,
})
