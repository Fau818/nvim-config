local Pkg     = require("mason-core.package")
local path    = require("mason-core.path")
local configs = require("lspconfig.configs")


if not configs["pylance"] then configs["pylance"] = require("Fau.core.lsp.settings.pylance") end


local function installer(ctx)
  local script = [[
    curl -s -c cookies.txt 'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance' > /dev/null &&
    curl -s "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/2023.11.10/vspackage"
         -j -b cookies.txt --compressed --output "pylance.vsix"
  ]]
  ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
  ctx.spawn.bash({ "-c", script:gsub("\n", " ") })
  ctx.spawn.unzip({ "pylance.vsix" })

  local sed_binary = Fau_vim.os_name == "Darwin" and "gsed" or "sed"
  ctx.spawn.bash({
    "-c",
    sed_binary .. [[ -i "0,/\(if(\!process\[[^] ]*\]\[[^] ]*\])return\!0x\)1/ s//\10/" extension/dist/server.bundle.js]],
  })
  ctx.spawn.bash({
    "-c",
    sed_binary .. [[ -i -E "s/;_0x[0-9a-f]+\['verifyClie'\+'nt'\]=function\(_0x[0-9a-f]+\)\{/&return;/" extension/dist/server.bundle.js]],
  })
  ctx:link_bin(
    "pylance",
    ctx:write_node_exec_wrapper("pylance", path.concat({ "extension", "dist", "server.bundle.js" }))
  )
end


return Pkg.new({
  name = "pylance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = installer,
})
