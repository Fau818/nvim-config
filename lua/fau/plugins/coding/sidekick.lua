---@type LazySpec
return {
  ---@module "sidekick"
  "folke/sidekick.nvim",
  event = "LspAttach",

  keys = {
    -- ==================== NES ====================
    {
      "<C-n>",
      function()
        require("sidekick.nes").toggle()
        fvim.notify(("%s Next Edit Suggestion"):format(require("sidekick.nes").enabled and "Enabled" or "Disabled"), vim.log.levels.INFO, { title = "Sidekick NES" })
      end,
      desc = "Sidekick Next Edit Suggestion Toggle",
    },
    {
      "<C-y>", function()
        local nes = require("sidekick.nes")
        if not nes.have() then
          fvim.notify("Requesting Next Edit Suggestion...", vim.log.levels.INFO, { title = "Sidekick NES" })
          nes.update()
        else nes.apply()
        end
      end,
      desc = "Sidekick Next Edit Suggestion Request/Apply",
    },
    {
      "<TAB>",
      function()
        local nes = require("sidekick.nes")
        return nes.have() and nes.apply() and "" or ">>"
      end,
      expr = true,
      desc = "Sidekick Next Edit Suggestion Apply",
    },

    -- ==================== CLI ====================
    {
      "<c-.>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "t", "i", "x" },
      desc = "Sidekick Toggle",
    },
    {
      "<leader>ct",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>cf",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>cs",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>cp",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
  },

  ---@type sidekick.Config
  opts = {
    jump = { jumplist = true },
    signs = { enabled = true, icon = fvim.icons.kinds.Copilot },

    nes = {
      ---@type boolean|fun(buf:integer):boolean?
      enabled = function(buf)
        if vim.bo[buf].filetype == "copilot-chat" then return false end
        return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false and not vim.tbl_contains(fvim.file.excluded_filetypes, vim.bo[buf].filetype)
      end,
      debounce = fvim.settings.debounce.nes,
      trigger = { events = { "ModeChanged i:n", "TextChanged", "User SidekickNesDone" } },
      clear = { events = { "TextChangedI", "InsertEnter" }, esc = true },
      ---@type sidekick.diff.Opts
      diff = { inline = "words" },
    },

    -- Work with AI cli tools directly from within Neovim
    cli = {
      watch = true,  -- notify Neovim of file changes done by AI CLI tools
      ---@class sidekick.win.Opts
      win = {
        --- This is run when a new terminal is created, before starting it.
        --- Here you can change window options `terminal.opts`.
        ---@param terminal sidekick.cli.Terminal
        config = function(terminal) end,
        wo = {},  ---@type vim.wo
        bo = {},  ---@type vim.bo

        layout = "right",  ---@type "float"|"left"|"bottom"|"top"|"right"
        --- Options used when layout is "float"
        ---@type vim.api.keyset.win_config

        float = { width = 0.9, height = 0.9 },
        -- Options used when layout is "left"|"bottom"|"top"|"right"
        ---@type vim.api.keyset.win_config

        split = { width = 80, height = 20 },

        --- CLI Tool Keymaps (default mode is `t`)
        ---@type table<string, sidekick.cli.Keymap|false>
        keys = {
          buffers       = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
          files         = { "<c-f>", "files",   mode = "nt", desc = "open file picker" },
          hide_n        = { "q",     "hide",    mode = "n",  desc = "hide the terminal window" },
          hide_ctrl_q   = { "<c-q>", "hide",    mode = "n",  desc = "hide the terminal window" },
          hide_ctrl_z   = { "<c-z>", "close",   mode = "n",  desc = "close the terminal window" },
          hide_ctrl_dot = { "<c-.>", "hide",    mode = "nt", desc = "hide the terminal window" },
          -- hide_ctrl_z = false,
          prompt        = { "<c-p>", "prompt",     mode = "t",  desc = "insert prompt or context" },
          stopinsert    = { "<c-q>", "stopinsert", mode = "t",  desc = "enter normal mode" },
          -- Navigate windows in terminal mode. Only active when:
          -- * layout is not "float"
          -- * there is another window in the direction
          -- With the default layout of "right", only `<c-h>` will be mapped
          nav_left      = { "<c-h>", "nav_left",  expr = true, desc = "navigate to the left window" },
          nav_down      = { "<c-j>", "nav_down",  expr = true, desc = "navigate to the below window" },
          nav_up        = { "<c-k>", "nav_up",    expr = true, desc = "navigate to the above window" },
          nav_right     = { "<c-l>", "nav_right", expr = true, desc = "navigate to the right window" },
        },
        ---@type fun(dir:"h"|"j"|"k"|"l")?
        --- Function that handles navigation between windows.
        --- Defaults to `vim.cmd.wincmd`. Used by the `nav_*` keymaps.
        nav = nil,
      },

      ---@type sidekick.cli.Mux
      mux = {
        enabled = true,
        backend = vim.fn.executable("zellij") and "zellij" or "tmux",  -- default to tmux unless zellij is detected
        -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
        -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
        -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
        -- NOTE: zellij only supports `terminal`
        create = "terminal",  ---@type "terminal"|"window"|"split"
        split = { vertical = true, size = 0.45 },
      },

      ---@type table<string, sidekick.cli.Config|{}>
      tools = nil,  -- Use default.
      --- Add custom context. See `lua/sidekick/context/init.lua`
      ---@type table<string, sidekick.context.Fn>
      -- context = {},  -- Use default.
      ---@type table<string, sidekick.Prompt|string|fun(ctx:sidekick.context.ctx):(string?)>
      prompts = nil,  -- Use default.
      -- preferred picker for selecting files
      picker = "snacks",  ---@type sidekick.picker
    },

    copilot = {
      -- track copilot's status with `didChangeStatus`
      status = {
        enabled = true,
        level = vim.log.levels.WARN,
        -- set to vim.log.levels.OFF to disable notifications
        -- level = vim.log.levels.OFF,
      },
    },
    ui = nil,  -- Use default.

    debug = false,  -- enable debug logging
  },

}
