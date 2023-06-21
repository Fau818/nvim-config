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
local custom_terminal = {
  lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    count = 101,
    direction = "float",
    float_opts = full_screen,
    on_open = function() vim.cmd("startinsert!") end,
  }),

  btop = Terminal:new({
    cmd = "btop",
    count = 102,
    dir = "git_dir",
    direction = "float",
    float_opts = full_screen,
    on_open = function() vim.cmd("startinsert!") end,
  }),

  float = Terminal:new({
    count = 11,
    dir = "git_dir",
    direction = "float",
    float_opts = full_screen,
    on_open = function() vim.cmd("startinsert!") end,
  }),

  horizontal = Terminal:new({
    count = 12,
    dir = "git_dir",
    direction = "horizontal",
    on_open = function() vim.cmd("startinsert!") end,
  }),

  vertical = Terminal:new({
    count = 13,
    dir = "git_dir",
    direction = "vertical",
    on_open = function() vim.cmd("startinsert!") end,
  }),
}


---@type table<string, function>
return {
  lazygit    = function() custom_terminal.lazygit:toggle()    end,
  btop       = function() custom_terminal.btop:toggle()       end,
  float      = function() custom_terminal.float:toggle()      end,
  horizontal = function() custom_terminal.horizontal:toggle() end,
  vertical   = function() custom_terminal.vertical:toggle()   end,
}
