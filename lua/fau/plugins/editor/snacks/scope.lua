-- NOTE: Disabled sicne it is not working as expected.
---@class snacks.scope.Config
return {
  enabled = false,

  -- absolute minimum size of the scope.
  -- can be less if the scope is a top-level single line scope
  min_size = 1,
  -- try to expand the scope to this size
  max_size = nil,

  cursor = true,    -- when true, the column of the cursor is used to determine the scope
  edge = false,       -- include the edge of the scope (typically the line above and below with smaller indent)
  siblings = true,  -- expand single line scopes with single line siblings

  -- what buffers to attach to
  filter = function(buf) return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false end,

  -- debounce scope detection in ms
  debounce = fvim.settings.debounce.indentscope,

  treesitter = {
    -- detect scope based on treesitter.
    -- falls back to indent based detection if not available
    enabled = true,
    injections = true,  -- include language injections when detecting scope (useful for languages like `vue`)
    ---@type string[]|{enabled?:boolean}
    blocks = {
      enabled = false,  -- enable to use the following blocks
      "function_declaration",
      "function_definition",
      "method_declaration",
      "method_definition",
      "class_declaration",
      "class_definition",
      "do_statement",
      "while_statement",
      "repeat_statement",
      "if_statement",
      "for_statement",
    },
    -- these treesitter fields will be considered as blocks
    field_blocks = {
      "local_declaration",
    },
  },

  -- These keymaps will only be set if the `scope` plugin is enabled.
  -- Alternatively, you can set them manually in your config,
  -- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
  keys = {
    ---@type table<string, snacks.scope.TextObject|{desc?:string}>
    textobject = {
      ii = {
        edge = false,  -- inner scope
        -- siblings = true,
        cursor = false,
        -- treesitter = { blocks = { enabled = true, "if_statement", "for_statement" } },
        treesitter = { blocks = { enabled = true } },
        linewise = true,
        desc = "inner scope",
      },
      ai = {
        cursor = false,
        -- treesitter = { blocks = { enabled = false } },
        desc = "full scope",
      },
      ["if"] = {
        cursor = false,
        siblings = false,
        edge = false,
        treesitter = { blocks = { enabled = true, "function_declaration", "function_definition", "method_declaration", "method_definition" } },
        desc = "inner function"
      },
      af = {
        cursor = false,
        siblings = false,
        edge = true,
        treesitter = { blocks = { enabled = true, "function_declaration", "function_definition", "method_declaration", "method_definition" } },
        desc = "full function"
      },
    },

    ---@type table<string, snacks.scope.Jump|{desc?:string}>
    jump = {
      ["[i"] = {
        bottom = false,
        cursor = false,
        edge = true,
        treesitter = { blocks = { enabled = false } },
        desc = "jump to top edge of scope",
      },
      ["]i"] = {
        bottom = true,
        cursor = false,
        edge = true,
        treesitter = { blocks = { enabled = false } },
        desc = "jump to bottom edge of scope",
      },
    },
  },
}
