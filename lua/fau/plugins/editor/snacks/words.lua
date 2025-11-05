---@class snacks.words.Config
return {
  enabled = true,

  debounce = fvim.settings.debounce.highlight,  -- time in ms to wait before updating

  notify_jump = false,        -- show a notification when jumping
  notify_end = true,          -- show a notification when reaching the end

  foldopen = true,            -- open folds after jumping
  jumplist = true,            -- set jump point before jumping

  modes = { "n", "i", "c" },  -- modes to show references
  filter = function(buf)      -- what buffers to enable `snacks.words`
    -- NOTE: If no LSP attached, `Snacks.words` won't work.
    return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
  end,
}
