-- =============================================
-- ========== Plugin Loading
-- =============================================
local navic = Fau_vim.load_plugin("nvim-navic")
if navic == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	icons = {
		Array         = Fau_vim.kind_icons.Array         .. " ",
		Boolean       = Fau_vim.kind_icons.Boolean,
		Class         = Fau_vim.kind_icons.Class         .. " ",
		Color         = Fau_vim.kind_icons.Color         .. " ",
		Constant      = Fau_vim.kind_icons.Constant      .. " ",
		Constructor   = Fau_vim.kind_icons.Constructor   .. " ",
		Enum          = Fau_vim.kind_icons.Enum          .. " ",
		EnumMember    = Fau_vim.kind_icons.EnumMember    .. " ",
		Event         = Fau_vim.kind_icons.Event         .. " ",
		Field         = Fau_vim.kind_icons.Field         .. " ",
		File          = Fau_vim.kind_icons.File          .. " ",
		Folder        = Fau_vim.kind_icons.Folder        .. " ",
		Function      = Fau_vim.kind_icons.Function      .. " ",
		Interface     = Fau_vim.kind_icons.Interface     .. " ",
		Key           = Fau_vim.kind_icons.Key           .. " ",
		Keyword       = Fau_vim.kind_icons.Keyword       .. " ",
		Method        = Fau_vim.kind_icons.Method        .. " ",
		Module        = Fau_vim.kind_icons.Module        .. " ",
		Namespace     = Fau_vim.kind_icons.Namespace     .. " ",
		Null          = Fau_vim.kind_icons.Null          .. " ",
		Number        = Fau_vim.kind_icons.Number        .. " ",
		Object        = Fau_vim.kind_icons.Object        .. " ",
		Operator      = Fau_vim.kind_icons.Operator      .. " ",
		Package       = Fau_vim.kind_icons.Package       .. " ",
		Property      = Fau_vim.kind_icons.Property      .. " ",
		Reference     = Fau_vim.kind_icons.Reference     .. " ",
		Snippet       = Fau_vim.kind_icons.Snippet       .. " ",
		String        = Fau_vim.kind_icons.String        .. " ",
		Struct        = Fau_vim.kind_icons.Struct        .. " ",
		Text          = Fau_vim.kind_icons.Text          .. " ",
		TypeParameter = Fau_vim.kind_icons.TypeParameter .. " ",
		Unit          = Fau_vim.kind_icons.Unit          .. " ",
		Value         = Fau_vim.kind_icons.Value         .. " ",
		Variable      = Fau_vim.kind_icons.Variable      .. " ",
	},

	highlight = true,

	separator = " " .. Fau_vim.ui.ChevronRight .. " ",

	depth_limit = 0,
	depth_limit_indicator = "..",

	safe_output = true
}


navic.setup(config)
