-- =============================================
-- ========== Fau_vim.icons
-- =============================================
-- TODO: Add space to show the full icons.
return {
  filetype = {
    Lua = "",
  },


  kind = {
    Array         = " ", -- "󰅨 "
    Boolean       = " ", -- " "
    Class         = " ",
    Color         = " ", -- " "
    Constant      = " ",
    Constructor   = " ", -- " "
    Enum          = " ",
    EnumMember    = " ", -- " "
    Event         = "",  -- ""
    Field         = " ",
    File          = " ", -- " "
    Folder        = " ", -- " "
    Function      = "󰊕",
    Interface     = " ", -- " "
    Key           = " ", -- " "
    Keyword       = " ",
    Method        = " ",
    Module        = " ",
    Namespace     = " ",
    Null          = "󰟢 ",
    Number        = " ", -- " "
    Object        = " ",
    Operator      = " ", -- " "
    Package       = " ",
    Property      = " ", -- " "
    Reference     = " ", -- " "
    Snippet       = " ",
    String        = " ", -- " "
    Struct        = " ", -- " "
    Text          = " ",
    TypeParameter = " ", -- ""
    Unit          = " ",
    Value         = " ",
    Variable      = " ",
  },


  git = {
    LineAdded    = "",
    LineModified = "",
    LineRemoved  = "",

    FileDeleted   = "",
    FileIgnored   = "◌",
    FileRenamed   = "➜",
    FileUnmerged  = "",
    FileStaged    = "✓",
    FileUnstaged  = "✗",
    FileUntracked = "★",

    Diff     = "",
    Repo     = "",
    Octoface = "",
    Branch   = "",
  },


  gitsigns = { -- for gitsigns
    LineLeft     = "│",
    BoldLineLeft = "▎",
    Triangle     = "契",
    Untracked    = "┆",
  },


  diagnostics = {
    BoldError       = "", Error       = "",
    BoldWarning     = "", Warning     = "",
    BoldInformation = "", Information = "",
    BoldHint        = "", Hint        = "",
    -- BoldQuestion = "", Question = "",  -- unused
    Debug = "",
    Trace = "✎",
  },


  ui = {
    File     = "",
    NewFile  = "",
    FindFile = "",
    Project  = "",
    History  = "",
    FindText = "",
    Gear     = "",
    Restore  = "󰦛",
    Exit     = "󰿅",  -- 󰗼

    Rename    = "",
    Parameter = "",
    Signature = "󰷾",

    Tab   = "",
    Space = "⎵",

    Input    = "",
    Help     = "",
    Search   = "",
    Terminal = "",

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

    Bread = "󰳯 ", BoldBread = "󰳮 ",
    Separator = "",
    Ellipsis  = "…",
    Modify    = "●",

    -- TODO = "",
    -- HACK = "",
    -- WARN = "",
    -- PERF = "",
    -- NOTE = "",
    -- TEST = "⏲",
    -- Fau  = "󰙽",
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
  }

}
