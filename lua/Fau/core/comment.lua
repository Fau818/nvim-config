-- =============================================
-- ========== Plugin Loading
-- =============================================
local comment = Fau_vim.load_plugin("Comment")
if comment == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
comment.setup({
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
