-- =============================================
-- ========== Plugin Loading
-- =============================================
local telescope = Fau_vim.load_plugin("telescope")
local actions   = Fau_vim.load_plugin("telescope.actions")
local layout    = Fau_vim.load_plugin("telescope.actions.layout")

if telescope == nil then return end
if actions   == nil then return end
if layout    == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	defaults = {
		-- Default configuration for telescope goes here:
		sorting_strategy = "descending", -- Determines the direction "better" results are sorted towards. values: `descending`, `ascending`
		selection_strategy = "reset",    -- Determines how the cursor acts after each sort iteration. values: `reset`, `follow`, `row`, `closest`, `none`
		scroll_strategy = "cycle",       -- Determines what happens if you try to scroll past the view of the picker.  values: `cycle`, `limit`
		layout_strategy = "horizontal",  -- Determines the default layout of Telescope pickers. values: see |telescope.layout|

		layout_config = { -- Determines the default configuration values for layout strategies.  values: see |telescope.layout|
			-- layout_strategy_name = {
			-- 	anchor = ...,  -- Where to place prompt window. values: "", "CENTER", "NW", "N", "NE", "E", "SE", "S", "SW", "W"
			-- 	height = ...,  -- How tall to make Telescope's entire layout. value: |resolver.resolve_height()|
			-- 	width = ...,  -- How wide to make Telescope's entire layout. value: |resolver.resolve_width()|
			-- 	scroll_speed = ...,  -- The number of lines to scroll through the previewer
			-- 	mirror = ...,  -- Flip the location of the results/prompt and preview windows. Boolean
			-- 	prompt_position = ...,  -- Where to place prompt window. values: "bottom", "top"
			-- 	preview_cutoff = ...,  -- When columns(lines) are less than this value, the preview will be disabled
			-- 	preview_width = ...,  -- Change the width of Telescope's preview window. value: |resolver.resolve_width()|
			--  preview_height = 0.5,  -- Change the height of Telescope's preview window. value: |resolver.resolve_height()|
			-- },

			horizontal = {
				height = 0.9,
				preview_cutoff = 100,
				prompt_position = "bottom",
				width = 0.8,
				preview_width = 0.5,
			},

			vertical = {
				height = 0.9,
				preview_cutoff = 30,
				prompt_position = "bottom",
				width = 0.8,
				preview_height = 0.5,
			},

			bottom_pane = {
				height = 0.35,
				preview_cutoff = 100,
				prompt_position = "top"
			},

			center = {
				height = 0.35,
				preview_cutoff = 30,
				prompt_position = "top",
				width = 0.5,
			},

			cursor = {
				height = 0.2,
				preview_cutoff = 40,
				width = 0.5,
				preview_width = 0.7,
			}
		},

		winblend = 0,         -- Configure winblend for telescope floating windows. values: [0, 100]
		wrap_results = false, -- Word wrap the search results

		prompt_prefix = "??? ",   -- The character(s) that will be shown in front of Telescope's prompt.
		selection_caret = "??? ", -- The character(s) that will be shown in front of the current selection.
		entry_prefix = "  ",    -- Prefix in front of each result entry. Current selection not included.
		multi_icon = "+",       -- Symbol to add in front of a multi-selected result entry.

		initial_mode = "insert", -- Determines in which mode telescope starts. values: `insert` and `normal`.
		path_display = { "smart" }, -- Determines how file paths are displayed

		border = true, -- Boolean defining if borders are added to Telescope windows.
		borderchars = { "???", "???", "???", "???", "???", "???", "???", "???" }, --  Set the borderchars of telescope floating windows. It has to be a table of 8 string values.
		-- get_status_text =  ...,  -- A function that determines what the virtual text looks like. Signature: function(picker) -> str

		hl_result_eol = true, -- changes if the highlight for the selected item in the results window is always the full width of the window

		results_title = "Results", -- Defines the default title of the results window. A false value can be used to hide the title altogether.
		prompt_title = "Prompt",   -- Defines the default title of the prompt window. A false value can be used to hide the title altogether.

		mappings = { -- Will allow you to completely remove all of telescope's default maps and use your own.
			i = {
				["<TAB>"] = actions.move_selection_worse,    -- move to next
				["<S-TAB>"] = actions.move_selection_better, -- move to last

				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,

				["<C-l>"] = false,
				["<C-p>"] = layout.toggle_preview,
				["<C-n>"] = false,
				["<PageUp>"] = false,
				["<PageDown>"] = false,
				["<A-q>"] = false,
			},
			n = {
				["<TAB>"] = actions.move_selection_worse,    -- move to next
				["<S-TAB>"] = actions.move_selection_better, -- move to last

				["<C-p>"] = layout.toggle_preview,
				["q"] = actions.close,

				["<PageUp>"] = false,
				["<PageDown>"] = false,
				["<A-q>"] = false,
			},
		},
		file_ignore_patterns = { ".git/", "plugin/packer_compiled.lua", "snippets/" },

	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }

		-- -----------------------------------
		-- -------- Basic
		-- -----------------------------------
		find_files = {
			-- theme = "dropdown",  -- false(default), "ivy", "dropdown", "cursor"
			layout_strategy = "center",
			sorting_strategy = "ascending",
			hidden = true, -- show hidden files
			previewer = false,
		},

		oldfiles = {
			layout_strategy = "center",
			sorting_strategy = "ascending",
			initial_mode = "normal",
		},

		grep_string = {
			layout_strategy = "vertical",
			initial_mode = "normal",
		},

		live_grep = {
			layout_strategy = "vertical",
		},

		buffers = {
			layout_strategy = "center",
			sorting_strategy = "ascending",
			initial_mode = "normal",
		},

		help_tags = {
			layout_strategy = "vertical",
		},

		keymaps = {
			layout_strategy = "horizontal",
			-- initial_mode = "normal",
		},

		commands = {
			layout_strategy = "horizontal",
			initial_mode = "normal",
		},

		autocommands = {
			layout_strategy = "vertical",
			-- initial_mode = "normal",
		},


		-- -----------------------------------
		-- -------- LSP
		-- -----------------------------------
		lsp_definitions = {
			layout_strategy = "bottom_pane",
			initial_mode = "normal",
			jump_type = "never", -- the performance of only one result.  values: false(auto jump), 'tab', 'split', 'vsplit', 'never'
		},

		lsp_type_definitions = {
			initial_mode = "normal",
			layout_strategy = "bottom_pane",
			jump_type = "never",
		},

		lsp_implementations = {
			layout_strategy = "bottom_pane",
			initial_mode = "normal",
			jump_type = "never",
		},

		lsp_references = {
			layout_strategy = "cursor",
			initial_mode = "normal",
			jump_type = "never",
			-- include_current_line = true,
		},

		diagnostics = {
			layout_strategy = "bottom_pane",
			initial_mode = "normal",
		},

		lsp_document_symbols = {
			layout_strategy = "horizontal",
			initial_mode = "normal",
			show_line = true,
		},

		lsp_workspace_symbols = {
			layout_strategy = "horizontal",
			initial_mode = "normal",
			show_line = true,
		},

		lsp_outgoing_calls = {
			layout_strategy = "bottom_pane",
			initial_mode = "normal",
		},

		lsp_incoming_calls = {
			layout_strategy = "bottom_pane",
			initial_mode = "normal",
		},
	},
	extensions = {
		-- projects = {  -- doesn't work!
		-- 	layout_strategy = "center",
		-- 	sorting_strategy = "ascending",
		-- 	initial_mode = "normal",
		-- },
		emoji = { layout_strategy = "vertical" },
		-- notify = { layout_strategy = "vertical", initial_mode = "normal" },
		-- luasnip = { theme = "ivy" },
	}
}


telescope.setup(config)



-- =============================================
-- ========== Extensions
-- =============================================
telescope.load_extension("notify")
telescope.load_extension("fzf")
telescope.load_extension("projects")
telescope.load_extension("emoji")
telescope.load_extension("luasnip")
