return {
  -- ==================== LSP ====================
  kinds = {
    Array             = "",  -- "󰅨"
    Boolean           = "󰨙",  -- ""
    BreakStatement    = "󰙧",
    Call              = "󰃷",
    CaseStatement     = "󱃙 ",
    Class             = "",
    Collapsed         = "",
    Color             = "",  -- ""
    Constant          = "󰏿",  -- ""
    Constructor       = "",  -- "", ""
    ContinueStatement = "→",
    Control           = "",
    Copilot           = "",
    CopilotError      = "",
    Declaration       = "󰙠",
    Delete            = "󰩺",
    DoStatement       = "󰑖",
    Enum              = "",  -- "󰕘"
    EnumMember        = "",  -- ""
    Event             = "",  -- ""
    Field             = "",  -- "", "", "󰜢"
    File              = "",  -- "", "󰈙"
    Folder            = "",  -- "󰉋"
    ForStatement      = "󰑖",
    Function          = "󰊕",  -- "󰡱"
    Identifier        = "󰀫",
    IfStatement       = "󰇉",
    Interface         = "",  -- ""
    Key               = "",  -- "", "󰌋"
    Keyword           = "",
    List              = "󰅪",
    Log               = "󰦪",
    Lsp               = "",
    Macro             = "󰁌",
    MarkdownH1        = "󰉫",
    MarkdownH2        = "󰉬",
    MarkdownH3        = "󰉭",
    MarkdownH4        = "󰉮",
    MarkdownH5        = "󰉯",
    MarkdownH6        = "󰉰",
    Method            = "󰆧",
    Module            = "",  -- ""
    Namespace         = "",  -- "󰦮"
    Null              = "󰟢",  -- ""
    Number            = "󰎠",  -- "" ""
    Object            = "󰅩",  -- ""
    Operator          = "",  -- "󰆕"
    Package           = "",  -- ""
    Property          = "",  -- ""
    Reference         = "",  -- "", "󰈇"
    Regex             = "",
    Repeat            = "󰑖",
    Scope             = "󰅩",
    Snippet           = "",  -- "", "", "󱄽"
    Specifier         = "󰦪",
    Statement         = "󰅩",
    String            = "",  -- "", ""
    Struct            = "󰙅",  -- "", "", "󰆼"
    SwitchStatement   = "󰺟",
    Text              = "󰉿",  -- ""
    Type              = "",
    TypeParameter     = "",
    Unit              = "",  -- ""
    Unknown           = "",
    Value             = "",  -- "󰎠"
    Variable          = "",  -- "󰀫"
    WhileStatement    = "󰑖",
  },


  -- ==================== Diagnostics ====================
  diagnostics = {
    BoldError = "", Error = "",
    BoldWarn  = "", Warn  = "",
    BoldInfo  = "", Info  = "",
    BoldHint  = "󰌵", Hint  = "󰌶",
    BoldDebug = "", Debug = "",
    BoldTrace = "", Trace = "✎",
    -- BoldQuestion = "", Question = "",  -- unused
    -- Other = "",
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
    BoldLine     = "┃",  -- "┃", "▎"
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
    Input      = "",
    Help       = "",
    Search     = "",
    Terminal   = "",
    Lua        = "",
    Calculator = "" ,
    LookDown   = "",
    LookUp     = "",

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
    -- SPECIAL   = "󰅳 ",
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
