local Pkg  = require("mason-core.package")
local path = require("mason-core.path")


---@param ctx InstallContext
local function installer(ctx)
  -- ==================== Scripts ====================
  -- Download
  local coockies_url = "https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance"
  local download_url = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/latest/vspackage"
  local download = ([[curl -s -c cookies.txt "%s" > /dev/null && curl -s "%s" -j -b cookies.txt --compressed --output "pylance.vsix"]]):format(coockies_url, download_url)
  -- Edit
  local edit = [[perl -pe 's/if\(!process.*?\)return!\[\];/if(false)return false;/g; s/throw new//g' extension/dist/server.bundle.js > extension/dist/server.nvim.js]]

  -- ==================== Handle ====================
  -- Download
  ctx.spawn.bash({ "-c", download:gsub("\n", " ") })
  ctx.spawn.unzip({ "pylance.vsix" })
  -- Patch
  ctx.spawn.bash({ "-c", edit:gsub("\n", " ") })
  -- Link
  ctx:link_bin("fylance", ctx:write_node_exec_wrapper("fylance", path.concat({ "extension", "dist", "server.nvim.js" })))
end


local function get_fylance_version()
  local cmd = [[curl -s 'https://api.github.com/repos/microsoft/pylance-release/releases/latest' | grep '\"tag_name\"']]
  local handle = io.popen(cmd)
  if handle == nil then return nil end
  local result = handle:read("*a")
  handle:close()

  local tag_name = result:match('"tag_name"%s*:%s*"([^"]+)"')
  return tag_name
end

local version = get_fylance_version() or "latest"


return {
  name = "fylance",
  description = "Fast, feature-rich language support for Python",
  homepage = "https://github.com/microsoft/pylance",
  licenses = { "Apache-2.0" },
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },

  source = {
    id = "pkg:mason/fylance@" .. version,
    install = installer,
  },
  -- bin = { ["fylance"] = "extension/dist/server.nvim.js" },
}
