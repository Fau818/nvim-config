---@type LazyPluginSpec
return {
  ---@module "mini.pairs"
  "nvim-mini/mini.pairs",
  lazy = true,  -- Loaded by blink.cmp

  init = function()
    local augroup = vim.api.nvim_create_augroup("MiniPairsDisable", { clear = true })

    local function recording() return vim.fn.reg_recording() ~= "" end

    -- Disable in recording macros
    vim.api.nvim_create_autocmd("RecordingEnter", { group = augroup, callback = function() vim.g.minipairs_disable = true end })
    vim.api.nvim_create_autocmd("RecordingLeave", { group = augroup, callback = function() vim.g.minipairs_disable = false end })

    -- Disable in replace mode
    vim.api.nvim_create_autocmd("ModeChanged", {
      group = augroup,
      pattern = { "n*:R*", "v*:R*", "\22*:R*" },
      callback = function()
        if recording() then return end
        vim.g.minipairs_disable = true
        vim.api.nvim_create_autocmd("ModeChanged", { group = augroup, pattern = "R*:n*", once = true, callback = function() if recording() then return end vim.g.minipairs_disable = false end })
      end,
    })

    -- Disable in visual block mode.
    vim.api.nvim_create_autocmd("ModeChanged", {
      group = augroup,
      pattern = "\22*:i*",
      callback = function()
        if recording() then return end
        vim.g.minipairs_disable = true
        vim.api.nvim_create_autocmd("ModeChanged", { group = augroup, pattern = "i*:n*", once = true, callback = function() if recording() then return end vim.g.minipairs_disable = false end })
      end,
    })
  end,

  opts = {
    -- In which modes mappings from this `config` should be created
    modes = { insert = true, command = false, terminal = false },

    -- Global mappings. Each right hand side should be a pair information, a
    -- table with at least these fields (see more in |MiniPairs.map|):
    -- - <action> - one of 'open', 'close', 'closeopen'.
    -- - <pair> - two character string for pair to be used.
    -- By default pair is not inserted after `\`, quotes are not recognized by
    -- <CR>, `'` does not insert the pair after a letter.
    -- Only parts of tables can be tweaked (others will use these defaults).
    mappings = {
      -- NOTE: The commented mappings are defaults.

      ["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
      ["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
      ["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },

      [")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
      ["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
      ["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

      -- "^[^%w%-%_\\]"
      ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\%w_]", register = { cr = false } },
      ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^\\%w_]", register = { cr = false } },
      ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\%w_]", register = { cr = false } },

      [" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" },
    },
  },

}
