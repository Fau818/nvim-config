local Pkg     = require("mason-core.package")
local path    = require("mason-core.path")
local configs = require("lspconfig.configs")


if not configs["pylance"] then configs["pylance"] = require("Fau.core.lsp.settings.pylance_default") end


local function installer(ctx)
  local sed_binary = Fau_vim.os_name == "Darwin" and "gsed" or "sed"
  -- Download
  local script = [[
    curl -s -c cookies.txt 'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance' > /dev/null &&
    curl -s "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/latest/vspackage"
         -j -b cookies.txt --compressed --output "pylance.vsix"
  ]]
  ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
  ctx.spawn.bash({ "-c", script:gsub("\n", " ") })
  ctx.spawn.unzip({ "pylance.vsix" })
  -- Patch
  ctx.spawn.bash { "-c", sed_binary .. [[ -i "0,/\(if(\!process\[[^] ]*\]\[[^] ]*\])return\!0x\)1/ s//\10/" extension/dist/server.bundle.js]] }
  ctx.spawn.bash { "-c", sed_binary .. [[ -i "0,/\(if(\!process\[.*\]\[.*\])return\!\)\[\]/ s//\10x0/" extension/dist/server.bundle.js]] }
  ctx.spawn.bash { "-c", sed_binary .. [[ -i -E "s/;_0x[0-9a-f]+\[.*\+'nt'\]=function\(_0x[0-9a-f]+\)\{/&return;/" extension/dist/server.bundle.js]] }
  ctx.spawn.bash { "-c", sed_binary .. [[ -i "0,/\(throw new Error(.*);}\)/ s//return;\1/" extension/dist/server.bundle.js]] }
  -- Link
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
