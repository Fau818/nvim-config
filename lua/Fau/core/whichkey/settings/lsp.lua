local modifyer = {  -- ni
	-- Document
	["<C-d>"] = { "<CMD>lua vim.lsp.buf.hover()<CR>", "Show Document" },

	-- Signature
	["<C-p>"] = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Show Signature" },

	-- Prev/Next Reference
	["<A-p>"] = { "<CMD>lua require('illuminate').next_reference{reverse=true,wrap=true}<CR>", "Prev Reference" },
	["<A-n>"] = { "<CMD>lua require('illuminate').next_reference{wrap=true}<CR>",							 "Next Reference" },
}



return {
	n = {
		modifyer,


		g = {
			name = "+LSP",
			-- Definition
			d = { "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>",       "Go To Definition" },
			D = { "<CMD>lua require('telescope.builtin').lsp_type_definitions() <CR>", "Go To Type Definition (Declaration)" },
			I = { "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>",   "Go To Implementation" },
			-- Reference
			r = { "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "Show References" },

			-- Diagnostic Info
			l = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Show Long Diagnostic Info" },

			-- Call
			i = { "<CMD>lua require('telescope.builtin').lsp_incoming_calls()<CR>", "Show Incoming Calls" },
			o = { "<CMD>lua require('telescope.builtin').lsp_outgoing_calls()<CR>", "Show Outgoing Calls" },
		},


		["<LEADER>l"] = {
			name = "+LSP",
			r = { "<CMD>lua vim.lsp.buf.rename()<CR>",      "Rename" },
			a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },

			-- Diagnostic Info
			d = { "<CMD>lua require('telescope.builtin').diagnostics({bufnr=0})<CR>", "Document Diagnostics" },
			D = { "<CMD>lua require('telescope.builtin').diagnostics()<CR>",          "Workspace Diagnostics" },

			-- Goto Prev/Next Diagnostics
			p = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Goto Prev Diagnostics" },
			n = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Goto Next Diagnostics" },

			-- Format
			f = { "<CMD>lua Fau_vim.functions.format()<CR>", "Format Code" },
			F = { "<CMD>lua vim.lsp.buf.format()<CR>",       "Format Code (Force Formatter)" },

			-- LSP Manager
			i = { "<CMD>LspInfo<CR>", "LspInfo" },
			I = { "<CMD>Mason<CR>",   "Mason" },

			-- Symbols
			s = { "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>",  "Buffer Symbols" },
			S = { "<CMD>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "Workspace Symbols" },

			-- Virtual Text
			v = { "<CMD>lua vim.diagnostic.config({virtual_text=not vim.diagnostic.config().virtual_text})<CR>", "Toggle Virtual Text" },

			-- Outline (Structure)
			o = { "<CMD>AerialToggle<CR>",  "Toggle Outline" },
			O = { "<CMD>AerialToggle!<CR>", "Toggle Outline (Unfocus)" },
		},

	},



	x = {
		["<LEADER>l"] = {
			name = "+LSP",
			-- Format
			f = { "<CMD>lua Fau_vim.functions.format()<CR><ESC>", "Format Code" },
			F = { "<CMD>lua vim.lsp.buf.format()<CR><ESC>",       "Format Code (Force Formatter)" },
		},
	},



	i = { modifyer }
}
