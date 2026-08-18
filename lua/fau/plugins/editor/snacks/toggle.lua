---@class snacks.toggle.Config
return {
  enabled = true,

  ---Report the new state of a toggle.
  ---@param state boolean
  ---@param opts snacks.toggle.Opts
  notify = function(state, opts)
    -- SEE: https://github.com/folke/snacks.nvim/blob/882c996cf28183f4d63640de0b4c02ec886d01f2/lua/snacks/toggle.lua#L107
    Snacks.notify((state and "Enabled" or "Disabled") .. " **" .. opts.name .. "**", {
      id = "fvim:toggle:" .. opts.id,  -- One window per toggle, so flipping it back replaces the message.
      title = opts.name,
      level = state and vim.log.levels.INFO or vim.log.levels.WARN,
    })
  end,
}
