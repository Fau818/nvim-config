--- Take `*.dconf` as `conf` filetype. (For Surge Detached Configuration)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = "Fau_vim",
  desc = "Take `*.dconf` as `conf` filetype.",
  pattern = "*.dconf",
  callback = function() vim.opt_local.filetype = "conf" end
})

--- Fix keymap in `quickfix` filetype. (Revert <CR> mapping)
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Fix keymap in qf filetype.",
  pattern = "qf",
  callback = function() vim.keymap.set("n", "<CR>", "<CR>", { silent=true, buffer=true }) end
})

--- Use `q` to close the float window.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Use `q` to close the float window.",
  pattern = { "notify", "git" },
  callback = function() vim.keymap.set("n", "q", "<CMD>q<CR>", { silent=true, buffer=true }) end
})

--- Set table mode options in markdown.
-- TODO: Put it in config file or in markdown plugin.
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

--- TEST: Treat docker-compose.yaml and docker-compose.yml to docker-compose filetype.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = "Fau_vim",
  desc = "Correct filetype for docker-compose.",
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  callback = function() vim.opt_local.filetype = "yaml.docker-compose" end
})
