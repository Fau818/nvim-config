fvim = {}


-- ══════════════════════════ Basic ═══════════════════════════

require("fau.clipboard")
require("fau.options")
require("fau.keymaps.basic")


-- ═══════════════════════════ Core ═══════════════════════════

require("fau.config")
require("fau.functions")
require("fau.commands")
require("fau.autocmd")
require("fau.keymaps.advanced")
require("fau.ui")


-- ═══════════════════════════ Lazy ═══════════════════════════

require("fau.lazy")
