---@type LazySpec
return {
  -- DESC: A snazzy jump plugin.
  ---@module "flash"
  "folke/flash.nvim",
  cond = true,
  keys = {
    { "f", mode = { "n", "x", "o" } }, { "F", mode = { "n", "x", "o" } },
    { "t", mode = { "n", "x", "o" } }, { "T", mode = { "n", "x", "o" } },

    { "<LEADER>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: Jump" },
    { "<LEADER>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Flash: Remote" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },
    { "<C-=>", mode = { "n", "x", "o" }, function() require("flash").treesitter({ actions = { ["<C-=>"] = "next", ["<C-->"] = "prev" } }) end, desc = "Treesitter incremental selection" },
  },

  ---@type Flash.Config
  opts = {
    labels = "asfghjklqwetuiopzbnm",
    search = {
      -- Excluded filetypes and custom window filters
      ---@type (string|fun(win:Flash.State.Window))[]
      exclude = vim.list_extend({ function(win) return not vim.api.nvim_win_get_config(win).focusable end, }, fvim.file.excluded_filetypes),
    },

    jump = { autojump = false },
    label = nil,  --- Use default.
    highlight = nil,  -- Use default.

    -- action to perform when picking a label.
    -- defaults to the jumping logic depending on the mode.
    ---@type fun(match:Flash.Match, state:Flash.State)|nil
    action = nil,

    -- initial pattern to use when opening flash
    pattern = "",

    -- When `true`, flash will try to continue the last search
    continue = false,

    -- Set config to a function to dynamically change the config
    config = nil,  ---@type fun(opts:Flash.Config)|nil

    -- You can override the default options for a specific mode.
    -- Use it with `require("flash").jump({mode = "forward"})`
    ---@type table<string, Flash.Config>
    modes = {
      -- options used when flash is activated through
      -- a regular search with `/` or `?`
      search = { enabled = false },

      -- options used when flash is activated through
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = {
        enabled = true,
        -- dynamic configuration for ftFT motions
        config = nil,  -- Use default.
        autohide = false,  -- hide after jump when not using jump labels
        jump_labels = true,  -- show jump labels
        multi_line = true,  -- set to `false` to use the current line only
        label = { exclude = "hjkliardcs" },
        -- keys = { "f", "F", "t", "T", ";", "," },
        keys = { "f", "F", "t", "T" },  -- Conflict with dashboard.
        char_actions = nil,  -- Use default.
        search = { wrap = false },
        highlight = { backdrop = true },
        jump = { register = false, autojump = false },
      },

      -- options used for treesitter selections
      -- `require("flash").treesitter()`
      treesitter = {
        labels = "abcdefghijklmnopqrstuvwxyz",  -- TEST: No excluded letters. Oct 15, 2025
        jump = { pos = "range", autojump = true },
        search = { incremental = false },
        label = { before = true, after = true, style = "inline" },
        highlight = { backdrop = false, matches = false },
      },
      -- treesitter_search = nil,  -- Use default.

      -- options used for remote flash
      -- remote = nil,  -- Use default.
    },

    -- options for the floating window that shows the prompt, for regular jumps
    prompt = nil,  -- Use default.

    -- options for remote operator pending mode
    remote_op = nil,  -- Use default.
  }
}
