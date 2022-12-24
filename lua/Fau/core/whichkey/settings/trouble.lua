return {
	n = {
		["gt"] = {
			name = "+Trouble",

			-- Definition
			d = { "<CMD>Trouble lsp_definitions<CR>", "Go To Definition" },
			D = { "<CMD>Trouble lsp_type_definitions<CR>", "Go To Type Definition (Declaration)" },
			I = { "<CMD>Trouble lsp_implementations<CR>", "Go To Implementation" },
		},

		["<LEADER>t"] = {
			name = "+Trouble",

			-- Reference
			r = { "<CMD>Trouble lsp_references<CR>", "Show References" },

			-- Diagnostic Info
			d = { "<CMD>Trouble document_diagnostics<CR>", "Document Diagnostics" },
			D = { "<CMD>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },
		}
	}
}
