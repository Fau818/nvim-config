-- =============================================
-- ========== Plugin Loading
-- =============================================
local status_ok, toggleterm = pcall(require, "toggleterm.terminal")
if not status_ok then return nil end

local Terminal = toggleterm.Terminal



-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Custom Layout
-- -----------------------------------
local full_screen = { border = "none", width  = 888888, height = 888888 }


-- -----------------------------------
-- -------- Custom Terminal
-- -----------------------------------
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  count = 101,
  direction = "float",
  float_opts = full_screen,
  on_open = function() vim.cmd("startinsert!") end,
})

local btop = Terminal:new({
  cmd = "btop",
  count = 102,
  dir = "git_dir",
  direction = "float",
  float_opts = full_screen,
  on_open = function() vim.cmd("startinsert!") end,
})

local float = Terminal:new({
  count = 11,
  dir = "git_dir",
  direction = "float",
  float_opts = full_screen,
  on_open = function() vim.cmd("startinsert!") end,
})

local horizontal = Terminal:new({
  count = 12,
  dir = "git_dir",
  direction = "horizontal",
  on_open = function() vim.cmd("startinsert!") end,
})

local vertical = Terminal:new({
  count = 13,
  dir = "git_dir",
  direction = "vertical",
  on_open = function() vim.cmd("startinsert!") end,
})


return {
  lazygit    = function() lazygit:toggle()    end,
  btop       = function() btop:toggle()       end,
  float      = function() float:toggle()      end,
  horizontal = function() horizontal:toggle() end,
  vertical   = function() vertical:toggle()   end,
}
