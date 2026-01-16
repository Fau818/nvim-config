-- =============================================
-- ========== Components
-- =============================================
local conditions = {
  hide_in_width = function(window_width_limit)
    window_width_limit = window_width_limit or 100
    return vim.o.columns >= window_width_limit
  end,
}

local utils = {
  env_cleanup = function(venv)
    if string.find(venv, "/") then
      local final_venv = venv
      for w in venv:gmatch("([^/]+)") do final_venv = w end
      venv = final_venv
    end
    return venv
  end,
}

local components = {
  -- ==================== Basic ====================
  mode = {
    function()
      local mode = vim.fn.mode():sub(1, 1):lower()
      if mode == "\22" then mode = "v" end
      local icon = fvim.icons.mode[mode] or fvim.icons.mode.vim
      return icon
    end,
    padding = 2,
  },

  filename   = "filename",
  filetype   = { "filetype", padding = { left = 1, right = 2 } },
  filesize   = "filesize",
  fileformat = { "fileformat", cond = conditions.hide_in_width, padding = { left = 1, right = 2 } },
  encoding   = {
    "encoding",
    show_bomb = true,
    fmt = function(str) str = str:upper(); return str == "UTF-8" and "" or str end,
    cond = conditions.hide_in_width,
    padding = { left = 1, right = 1 }
  },

  buffers = "buffers",
  windows = "windows",
  tabs    = "tabs",

  progress = { "progress", padding = 1 },
  location = { "location", padding = { left = 0, right = 1 } },

  hostname = "hostname",
  datetime = "datetime",

  searchcount = { "searchcount", maxcount = 999, timeout = 500 },
  selectioncount = "selectioncount",


  -- ==================== Command ====================
  command = {  -- Included `selectioncount` feature.
    ---@diagnostic disable-next-line: undefined-field
    function() return require("noice").api.status.command.get() end,
    ---@diagnostic disable-next-line: undefined-field
    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
    padding = { left = 0, right = 1 },
    -- color = function() return { fg = Snacks.util.color("Statement") } end,
  },


  -- ==================== Indent ====================
  indent = {
    function()
      local TIMEOUT = 10   -- Pattern search timeout in milliseconds.
      local SPC_PTN, TAB_PTN, MIXED_PTN = [[\v^  +]], [[\v^\t+]], [[\v^(\t+  |  +\t)]]

      -- Get the indent width and type.
      local indent_type  = vim.bo.expandtab  -- true: space, false: tab
      local indent_width = vim.bo.tabstop
      local indent_show = string.format("%s %d", indent_type and fvim.icons.ui.Space or fvim.icons.ui.Tab, indent_width)

      local another_indent_type_line = vim.fn.search(indent_type and TAB_PTN or SPC_PTN, "nwc", nil, TIMEOUT)
      if another_indent_type_line > 0 then indent_show = string.format("*%s (?:%d)", indent_show, another_indent_type_line)
      else
        local mixed_line = vim.fn.search(MIXED_PTN, "nwc", nil, TIMEOUT)
        if mixed_line > 0 then indent_show = string.format("%s (MI:%d)", indent_show, mixed_line) end
      end

      return indent_show
    end,

    on_click = function(number, button, modifier)
      fvim.indent.toggle_indent_width()
      require("lualine").refresh()
    end,
    padding = { right = 1 }
  },


  -- ==================== Git ====================
  branch = { "branch", icon = fvim.icons.git.Branch, color = { gui = "bold" }, padding = { left = 1 } },

  diff = {
    "diff",
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed } end
    end,
    symbols = {
      added    = fvim.icons.git.LineAdded .. " ",
      modified = fvim.icons.git.LineModified .. " ",
      removed  = fvim.icons.git.LineRemoved .. " ",
    },
    diff_color = {
      added    = { fg = fvim.colors.lualine.green },
      modified = { fg = fvim.colors.lualine.yellow },
      removed  = { fg = fvim.colors.lualine.red },
    },
    cond = conditions.hide_in_width,
    padding = { left = 1 },
  },


  -- ==================== Diagnostics ====================
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = fvim.icons.diagnostics.BoldError .. " ",
      warn  = fvim.icons.diagnostics.BoldWarn .. " ",
      info  = fvim.icons.diagnostics.BoldInfo .. " ",
      hint  = fvim.icons.diagnostics.BoldHint .. " ",
    },
    sections = { "error", "warn", "info" },
    padding = { left = 2, right = 1 },
  },


  -- ==================== LSP ====================
  -- dap = {  -- WARN: Unchecked.
  --   function() return "  " .. require("dap").status() end,
  --   cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
  --   color = function() return { fg = Snacks.util.color("Debug") } end,
  -- },

  lsp_status = {
    "lsp_status",
    ignore_lsp = { "copilot" },
    icon = "",
    symbols = { done = "", separator = ", " },
    fmt = function(str) return str == "" and "" or string.format("[%s]", str) end,
  },

  copilot = { "copilot", padding = { left = 0, right = 1 } },  -- SEE: `AndreM222/copilot-lualine`.

  ai_agent = {
    function() local status = require("sidekick.status").cli() return " " .. (#status > 1 and #status or "") end,
    color = function() return #require("sidekick.status").cli() > 0 and "Special" or { fg = fvim.colors.lualine.red } end,
    cond = function() return package.loaded["sidekick"] ~= nil end,
    padding = { right = 1 },
  },


  -- ==================== Treesitter ====================
  treesitter = {
    function() return fvim.icons.ui.Tree end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and fvim.colors.lualine.green or fvim.colors.lualine.red }
    end,
    on_click = function(number, button, modifier)
      local bufnr = vim.api.nvim_get_current_buf()
      if vim.treesitter.highlighter.active[bufnr] then pcall(vim.treesitter.stop, bufnr)
      else pcall(vim.treesitter.start, bufnr) end
      require("lualine").refresh()
    end,
    padding = { left = 0, right = 2 },
  },


  -- ==================== Python ====================
  python_env = {
    function()
      if vim.bo.filetype == "python" then
        local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
        return venv and string.format(" (%s)", utils.env_cleanup(venv)) or ""
      end
      return ""
    end,
    color = { fg = fvim.colors.purple },
    cond = conditions.hide_in_width,
    padding = { left = 1 },
  },


  -- ==================== Lazy ====================
  lazy = {
    require("lazy.status").updates,
    cond = require("lazy.status").has_updates,
    padding = { right = 1 },
  },
}



