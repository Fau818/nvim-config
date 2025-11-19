---@module "noice"
---@type NoiceConfig
local lsp = {
  progress = {
    enabled = true,
    -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
    -- See the section on formatting for more details on how to customize.
    ---@type NoiceFormat|string
    format = "lsp_progress",
    ---@type NoiceFormat|string
    format_done = "lsp_progress_done",
    throttle = 1000 / 60,  -- frequency to update lsp progress message
    view = "mini",
  },

  override = {
    -- override the default lsp markdown formatter with Noice
    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    -- override the lsp markdown formatter with Noice
    ["vim.lsp.util.stylize_markdown"] = true,
    -- override cmp documentation with Noice (needs the other options to work)
    ["cmp.entry.get_documentation"] = false,
  },

  hover = {
    enabled = true,
    silent  = true,  -- set to true to not show a message if hover is not available
    view = nil,      -- when nil, use defaults from documentation
    ---@type NoiceViewOptions
    opts = {},  -- merged with defaults from documentation
  },

  signature = {
    enabled = true,
    auto_open = {
      enabled = false,
      trigger = true,   -- Automatically show signature help when typing a trigger character from the LSP
      luasnip = true,   -- Will open signature help when jumping to Luasnip insert nodes
      throttle = 5000,  -- Debounce lsp signature help request by 50ms
    },
    view = nil,  -- when nil, use defaults from documentation
    ---@type NoiceViewOptions
    opts = {},  -- merged with defaults from documentation
  },

  message = {
    -- Messages shown by lsp servers
    enabled = true,
    view = "notify",
    opts = { title = "Noice: LSP" },
  },

  -- defaults for hover and signature help
  documentation = {
    view = "hover",
    ---@type NoiceViewOptions
    opts = {
      lang = "markdown",
      replace = true,
      render = "plain",
      format = { "{message}" },
      win_options = { concealcursor = "n", conceallevel = 3, scrolloff = 2 },
    },
  },
}

return lsp
