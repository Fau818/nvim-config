-- =============================================
-- ========== Plugin Configurations
-- =============================================
local ufo = require("ufo")

---@type UfoConfig
local config = {
  open_fold_hl_timeout = 500,

  ---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype) return { "treesitter", "indent" } end,

  close_fold_kinds_for_ft = {},

  fold_virt_text_handler = require("Fau.configs.editor.ufo.handler"),
  enable_get_fold_virt_text = false,

  preview = {
    win_config = {
      border       = "single",
      winblend     = 0,
      winhighlight = nil,  -- Use default.
      maxheight    = 20
    },
    mappings = {
      scrollB = "",
      scrollF = "",
      scrollU = "<C-b>",
      scrollD = "<C-f>",
      scrollE = "",
      scrollY = "",
      jumpTop = "gg",
      jumpBot = "G",
      close   = "q",
      switch  = "<C-d>",
      trace   = "<CR>"
    }
  }
}

ufo.setup(config)



-- =============================================
-- ========== Keymaps
-- =============================================
local function opts(desc) return { silent = true, desc = "ufo: " .. desc } end

local function peek_fold()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then vim.lsp.buf.hover() end
end

vim.keymap.set("n", "zr",    ufo.openFoldsExceptKinds, opts("Open Fold"))
vim.keymap.set("n", "zm",    ufo.closeFoldsWith,       opts("Close Fold"))
vim.keymap.set("n", "zR",    ufo.openAllFolds,         opts("Open Fold (All)"))
vim.keymap.set("n", "zM",    ufo.closeAllFolds,        opts("Close Fold (All)"))
vim.keymap.set("n", "<C-d>", peek_fold,                opts("Peek Fold"))
