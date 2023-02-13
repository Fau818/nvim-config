-- =============================================
-- ========== Plugin Loading
-- =============================================
-- -----------------------------------
-- -------- Necessary
-- -----------------------------------
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then Fau_vim.load_plugin_error("lspconfig") return end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then Fau_vim.load_plugin_error("cmp_nvim_lsp") return end

local mlspconfig_ok, mlspconfig = pcall(require, "mason-lspconfig")
if not mlspconfig_ok then Fau_vim.load_plugin_error("mason-lspconfig") return end


-- -----------------------------------
-- -------- Unnecessary
-- -----------------------------------
local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then illuminate = nil end

local inlayhints_ok, inlayhints = pcall(require, "lsp-inlayhints")
if not inlayhints_ok then inlayhints = nil end

local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then navic = nil end



-- =============================================
-- ========== Configuration
-- =============================================
local default_servers = { "lua_ls", "pyright", "clangd" }
if mlspconfig then mlspconfig.setup({ ensure_installed = default_servers, automatic_installation = true }) end


local available_servers = mlspconfig.get_installed_servers()

local function is_available(client_name)
	for _, server_name in pairs(available_servers) do if server_name == client_name then return true end end
	return false
end


local function server_attach(client, bufnr)
	-- disable lsp formatting
	-- if client.name == "clangd" then client.server_capabilities.documentFormattingProvider = false end

	-- for highlight support
	if illuminate then illuminate.on_attach(client) end

	-- for inlayhints support
	if inlayhints then inlayhints.on_attach(client, bufnr, false) end

	-- for breadcrumb support
	if navic then navic.attach(client, bufnr) end
end


local function setup_server(server)
	local opts = {
		capabilities = cmp_nvim_lsp.default_capabilities(),
		on_attach = server_attach,
	}

	-- load custom settings
	local settings_ok, setting_opts = pcall(require, "Fau.core.lsp.settings." .. server)
	if settings_ok then opts = vim.tbl_deep_extend("force", opts, setting_opts) end

	-- setup LSP
	lspconfig[server].setup(opts)
end


Fau_vim.functions.lsp.set_client_by_ft = function()
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	if Fau_vim.configured_ft[filetype] then return end -- configured
	Fau_vim.configured_ft[filetype] = true

	-- TODO: need to be optimized
	if filetype == "jinja.html" or filetype == "htmldjango" then filetype = "html" end

	local clients = mlspconfig.get_available_servers({ filetype=filetype })

	-- config current filetype LS
	for _, client in pairs(clients) do if is_available(client) then setup_server(client) end end

	vim.api.nvim_command("LspStart")
end


-- =============================================
-- ========== Alternative Setup
-- =============================================
-- if mlspconfig then mlspconfig.setup_handlers({ function(server_name) setup_server(server_name) end })
-- else
-- 	-- Loading every server in servers list
-- 	for _, server in pairs(default_servers) do setup_server(server) end
-- end