---@type LazySpec
return {
  ---@module "lualine"
  "nvim-lualine/lualine.nvim",
  dependencies = {
    ---@module "copilot-lualine"
    "AndreM222/copilot-lualine",
  },
  event = "UIEnter",

  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",

      component_separators = { left = fvim.icons.ui.DividerLeft,     right = fvim.icons.ui.DividerRight },
      section_separators   = { left = fvim.icons.ui.BoldDividerLeft, right = fvim.icons.ui.BoldDividerRight },

      disabled_filetypes = {
        statusline = { "snacks_dashboard", "yazi" },
        winbar     = {},
      },

      ignore_focus = {
        "", "help", "netrw", "tutor", "man", "qf", "log",
        "aerial", "aerial-nav",
        "chatgpt-input",
        "crunner",
        "diff", "DiffviewFiles", "DiffviewFileHistory",
        "flash_prompt",
        "glowpreview",
        "grug-far", "grug-far-history", "grug-far-help",
        "hydra_hint",
        "lazy", "lazy_backdrop",
        "mason",
        "NvimTree", "NvimTreeFilter",
        "notify", "noice",
        "snacks_input", "snacks_picker_input", "snacks_picker_list", "snacks_picker_preview",
        "snacks_notif", "snacks_notif_history", "snacks_layout_box",
        "snacks_win", "snacks_win_help", "snacks_win_backdrop",
        "snacks_terminal", "sidekick_terminal",
        "TelescopePrompt", "TelescopeResults",
        "terminal", "toggleterm",
        "trouble",
      },

      always_divide_middle = true,
      always_show_tabline  = true,

      globalstatus = true,

      refresh = {
        statusline = fvim.settings.debounce.statusline,
        -- tabline    = nil,  -- Use default.
        -- winbar     = nil,  -- Use default.
        -- refresh_time = nil,  -- Use default.
        -- events = nil,     -- Use default.
      },
    },

    sections = {
      lualine_a = { components.mode, components.lazy },
      lualine_b = { components.branch, components.diff },
      lualine_c = { components.diagnostics, components.python_env, "b:obsidian_status" },
      lualine_x = { components.lsp_status, components.copilot, components.ai_agent, components.treesitter },
      lualine_y = { components.filetype, components.indent, components.encoding, components.fileformat },
      lualine_z = { components.progress, components.location, components.command },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { components.filetype },
      lualine_x = { components.location },
      lualine_y = {},
      lualine_z = {},
    },

    -- tabline = {},
    -- winbar = {},
    -- inactive_winbar = {},
    -- extensions = {},
  },
}
