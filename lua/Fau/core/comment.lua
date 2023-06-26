-- =============================================
-- ========== Plugin Loading
-- =============================================
local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then Fau_vim.load_plugin_error("Comment") return end
local comment_ft = require('Comment.ft')



-- =============================================
-- ========== Configuration
-- =============================================
---@type CommentConfig
local config = {
  ---Add a space b/w comment and the line
  padding = true,
  ---Whether the cursor should stay at its position
  sticky = true,
  ---Lines to be ignored while (un)comment
  ignore = "^$",
  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    ---Line-comment toggle keymap
    line = 'gcc',
    ---Block-comment toggle keymap
    block = 'gbc',
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = 'gc',
    ---Block-comment keymap
    block = 'gb',
  },
  ---LHS of extra mappings
  extra = {
    ---Add comment on the line above
    above = 'gcO',
    ---Add comment on the line below
    below = 'gco',
    ---Add comment at the end of line
    eol = 'gcA',
  },
  ---Enable keybindings
  ---NOTE: If given `false` then the plugin won't create any mappings
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = false,
  },
  ---Function to call before (un)comment
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  ---Function to call after (un)comment
  -- post_hook = nil,
}


comment.setup(config)



-- =============================================
-- ========== Specific Filetype
-- =============================================
comment_ft.set("dosini",    "# %s")
comment_ft.set("zsh",       "# %s")
comment_ft.set("kitty",     "# %s")
comment_ft.set("sshconfig", "# %s")
comment_ft.set("xmodmap",   "! %s")
