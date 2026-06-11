---@type LazyPluginSpec
return {
  ---@module "grug-far"
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>R",
      function() require("grug-far").toggle_instance({ instanceName = "far", staticTitle = "Find and Replace" }) end,
      mode = { "n", "x" },
      desc = "Grug Far (Replace)",
    },
  },

  ---@type grug.far.Options
  opts = {
    debounceMs = 500,
    minSearchChars = 2,

    maxSearchMatches = 5000,
    maxLineLength = 1000,
    -- breakindentopt = "shift:6",
    normalModeSearch = false,
    -- maxWorkers = 4,

    -- enabledEngines = { "ripgrep", "astgrep", "astgrep-rules" },
    -- engines = nil,  -- Use default.
    -- engine = "ripgrep",

    -- enabledReplacementInterpreters = { "default", "lua", "vimscript" },
    -- replacementInterpreter = "default",

    -- windowCreationCommand = "vsplit",
    -- disableBufferLineNumbers = true,

    -- helpLine = { enabled = true },

    -- maxSearchCharsInTitles = 30,
    -- staticTitle = "Find and Replace",

    startInInsertMode = false,
    -- startCursorRow = 1,
    wrap = true,
    showCompactInputs = false,
    showInputsTopPadding = true,
    showInputsBottomPadding = true,

    showStatusIcon = true,
    showEngineInfo = true,
    showStatusInfo = true,

    -- onStatusChange = nil,  -- Use default.
    onStatusChangeThrottleTime = 500,

    -- transient = true,
    backspaceEol = true,

    visualSelectionUsage = "operate-within-range",

    -- keymaps = nil,  -- Use default.

    -- resultsSeparatorLineChar = "",
    resultsHighlight = true,
    inputsHighlight = true,

    -- lineNumberLabel = nil,  -- Use default.
    -- filePathConceal = nil,  -- Use default.
    -- filePathConcealChar = "…",

    -- spinnerStates = nil,  -- Use default.
    reportDuration = true,

    -- icons = nil,  -- Use default.

    -- ...
  },
}
