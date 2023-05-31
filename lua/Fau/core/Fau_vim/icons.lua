-- =============================================
-- ========== Fau_vim.icons
-- =============================================
return {
  ---@type table<string, string>
  kind = {
    Array         = "", -- "󰅨"
    Boolean       = "", -- ""
    Class         = "",
    Color         = "", -- ""
    Constant      = "",
    Constructor   = "", -- ""
    Copilot       = "",
    Enum          = "",
    EnumMember    = "", -- ""
    Event         = "", -- ""
    Field         = "", -- ""
    File          = "", -- ""
    Folder        = "", -- ""
    Function      = "󰊕", -- "󰡱"
    Interface     = "", -- ""
    Key           = "", -- ""
    Keyword       = "",
    Method        = "",
    Module        = "", -- ""
    Namespace     = "",
    Null          = "󰟢",
    Number        = "", -- "" ""
    Object        = "",
    Operator      = "", -- ""
    Package       = "",
    Property      = "", -- ""
    Reference     = "", -- ""
    Snippet       = "", -- ""
    String        = "", -- ""
    Struct        = "", -- ""
    Text          = "",
    TypeParameter = "", -- ""
    Unit          = "",
    Value         = "",
    Variable      = "",
  },


  git = {
    LineAdded    = "",
    LineModified = "",
    LineRemoved  = "",

    FileDeleted   = "",
    FileIgnored   = "◌",
    FileRenamed   = "➜",
    FileUnmerged  = "",
    FileStaged    = "✓",
    FileUnstaged  = "✗",
    FileUntracked = "★",

    -- Diff     = "",
    -- Repo     = "",
    Branch   = "",
  },


  gitsigns = { -- for gitsigns
    -- LineLeft     = "│",
    BoldLineLeft = "▎",
    Triangle     = "",
    Untracked    = "┆",
  },


  diagnostics = {
    BoldError       = "", Error       = "",
    BoldWarning     = "", Warning     = "",
    BoldInformation = "", Information = "",
    BoldHint        = "", Hint        = "",
    -- BoldQuestion = "", Question = "",  -- unused
    -- Other = "",
    Debug = "",
    Trace = "✎",
  },


  ui = {
    FolderClosed = "",
    FolderOpened = "",
    EmptyFolderClosed = "",
    EmptyFolderOpened = "",
    File     = "",
    NewFile  = "",
    FindFile = "",
    Project  = "",
    History  = "",
    FindText = "",
    Gear     = "",
    Restore  = "󰦛",
    Exit     = "󰿅",

    FoldClosed = "",
    FoldOpened = "",

    Rename    = "",
    -- Parameter = "",
    Signature = "󰷾",

    Tab   = "",
    Space = "⎵",

    -- noice, no space is better
    Input    = "",
    Help     = "",
    Search   = "",
    Terminal = "",
    Lua      = "",
    LookDown = "",
    LookUp   = "",

    DividerLeft      = "",  -- DividerLeft      = "",
    DividerRight     = "",  -- DividerRight     = "",
    BoldDividerLeft  = "", -- BoldDividerLeft  = "",
    BoldDividerRight = "", -- BoldDividerRight = "",

    ChevronRight = ">",

    Tree = "",

    BoldArrowRight = "",

    BreakPoint   = "",
    Bug          = "",
    Stacks       = "",
    Scopes       = "",
    Watches      = "",
    DebugConsole = "",

    Target = "",

    IndentLine = "▏", -- "▎"

    MethodSeparator = "─",
    MethodSeparatorHeavy = "━",

    Bread = "󰳯", BoldBread = "󰳮",
    Separator = "",
    Ellipsis  = "…",
    Modify    = "●",

    Done = "",
    Undone = "",

    EndLine = "",

  },


  todo = {
    TODO = " ",
    HACK = " ",
    WARN = " ",
    PERF = " ", -- " "
    NOTE = " ",
    TEST = "⏲ ",
    Fau  = "󰙽 ",
    DESC = " ", -- "󰆉 "
  },


  dapui = {
    Expanded  = "",
    Collapsed = "",
    Circular  = "",

    Pause     = "",
    Play      = "",
    StepInto  = "",
    StepOver  = "",
    StepOut   = "",
    StepBack  = "",
    RunLast   = "",
    Terminate = "",
  },


}
