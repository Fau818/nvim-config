-- =============================================
-- ========== Plugin Loading
-- =============================================
local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then Fau_vim.load_plugin_error("Comment") return end
local comment_ft = require('Comment.ft')



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}


comment.setup(config)


-- =============================================
-- ========== Specific Filetype
-- =============================================
comment_ft.set("dosini", "# %s")
