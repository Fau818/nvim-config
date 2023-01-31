-- =============================================
-- ========== Plugin Loading
-- =============================================
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then Fau_vim.load_plugin_error("cmp") return end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then Fau_vim.load_plugin_error("luasnip") return end

local npairs_ok, npairs = pcall(require, "nvim-autopairs.completion.cmp")
if not npairs_ok then npairs = nil end



-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Luasnip
-- -----------------------------------
local luasnip_config = {
	history = false,
	region_check_events = "InsertEnter",
	delete_check_events = "InsertLeave"
}
luasnip.setup(luasnip_config)

-- require("luasnip/loaders/from_vscode").lazy_load()  -- for support friendly-snippets plugin
require("luasnip.loaders.from_snipmate").lazy_load()  -- for snipmate snippets


-- -----------------------------------
-- -------- cmp
-- -----------------------------------
local config = {
	enable = true,  -- Toggles the plugin on and off.
	snippet = { expand = function(args) luasnip.lsp_expand(args.body) end }, -- for loading custom snippets of luasnip
	performance = {
		debounce = 100,         -- popup menu delay
		throttle = 50,          -- refresh delay
		fetching_timeout = 500, -- fetching timeout
	},

	completion = {
		completeopt = "menu, menuone, noinsert",
		keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
		keyword_length = 1,
	},

	mapping = { -- custom mapping
		-- NOTE: the default mapping mode is 'insert'. like cmp.mapping(..., { "i" })

		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c", "s" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c", "s" }),

		["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c", "s" }),

		["<ESC>"] = cmp.mapping(cmp.mapping.close(), { "i", "s" }),
		["<C-c>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c", "s" }),

		["<TAB>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
				elseif luasnip.jumpable(1) then luasnip.jump(1)
				else fallback()
				end
			end, { "i", "s" }
		),
		["<S-TAB>"] = cmp.mapping(
			function(fallback)
				if luasnip.jumpable(-1) then luasnip.jump(-1)
				else fallback()
				end
			end, { "i", "s" }
		),
		["<CR>"] = cmp.mapping(
			function(fallback)
				if luasnip.jumpable(1) then while luasnip.jumpable(1) do luasnip.jump(1) end
				else fallback()
				end
			end, { "i", "s" }
		),
		["<C-Enter>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
				else fallback()
				end
			end, { "i", "s" }
		),

		["<UP>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then cmp.select_prev_item()
				else fallback()
				end
			end, { "i", "s", "c" }
		),
		["<DOWN>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then cmp.select_next_item()
				else fallback()
				end
			end, { "i", "s", "c" }
		),
	},

	formatting = {
		expandable_indicator = true,         -- Boolean to show the `~` expandable indicator in cmp's floating window.
		fields = { "kind", "abbr", "menu" }, -- An array of completion fields to specify their order.
		format = function(entry, vim_item)   -- The function used to customize the appearance of the completion menu.
			vim_item.kind = Fau_vim.icons.kind[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",

				-- treesitter = "[Treesitter]",
				conventionalcommits = "[Git]",
				buffer = "[Buffer]",

				path = "[Path]",
				-- nvim_lsp_signature_help = "[Param]",
			})[entry.source.name]

			-- limit the length of abbr
			vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, 30)
			return vim_item
		end,
	},

	sources = { -- The order of the sources determines their order in the completion results.
		{
			name = "nvim_lsp",
			-- disable snippets from LSP
			-- entry_filter = function(entry) return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind() end
		},
		{ name = "luasnip" },
		-- { name = "treesitter" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "conventionalcommits" }
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = { ghost_text = true },
}


cmp.setup(config)


-- for inserting '(' after select function or method item
if npairs ~= nil then cmp.event:on("confirm_done", npairs.on_confirm_done()) end


-- -----------------------------------
-- -------- cmp-cmdline
-- -----------------------------------
-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
	completion = {
		autocomplete = {},  -- values: InsertEnter|TextChanged
		completeopt = "menu, menuone, noselect"
	},
	mapping = {
		["<TAB>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then cmp.select_next_item()
				elseif not cmp.visible() then cmp.complete(); cmp.select_next_item()
				else fallback()
				end
			end, { "c" }
		),
	},
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	}
})


-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ "/", "?" }, {
	completion = {
		autocomplete = {},  -- values: InsertEnter|TextChanged
		completeopt = "menu, menuone, noselect"
	},
	mapping = {
		["<TAB>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then cmp.select_next_item()
				elseif not cmp.visible() then cmp.complete(); cmp.select_next_item()
				else fallback()
				end
			end, { "c" }
		),
	},
	sources = { { name = "buffer" } }
})
