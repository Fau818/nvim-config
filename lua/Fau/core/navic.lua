-- =============================================
-- ========== Plugin Loading
-- =============================================
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then Fau_vim.load_plugin_error("nvim-navic") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  icons = {
    Array         = Fau_vim.icons.kind.Array         .. " ",
    Boolean       = Fau_vim.icons.kind.Boolean,
    Class         = Fau_vim.icons.kind.Class         .. " ",
    Color         = Fau_vim.icons.kind.Color         .. " ",
    Constant      = Fau_vim.icons.kind.Constant      .. " ",
    Constructor   = Fau_vim.icons.kind.Constructor   .. " ",
    Enum          = Fau_vim.icons.kind.Enum          .. " ",
    EnumMember    = Fau_vim.icons.kind.EnumMember    .. " ",
    Event         = Fau_vim.icons.kind.Event         .. " ",
    Field         = Fau_vim.icons.kind.Field         .. " ",
    File          = Fau_vim.icons.kind.File          .. " ",
    Folder        = Fau_vim.icons.kind.Folder        .. " ",
    Function      = Fau_vim.icons.kind.Function      .. " ",
    Interface     = Fau_vim.icons.kind.Interface     .. " ",
    Key           = Fau_vim.icons.kind.Key           .. " ",
    Keyword       = Fau_vim.icons.kind.Keyword       .. " ",
    Method        = Fau_vim.icons.kind.Method        .. " ",
    Module        = Fau_vim.icons.kind.Module        .. " ",
    Namespace     = Fau_vim.icons.kind.Namespace     .. " ",
    Null          = Fau_vim.icons.kind.Null          .. " ",
    Number        = Fau_vim.icons.kind.Number        .. " ",
    Object        = Fau_vim.icons.kind.Object        .. " ",
    Operator      = Fau_vim.icons.kind.Operator      .. " ",
    Package       = Fau_vim.icons.kind.Package       .. " ",
    Property      = Fau_vim.icons.kind.Property      .. " ",
    Reference     = Fau_vim.icons.kind.Reference     .. " ",
    Snippet       = Fau_vim.icons.kind.Snippet       .. " ",
    String        = Fau_vim.icons.kind.String        .. " ",
    Struct        = Fau_vim.icons.kind.Struct        .. " ",
    Text          = Fau_vim.icons.kind.Text          .. " ",
    TypeParameter = Fau_vim.icons.kind.TypeParameter .. " ",
    Unit          = Fau_vim.icons.kind.Unit          .. " ",
    Value         = Fau_vim.icons.kind.Value         .. " ",
    Variable      = Fau_vim.icons.kind.Variable      .. " ",
  },

  highlight = true,

  separator = " " .. Fau_vim.icons.ui.ChevronRight .. " ",

  depth_limit = 0,
  depth_limit_indicator = "..",

  safe_output = true
}


navic.setup(config)
