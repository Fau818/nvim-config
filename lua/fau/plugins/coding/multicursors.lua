---@type LazySpec
return {
  -- DESC: Multi-cursor support in Neovim.
  ---@module "multicursors"
  "smoka7/multicursors.nvim",
  dependencies = "nvimtools/hydra.nvim",
  vscode = true,

  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      "<LEADER>m",
      "<CMD>MCstart<CR>",
      desc = "Multicursors: Create a selection for selected word under the cursor",
    },
    {
      "<LEADER>M",
      "<CMD>MCunderCursor<CR>",
      desc = "Multicursors: Create a selection for selected text under the cursor",
    },
  },

  ---@type Config
  opts = {
    DEBUG_MODE = false,
    create_commands = true,  -- create Multicursor user commands
    -- updatetime = nil,  -- Use default.
    nowait = false,

    mode_keys = {
      append = "a",
      change = "c",
      extend = "e",
      insert = "i",
    },
    -- set bindings to start these modes
    -- normal_keys = normal_keys,
    -- insert_keys = insert_keys,
    -- extend_keys = extend_keys,

    hint_config = {
      float_opts = { border = "double" },
      position = "bottom",
    },

    -- generate_hints = nil,  -- Use default.
  }
}
