-- =============================================
-- ========== Plugin Loading
-- =============================================
local bufferline = Fau_vim.load_plugin("bufferline")
if bufferline == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead

		numbers = "none", -- values: "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string

		close_command = "Bdelete! %d",       -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"

		indicator = {
			icon = "▎",     -- this should be omitted if indicator style is not 'icon'
			style = "icon", -- values: 'icon' | 'underline' | 'none'
		},
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",

		left_trunc_marker = "",  -- if too long
		right_trunc_marker = "", -- if too long

		always_show_bufferline = true, -- whether or not to show the bufferline if only one tab
		enforce_regular_tabs = false,   -- prevent beyond the tab size and all tabs will be the same length

		tab_size = 10,                -- the tab length
		max_name_length = 15,
		max_prefix_length = 12,       -- prefix used when a buffer is de-duplicated
		show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
		truncate_names = true,        -- whether or not tab names should be truncated

		diagnostics = "nvim_lsp", -- values: false | "nvim_lsp" | "coc"
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			--- count is an integer representing total count of errors
			--- level is a string "error" | "warning"
			--- this should return a string
			--- Don't get too fancy as this function will be executed a lot
			local show = ""
			for diagnostics, cou in pairs(diagnostics_dict) do
				local icon = (diagnostics == "error" and Fau_vim.icons.diagnostics.Error) or
						(diagnostics == "warning" and Fau_vim.icons.diagnostics.Warning)
				if icon then show = show .. icon .. " " .. cou .. " " end
			end
			return show
		end,

		offsets = {
			{
				filetype = "NvimTree",
				text = "ﴔ Workspace", -- values: string | function
				text_align = "center", -- values: "left" | "center" | "right"
				separator = true
			}
		},

		color_icons = true,              -- whether or not to add the filetype icon highlights
		show_buffer_icons = true,        -- whether or not to disable filetype icons for buffers
		show_buffer_close_icons = true,
		show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
		show_close_icon = true,

		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist

		-- can also be a table containing 2 custom separators [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin", -- "slant" | "padded_slant" | "thick" | "thin" | { 'any', 'any' },

		hover = { enabled = true, delay = 50, reveal = { "close" } },
		sort_by = "insert_after_current", -- values: 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b) return buffer_a.modified > buffer_b.modified end

		groups = {
			options = {
				toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
			},
			items = {
				{
					name = "Docs",
					highlight = { undercurl = false, sp = "green" },
					priority = 2, -- determines where it will appear relative to other groups (Optional)
					icon = Fau_vim.icons.ui.File, -- Optional
					auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
					matcher = function(buf) return buf.filename:match("%.md") or buf.filename:match("%.txt") end,
					separator = { -- Optional
						style = require("bufferline.groups").separator.tab
					},
				}
			}
		}

	}
}


bufferline.setup(config)
