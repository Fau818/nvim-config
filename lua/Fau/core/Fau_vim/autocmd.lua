-- Group Initialization
vim.api.nvim_create_augroup("Fau_vim", { clear = true })



-- =============================================
-- ========== Baisc
-- =============================================
-- let `-` be a keyword
vim.opt.iskeyword:append("-")
-- highlight the yank area
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "Fau_vim",
  desc = "Highlight the yank section.",
  pattern = { "*" },
  callback = function() vim.highlight.on_yank() end
})
-- keep cursor on last closed position when enter an opened file
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- use diagonal lines in place of deleted lines
vim.opt.fillchars:append { diff = "╱" }



-- =============================================
-- ========== Fau_vim
-- =============================================
-- -----------------------------------
-- -------- FileType
-- -----------------------------------
--- Fix keymap in qf filetype.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Fix keymap in qf filetype.",
  pattern = "qf",
  callback = function() vim.keymap.set("n", "<CR>", "<CR>", { silent=true, buffer=true }) end
})

--- Type q to close float window.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Type q to close float window.",
  pattern = { "notify", "git" },
  callback = function() vim.keymap.set("n", "q", "<CMD>q<CR>", { silent=true, buffer=true }) end
})

--- Treat `zsh` as `sh`.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Change `zsh` filetype to `sh(bash)`.",
  pattern = { "zsh" },
  callback = function() vim.bo.filetype = "sh" end
})

--- Identify docker-compose file
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = "Fau_vim",
  desc = "Treat docker-compose.yaml and docker-compose.yml to docker-compose filetype.",
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  callback = function() vim.opt_local.filetype = "yaml.docker-compose" end
})


--- Set table mode options in markdown.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Set table mode options in markdown.",
  pattern = { "markdown" },
  callback = function()
    vim.g.table_mode_corner = "|"
    vim.g.table_mode_map_prefix = "<LEADER>T"
    vim.keymap.set("n", "<LEADER>rf", "<CMD>Glow<CR>", { silent=true, buffer=true })
    vim.keymap.set("n", "<C-r>", "<CMD>MarkdownPreview<CR>", { silent=true, buffer=true })
  end,
})

-- -----------------------------------
-- -------- Auto LSP
-- -----------------------------------
--- Automatically set LSP by filetype initialization.
vim.api.nvim_create_autocmd("User", {
  group = "Fau_vim",
  desc = "Automatically set LSP by filetype initialization.",
  pattern = "AutoLsp",
  callback = Fau_vim.functions.lsp.initialization,
})


-- -------------------------------------------
-- -------- Auto Trim Blank Lines and Spaces
-- -------------------------------------------
--- Trim blank lines and spaces before buffer written.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "Fau_vim",
  desc = "Trim blank lines and spaces before buffer written.",
  pattern = "*",
  callback = function() Fau_vim.functions.format.remove_blank_lines_and_spaces() end,
})


-- -----------------------------------
-- -------- Keep Indentation
-- -----------------------------------
--- Tabstop will be reset to 2 if tabstop >= 8.
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Tabstop will be reset to 2 if tabstop >= 8.",
  pattern = "tabstop",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
})

--- Lock shiftwidth to 0
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock shiftwidth to 0",
  pattern = "shiftwidth",
  callback = function() vim.bo.shiftwidth = 0 end,
})

--- Lock softtabstop to -1
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock softtabstop to -1",
  pattern = "softtabstop",
  callback = function() vim.bo.softtabstop = -1 end,
})


-- -----------------------------------
-- -------- Open Dir by nvim-tree
-- -----------------------------------
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then return end

  vim.cmd.enew()
  vim.cmd.bd(data.buf)  -- BUG: https://github.com/folke/lazy.nvim/issues/1192
  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = "Fau_vim",
  desc = "Open nvim-tree when open a directory.",
  pattern = "*",
  callback = open_nvim_tree
})


-- -----------------------------------
-- -------- Disable Noice Hover Document Keymaps
-- -----------------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Config indentscope plugin for python.",
  pattern = "noice",
  callback = function() vim.b.markdown_keys = true end,
})


-- -----------------------------------
-- -------- Optimize in large file
-- -----------------------------------
vim.api.nvim_create_autocmd("BufReadPre", {
  group = "Fau_vim",
  desc = "Disable some features in large file.",
  pattern = "*.*",
  callback = function()
    local buffer = vim.api.nvim_get_current_buf()
    if not Fau_vim.functions.utils.is_large_file(buffer) then return end

    ---Large file!!
    vim.api.nvim_command("syntax off")

    -- Disable fold
    local ufo_ok, ufo = pcall(require, "ufo")
    if ufo_ok then ufo.detach(buffer) end
    vim.wo.foldenable = false
    vim.wo.foldcolumn = "0"

    -- Disable IndentLine
    local indent_blankline_ok, indent_blankline = pcall(require, "ibl")
    if indent_blankline_ok then indent_blankline.setup_buffer(buffer, { enabled = false }) end

    -- Disable mini
    vim.b.minitrailspace_disable = true
    vim.b.miniindentscope_disable = true

    -- Disable edit
    vim.bo.undofile   = false
    vim.bo.modifiable = false

    -- extra ...
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = false
    vim.opt_local.mousemoveevent = false
  end,
})
