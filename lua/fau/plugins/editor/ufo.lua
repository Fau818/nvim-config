---Copied from README.md file, for enhancing fold indicator.
local function _fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
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


---@type LazySpec
return {
  ---@module "ufo"
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "UfoEnable", "UfoDisable", "UfoInspect", "UfoAttach", "UfoDetach", "UfoEnableFold", "UfoDisableFold" },

  init = function()
    -- ==================== Fold Options ====================
    vim.opt.foldcolumn     = "auto"
    vim.opt.foldlevel      = 999
    vim.opt.foldlevelstart = 999
    vim.opt.foldenable     = true
    vim.opt.fillchars:append([[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]])


    -- ==================== Keymaps ====================
    local function peek_fold()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end

    vim.keymap.set("n", "<C-d>", peek_fold, { desc = "ufo: Peek Fold" })
    vim.keymap.set("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "ufo: Open Fold" })
    vim.keymap.set("n", "zm", function() require("ufo").closeFoldsWith()       end, { desc = "ufo: Close Fold" })
    vim.keymap.set("n", "zR", function() require("ufo").openAllFolds()         end, { desc = "ufo: Open Fold (All)" })
    vim.keymap.set("n", "zM", function() require("ufo").closeAllFolds()        end, { desc = "ufo: Close Fold (All)" })


    -- ==================== View Keeper ====================
    vim.api.nvim_create_augroup("remember_folds", { clear = true })
    vim.api.nvim_create_autocmd("BufWinLeave", {
      group = "remember_folds",
      callback = function(event)
        local buftype = vim.bo[event.buf].buftype
        local filetype = vim.bo[event.buf].filetype
        if buftype ~= "" or vim.tbl_contains(fvim.file.excluded_filetypes, filetype) then return end
        if vim.fn.empty(vim.fn.expand("%:p")) == 0 then pcall(vim.cmd.mkview) end
      end,
    })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = "remember_folds",
      callback = function(event)
        if vim.fn.empty(vim.fn.expand("%:p")) == 0 then pcall(vim.cmd.loadview) end
      end,
    })
  end,

  ---@type UfoConfig
  opts = {
    open_fold_hl_timeout = 500,

    provider_selector = function(bufnr, filetype, buftype) return { "treesitter", "indent" } end,

    close_fold_kinds_for_ft = nil,  -- Use default.
    close_fold_current_line_for_ft = nil,  -- Use default.

    fold_virt_text_handler = _fold_virt_text_handler,
    enable_get_fold_virt_text = false,

    preview = {
      win_config = { border = "single", winblend = 0, winhighlight = nil, maxheight = 20 },
      mappings = {
        scrollB = "", scrollF = "",
        scrollE = "<DOWN>", scrollY = "<UP>",
        scrollU = "<C-b>", scrollD = "<C-f>",
        jumpTop = "gg", jumpBot = "G",
        close = "q",
        switch = "<C-d>",
        trace   = "<CR>"
      }
    }
  }
}
