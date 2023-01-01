-- =============================================
-- ========== basic configuration
-- =============================================
require "Fau.core.options"
require "Fau.keymaps"
require "Fau.plugins"



-- =============================================
-- ========== personal configuration
-- =============================================
require "Fau.core.Fau_vim"
require "Fau.core.autocmd"



-- =============================================
-- ========== plugins configuration
-- =============================================
-- faster
require "Fau.core.impatient"

-- better UI
require "Fau.core.notify"
require "Fau.core.colorscheme"
require "Fau.core.alpha"
require "Fau.core.dressing"
require "Fau.core.lualine"
require "Fau.core.navic"
require "Fau.core.bufferline"
require "Fau.core.indentline"
require "Fau.core.gitsigns"

-- surround and comment [better writing]
require "Fau.core.comment"
require "Fau.core.surround"

-- better manager
require "Fau.core.whichkey"
require "Fau.core.nvim-tree"
require "Fau.core.telescope"
require "Fau.core.project"

-- completion and LS
require "Fau.core.cmp"
require "Fau.core.neodev"  -- keep this before LSP
require "Fau.core.lsp"
require "Fau.core.null-ls"
require "Fau.core.trouble"

-- better writing
require "Fau.core.autopairs"
require "Fau.core.tabout"
require "Fau.core.align"
require "Fau.core.code_runner"
require "Fau.core.im-select"

-- parser
require "Fau.core.treesitter"
require "Fau.core.illuminate"

-- terminal
require "Fau.core.terminal"



-- =============================================
-- ========== test
-- =============================================
require "Fau.core.aerial"
