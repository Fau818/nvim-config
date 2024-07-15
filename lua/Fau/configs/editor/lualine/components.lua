-- =============================================
-- ========== Components
-- =============================================
-- ---------- Sources
local sources = {
  diff = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed } end
  end,
}


-- ---------- Click Events
local click_events = {
  ---@param number number number of clicks incase of multiple clicks
  ---@param button string mouse button used (l(left)/r(right)/m(middle)/...)
  ---@param modifier string modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
  ---@diagnostic disable: unused-local
  treesitter = function(number, button, modifier)
    vim.api.nvim_command("TSBufToggle highlight")
    require("lualine").refresh()
  end,

  indent = function(number, button, modifier)
    Fau_vim.functions.indent.toggle_indent_width()
    require("lualine").refresh()
  end,
}


-- ---------- Conditions
local conditions = {
  hide_in_width = function(window_width_limit)
    window_width_limit = window_width_limit or 100
    return vim.o.columns >= window_width_limit
  end,
}


-- ---------- Utils
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


return {
  -- -----------------------------------
  -- -------- Builtin
  -- -----------------------------------
  mode = {
    function()
      local mode = vim.api.nvim_get_mode()["mode"]:sub(1, 1):lower()
      if mode == "" then mode = "v" end
      local icon = Fau_vim.icons.mode[mode] or Fau_vim.icons.mode.vim
      return icon
    end,
    padding = 2,
  },

  filename   = "filename",
  filetype   = "filetype",
  fileformat = { "fileformat", cond = conditions.hide_in_width },  -- win / linux / mac
  encoding   = { "encoding", show_bomb = true, fmt = string.upper, cond = conditions.hide_in_width },

  buffers = "buffers",
  tabs    = "tabs",
  windows = "windows",

  progress = "progress",
  location = "location",

  hostname = "hostname",
  datetime = "datetime",

  searchcount = { "searchcount", maxcount = 999, timeout = 500 },
  selectioncount = "selectioncount",


  -- -----------------------------------
  -- -------- Indent
  -- -----------------------------------
  indent = {  -- detect the indenttype and check whether occur mixed indent
    -- TODO: Check indent except comment lines
    -- TODO: REFACTOR ?
    function()
      -- if Fau_vim.functions.utils.is_large_file() then return "LF" end
      local TIMEOUT = 5

      -- Get the indent width and indent type
      local indent_width = vim.bo.tabstop
      local indent_type  = vim.bo.expandtab  -- true: space, false: tab

      -- Check unexpected indent type
      local space_pat, tab_pat = [[\v^  +]], [[\v^\t+]]
      local space_indent_cnt   = vim.fn.searchcount({ pattern = space_pat, max_count = 5E2, timeout = TIMEOUT }).total
      local tab_indent_cnt     = vim.fn.searchcount({ pattern = tab_pat, max_count = 5E2, timeout = TIMEOUT }).total

      local file_indent_type = space_indent_cnt > tab_indent_cnt  -- same as indent_type
      if space_indent_cnt == tab_indent_cnt then file_indent_type = indent_type end

      local indent_icon = file_indent_type and Fau_vim.icons.ui.Space or Fau_vim.icons.ui.Tab
      local indent_show = indent_icon .. " " .. indent_width                        -- show
      if file_indent_type ~= indent_type then indent_show = "*" .. indent_show end  -- unexpected indent type

      -- Check mixed indent
      local mixed_line = 0
      if space_indent_cnt > 0 and tab_indent_cnt > 0 then  -- get the mixed_line
        if file_indent_type then mixed_line = vim.fn.search(tab_pat, "nwc")
        else mixed_line = vim.fn.search(space_pat, "nwc", nil, TIMEOUT)
        end
      else  -- Check whether mixed in the same line, if true: get the line number
        mixed_line = vim.fn.search([[\v^(\t+  |  +\t)]], "nwc", nil, TIMEOUT)
      end

      if mixed_line > 0 then indent_show = indent_show .. " (MI:" .. mixed_line .. ")" end

      return indent_show
    end,

    on_click = click_events.indent,
  },


  -- -----------------------------------
  -- -------- Git
  -- -----------------------------------
  branch = { "branch", icon = Fau_vim.icons.git.Branch, color = { gui = "bold" } },

  diff = {
    "diff",
    source = sources.diff,
    symbols = {
      added    = Fau_vim.icons.git.LineAdded .. " ",
      modified = Fau_vim.icons.git.LineModified .. " ",
      removed  = Fau_vim.icons.git.LineRemoved .. " ",
    },
    diff_color = {
      added    = { fg = Fau_vim.colors.lualine.green },
      modified = { fg = Fau_vim.colors.lualine.yellow },
      removed  = { fg = Fau_vim.colors.lualine.red },
    },
    cond = conditions.hide_in_width,
    padding = { right = 1 },
  },


  -- -----------------------------------
  -- -------- Diagnostics
  -- -----------------------------------
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = Fau_vim.icons.diagnostics.Error .. " ",
      warn  = Fau_vim.icons.diagnostics.Warning .. " ",
      info  = Fau_vim.icons.diagnostics.Info .. " ",
      hint  = Fau_vim.icons.diagnostics.Hint .. " ",
    },
    sections = { "error", "warn", "info" },
  },


  -- -----------------------------------
  -- -------- LSP
  -- -----------------------------------
  lsp = {
    function()
      -- TODO: Clean outdated code.
      local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

      -- EXIT: No Clients
      if #buf_clients == 0 then return "LS Inactive" end

      local buf_ft = vim.bo.filetype
      local copilot_active = false
      local buf_client_names = {}

      -- Add client
      for _, client in pairs(buf_clients) do
        if client.name == "copilot" then copilot_active = true
        elseif client.name ~= "null-ls" then table.insert(buf_client_names, client.name)
        end
      end

      -- Add null-ls sources
      local sources_ok, sources = pcall(require, "null-ls.sources")
      if not sources_ok then sources = nil end
      if sources ~= nil then
        local clients = sources.get_available(buf_ft)
        for _, client in pairs(clients) do
          if client.name ~= "gitsigns" then table.insert(buf_client_names, client.name) end
        end
      end

      -- Combine
      -- local unique_client_names = vim.fn.uniq(buf_client_names)
      -- local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"
      local unique_client_names = table.concat(buf_client_names, ", ")
      local language_servers    = string.format("[%s]", unique_client_names)

      if copilot_active then
        -- language_servers = language_servers .. "%#SLCopilot#" .. " " .. Fau_vim.icons.kind.Copilot .. "%*"
        language_servers = ("%s %s"):format(language_servers, Fau_vim.icons.kind.Copilot)
      end

      return language_servers == "[]" and "LS Empty" or language_servers
    end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },


  -- -----------------------------------
  -- -------- Treesitter
  -- -----------------------------------
  treesitter = {
    function() return Fau_vim.icons.ui.Tree end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and Fau_vim.colors.lualine.green or Fau_vim.colors.lualine.red }
    end,
    on_click = click_events.treesitter,
  },


  -- -----------------------------------
  -- -------- Python
  -- -----------------------------------
  python_env = {
    function()
      if vim.bo.filetype == "python" then
        local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
        if venv then
          local icons = require("nvim-web-devicons")
          local py_icon, _ = icons.get_icon(".py")
          return string.format("%s (%s)", py_icon, utils.env_cleanup(venv))
        end
      end
      return ""
    end,
    color = { fg = Fau_vim.colors.purple },
    cond = conditions.hide_in_width,
  },


  lazy = {
    require("lazy.status").updates,
    cond = require("lazy.status").has_updates,
    padding = { right = 1 },
  },
}
