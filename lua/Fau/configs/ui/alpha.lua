-- =============================================
-- ========== Plugin Configurations
-- =============================================
local alpha = require("alpha")

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[ ________                               __               ]],
  [[|        \                             |  \              ]],
  [[| $$$$$$$$______   __    __  __     __  \$$ ______ ____  ]],
  [[| $$__   |      \ |  \  |  \|  \   /  \|  \|      \    \ ]],
  [[| $$  \   \$$$$$$\| $$  | $$ \$$\ /  $$| $$| $$$$$$\$$$$\]],
  [[| $$$$$  /      $$| $$  | $$  \$$\  $$ | $$| $$ | $$ | $$]],
  [[| $$    |  $$$$$$$| $$__/ $$   \$$ $$  | $$| $$ | $$ | $$]],
  [[| $$     \$$    $$ \$$    $$    \$$$   | $$| $$ | $$ | $$]],
  [[ \$$      \$$$$$$$  \$$$$$$      \$     \$$ \$$  \$$  \$$]],
  [[                                                         ]],
  [[]],
  [[]],
  [[]],
}
dashboard.section.buttons.val = {
  dashboard.button("n", ("%s  New File"):format(Fau_vim.icons.ui.File), "<CMD>enew<CR>"),

  dashboard.button("p", ("%s  Projects"):format(Fau_vim.icons.ui.Project),     "<CMD>Telescope projects layout_strategy=center sorting_strategy=ascending initial_mode=normal<CR>"),
  dashboard.button("f", ("%s  Find Files"):format(Fau_vim.icons.ui.FindFile),  "<CMD>Telescope find_files<CR>"),
  dashboard.button("r", ("%s  Recent Files"):format(Fau_vim.icons.ui.History), "<CMD>Telescope oldfiles<CR>"),

  ---@diagnostic disable-next-line: param-type-mismatch
  dashboard.button("l", ("%s  Load Session"):format(Fau_vim.icons.ui.Restore),      function() require("persistence").load() end),
  ---@diagnostic disable-next-line: param-type-mismatch
  dashboard.button("L", ("%s  Load Last Session"):format(Fau_vim.icons.ui.Restore), function() require("persistence").load({ last = true }) end),

  dashboard.button("c", ("%s  Config Neovim"):format(Fau_vim.icons.ui.Gear), "<CMD>FauvimConfig<CR>"),

  dashboard.button("q", ("%s  Quit Neovim"):format(Fau_vim.icons.ui.Exit), "<CMD>qall<CR>"),
}

alpha.setup(dashboard.config)


-- -----------------------------------
-- -------- Lazy Display
-- -----------------------------------
-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
  vim.cmd.close()
  vim.api.nvim_create_autocmd("User", {
    pattern = "AlphaReady",
    callback = function() require("lazy").show() end,
  })
end


vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val =  "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})
