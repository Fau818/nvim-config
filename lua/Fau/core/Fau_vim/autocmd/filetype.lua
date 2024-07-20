-- Take `*.dconf` as `conf` filetype. (For Surge Detached Configuration)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.dconf",
  group = "Fau_vim",
  desc = "Take `*.dconf` as `conf` filetype.",
  callback = function() vim.opt_local.filetype = "conf" end
})

-- Fix keymap in `quickfix` filetype. (Revert <CR> mapping)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = "Fau_vim",
  desc = "Fix keymap in qf filetype.",
  callback = function() vim.keymap.set("n", "<CR>", "<CR>", { silent=true, buffer=true }) end
})

-- Use `q` to close the float window.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Use `q` to close the float window.",
  pattern = { "notify", "git" },
  callback = function() vim.keymap.set("n", "q", "<CMD>q<CR>", { silent=true, buffer=true }) end
})

-- TEST: Treat docker-compose.yaml and docker-compose.yml to docker-compose filetype.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = "Fau_vim",
  desc = "Correct filetype for docker-compose.",
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  callback = function() vim.opt_local.filetype = "yaml.docker-compose" end
})
