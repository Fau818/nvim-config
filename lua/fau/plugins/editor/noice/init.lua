---@type LazySpec
return {
  -- DESC: A fancy UI provider.
  ---@module "noice"
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },

  event = "UIEnter",

  init = function()
    -- ==================== Smart Scroll ====================
    local fallback_cf = fvim.utils.fallback_warp("n", "<C-f>")
    local fallback_cb = fvim.utils.fallback_warp("n", "<C-b>")

    vim.keymap.set("n", "<C-f>", function()
      if not require("noice.lsp").scroll(2) then return fallback_cf() end
    end, { desc = "Editor: Scroll Down or Reveal File" })

    vim.keymap.set("n", "<C-b>", function()
      if not require("noice.lsp").scroll(-2) then return fallback_cb() end
    end, { desc = "Editor: Scroll Up" })
  end,

  ---@type NoiceConfig
  opts = {
    cmdline   = require("fau.plugins.editor.noice.config.cmdline"),
    messages  = nil,  -- Use default options.
    popupmenu = { enabled = false },

    -- default options for require('noice').redirect
    -- see the section on Command Redirection
    ---@type NoiceRouteConfig
    redirect = { view = "popup", filter = { event = "msg_show" } },

    -- You can add any custom commands below that will be available with `:Noice command`
    ---@type table<string, NoiceCommand>
    commands = nil,  -- Use default commands.

    notify = { enabled = false, view = "notify" },

    lsp = require("fau.plugins.editor.noice.config.lsp"),

    -- markdown = nil,  -- Use default.

    health = { checker = true },

    ---@type NoicePresets
    presets = {
      bottom_search           = false,  -- use a classic bottom cmdline for search
      command_palette         = false,  -- position the cmdline and popupmenu together
      long_message_to_split   = false,  -- long messages will be sent to a split
      inc_rename              = true,   -- enables an input dialog for inc-rename.nvim [entrust in cmdline.lua file]
      lsp_doc_border          = false,  -- add a border to hover docs and signature help
      cmdline_output_to_split = false,  -- send the output of a command you executed in the cmdline to a split
    },

    throttle = 1000 / 60,

    ---@type NoiceConfigViews
    views = require("fau.plugins.editor.noice.config.views"),
    ---@type NoiceRouteConfig[]
    routes = require("fau.plugins.editor.noice.config.routes"),
    ---@type table<string, NoiceFilter>
    status = nil,  ---@see section on statusline components
    ---@type NoiceFormatOptions
    format = nil,  ---@see section on formatting

    debug = false,
    log = nil,  -- Use default.
    log_max_size = nil,  -- Use default.
  },
}
