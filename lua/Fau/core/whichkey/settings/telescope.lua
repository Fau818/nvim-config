-- =============================================
-- ========== Pickers Definition
-- =============================================
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions


local functions = {
  conda = function()
    local config = { layout_strategy='center', initial_mode='normal', sorting_strategy='ascending' }
    extensions.conda.conda(config)
  end,

  docker = function() extensions.docker.docker() end,

  emoji = function() extensions.emoji.emoji() end,

  luasnip = function()
    local config = { layout_strategy = "vertical", initial_mode = "normal" }
    extensions.luasnip.luasnip(config)
  end,

  notify = function()
    local config = { layout_strategy = "vertical", initial_mode = "normal" }
    extensions.notify.notify(config)
  end,

  projects = function()
    local config = { layout_strategy = "center", sorting_strategy = "ascending", initial_mode = "normal" }
    extensions.projects.projects(config)
  end,

  builtin = {
    live_grep_in_opened_files = function() builtin.live_grep({grep_open_files=true}) end,
    grep_string_in_opened_files = function() builtin.grep_string({grep_open_files=true}) end,
  }
}



return {
  n = {
    -- -----------------------------------
    -- -------- Open Telescope Directly
    -- -----------------------------------
    ["<LEADER>F"] = { require("telescope.builtin").builtin, "Telescope" },


    -- -----------------------------------
    -- -------- Vim Pickers
    -- -----------------------------------
    ["<LEADER>f"] = {
      name = "+Telescope",
      a = { builtin.autocommands,                          "Find Autocommands" },
      b = { builtin.buffers,                               "Find Buffers" },
      c = { builtin.commands,                              "Find Commands" },
      d = { functions.docker,                              "Find Docker" },
      e = { functions.conda,                               "Find Conda Environments" },
      E = { functions.emoji,                               "Find Emoji" },
      f = { builtin.find_files,                            "Find Files" },
      h = { builtin.help_tags,                             "Find Help" },
      H = { builtin.highlights,                            "Find Highlights" },
      k = { builtin.keymaps,                               "Find Keymaps" },
      l = { functions.luasnip,                             "Find Luasnip" },
      n = { functions.notify,                              "Show Notify" },
      p = { functions.projects,                            "Open Projects" },
      t = { "<CMD>TodoTelescope<CR>",                      "Find Todo Comments" },
      r = { builtin.oldfiles,                              "Open Recent Files" },
      s = { builtin.live_grep,                             "Find String" },
      S = { functions.builtin.live_grep_in_opened_files,   "Find String in Opened Buffers" },
      w = { builtin.grep_string,                           "Find Word Under Cursor" },
      W = { functions.builtin.grep_string_in_opened_files, "Find Word Under Cursor in Opened Buffers" },
    },
  }
}
