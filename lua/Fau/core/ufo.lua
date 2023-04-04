-- =============================================
-- ========== Plugin Loading
-- =============================================
local ufo_ok, ufo = pcall(require, "ufo")
if not ufo_ok then Fau_vim.load_plugin_error("ufo") return end



-- =============================================
-- ========== Configuration
-- =============================================
--- Copied from README.md file, for enhancing fold indicator.
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end


---@type UfoConfig
local config = {
  open_fold_hl_timeout = 500,
  provider_selector = function(bufnr, filetype, buftype) return { "treesitter", "indent" } end,
  close_fold_kinds = {},
  fold_virt_text_handler = handler,
  enable_get_fold_virt_text = false,
  preview = {
    win_config = {
      border = "single",
      winblend = 0,
      winhighlight = "Normal:Normal",
      maxheight = 20
    },
    mappings = {
      scrollB = "",
      scrollF = "",
      scrollU = "<C-b>",
      scrollD = "<C-f>",
      scrollE = "",
      scrollY = "",
      jumpTop = "",
      jumpBot = "",
      close   = "q",
      switch  = "<C-d>",
      trace   = "<CR>"
    }
  }
}


ufo.setup(config)



-- =============================================
-- ========== Extra
-- =============================================
--- For saving the fold status
vim.cmd [[
  augroup remember_folds
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]]


-- vim.api.nvim_create_autocmd("OptionSet", {
--   group = "Fau_vim",
--   desc = "Lock foldlevel to 99",
--   pattern = "foldlevel",
--   callback = function()
--     print("change to " .. vim.o.foldlevel)
--     vim.o.foldlevel = 99
--   end,
-- })


-- Vim options
vim.o.foldcolumn     = "auto" -- '0' is not bad
vim.o.foldlevel      = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable     = true
-- vim.o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.fillchars:append([[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]])


-- Keymaps
vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
vim.keymap.set("n", "zm", ufo.closeFoldsWith)
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
vim.keymap.set("n", "<C-d>", function()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then vim.lsp.buf.hover() end
end)
