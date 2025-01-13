return {
  -- ==================== LSP ====================
  kind = {
    Array         = "",  -- "󰅨"
    Boolean       = "󰨙",  -- ""
    Class         = "",
    Color         = "",  -- ""
    Constant      = "󰏿",  -- ""
    Constructor   = "",  -- "", ""
    Copilot       = "",
    Enum          = "",  -- "󰕘"
    EnumMember    = "",  -- ""
    Event         = "",  -- ""
    Field         = "",  -- "", "", "󰜢"
    File          = "",  -- "", "󰈙"
    Folder        = "",  -- "󰉋"
    Function      = "󰊕",  -- "󰡱"
    Interface     = "",  -- ""
    Key           = "",  -- "", "󰌋"
    Keyword       = "",
    Method        = "󰆧",
    Module        = "",  -- ""
    Namespace     = "",  -- "󰦮"
    Null          = "󰟢",  -- ""
    Number        = "󰎠",  -- "" ""
    Object        = "󰅩",
    Operator      = "",  -- "󰆕"
    Package       = "",  -- ""
    Property      = "",  -- ""
    Reference     = "",  -- "", "󰈇"
    Snippet       = "",  -- "", ""
    String        = "",  -- "", ""
    Struct        = "󰙅",  -- "", "", "󰆼"
    Text          = "󰉿",  -- ""
    TypeParameter = "",
    Unit          = "",
    Value         = "",  -- "󰎠"
    Variable      = "",  -- "󰀫"
  },


  -- ==================== Diagnostics ====================
  diagnostics = {
    BoldError   = "", Error   = "",
    BoldWarning = "", Warning = "",
    BoldInfo    = "", Info    = "",
    BoldHint    = "󰌵", Hint    = "󰌶",
    -- BoldQuestion = "", Question = "",  -- unused
    -- Other = "",
    Debug = "",
    Trace = "✎",
  },


  -- ==================== Git ====================
  git = {
    LineAdded    = "",
    LineModified = "",
    LineRemoved  = "",

    FileDeleted   = "",
    FileIgnored   = "◌",
    FileRenamed   = "",
    FileUnmerged  = "",
    FileStaged    = "✓",
    FileUnstaged  = "✗",
    FileUntracked = "",

    -- Diff     = "",
    -- Repo     = "",
    Branch   = "",
  },


  gitsigns = {
    -- LineLeft     = "│",
    BoldLine     = "▎",  -- "┃", "▎"
    Delete       = "_",  -- ""
    TopDelete    = "‾",
    ChangeDelete = "~",
    Untracked    = "┆",
  },


  -- ==================== DAP ====================
  dap = {
    BreakPoint   = "",
    Bug          = "",
    Stacks       = "",
    Scopes       = "󰙔",
    Watches      = "󰂥",
    DebugConsole = "",
  },


  -- ==================== UI ====================
  ui = {
    -- ---------- File, Folders, and Dashboard
    FolderClosed = "",
    FolderOpened = "",
    EmptyFolderClosed = "",
    EmptyFolderOpened = "",
    SymlinkFolder = "",

    File     = "",
    Symlink  = "",
    FindFile = "󰮗",
    Project  = "",
    History  = "",
    FindText = "",
    Gear     = "",
    Restore  = "󰦛",
    Exit     = "󰿅",

    -- ---------- Fold
    FoldClosed = "",
    FoldOpened = "",

    -- ---------- Indent
    IndentLine = "▏",  -- "▎"
    Tab        = "󰌒",
    Space      = "⎵",
    EndLine    = "",

    -- ---------- Bufferline
    Modified  = "●",
    Indicator = "▎",
    Close     = "",
    CloseBold = "",

    ExpandLeft  = "",
    ExpandRight = "",

    -- ---------- Lualine
    DividerLeft      = "",   -- "", ""
    DividerRight     = "",   -- "", ""
    BoldDividerLeft  = "",  -- ""
    BoldDividerRight = "",  -- ""

    Tree = "",

    -- ---------- Breadcrumb
    Bread = "󰳯", BoldBread = "󰳮",
    Separator = "",
    Ellipsis  = "…",

    -- ---------- Treesitter-context
    MethodSeparator      = "─",
    MethodSeparatorHeavy = "━",

    -- ---------- Noice
    Input    = "",
    Help     = "",
    Search   = "",
    Terminal = "",
    Lua      = "",
    LookDown = "",
    LookUp   = "",

    -- ---------- Telescope
    telescope       = "",
    selection_caret = "",
    multiple        = "",

    -- ---------- ChatGPT
    Prompt = "",

    -- Bookmark  = "󰆤",  -- ""
    -- Done   = "",
    -- Undone = "",
    -- BoldArrowRight = "",
  },


  -- ==================== TODO Comments ====================
  todo = {
    HACK      = " ",
    WARN      = " ",
    BUG       = " ",
    PERF      = " ",
    TEST      = "⏲ ",  -- "󰅒 "

    TODO      = " ",
    NOTE      = " ",
    Fau       = "󰙽 ",

    DESC      = "󰈚 ",
    BOOK      = " ",  -- " "

    -- CASE   = " ",
    EXIT      = "󰗼 ",
    ASSERT    = "󰞏 ",
    IMPORTANT = "󱈸 ",
    SPECIAL   = "󰅳 ",
  },


  -- ==================== Vim Mode ====================
  mode = {
    n = "",
    i = "",
    v = "󰈈",
    s = "󰈈",
    t = "",
    c = "",
    r = "",
    vim = "",
  },

}
