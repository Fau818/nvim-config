---@class snacks.lazygit.Config: snacks.terminal.Opts
return {
  enabled = true,

  -- automatically configure lazygit to use the current colorscheme
  -- and integrate edit with the current neovim instance
  configure = true,

  -- extra configuration for lazygit that will be merged with the default
  -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
  -- you need to double quote it: `"\"test\""`
  config = nil,  -- Use default.

  theme_path = nil,  -- Use default.
  theme = nil,  -- Use default.

  win = { style = "lazygit" },
}
