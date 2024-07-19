local actions = require("telescope.actions")
local layout  = require("telescope.actions.layout")


local function trouble_open(...)
  if Fau_vim.plugin.trouble.tag and Fau_vim.plugin.trouble.tag:find("v2") then
    return require("trouble.providers.telescope").open_with_trouble(...)
  else
    return require("trouble.sources.telescope").open(...)
  end
end


return {
  -- ==================== Insert Mode ====================
  i = {
    -- ---------- Move
    ["<Down>"] = nil,
    ["<Up>"] = nil,
    -- ---------- Select
    ["<TAB>"] = actions.toggle_selection + actions.move_selection_worse,     -- Move to next
    ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_better,  -- Move to last
    -- ---------- Open
    ["<CR>"] = nil,
    ["<C-x>"] = nil,
    ["<C-v>"] = nil,
    -- ---------- Quit
    ["<C-c>"] = nil,
    -- ---------- Send to QFList and Trouble
    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    ["<A-q>"] = nil,

    ["<C-t>"] = trouble_open,
    -- ---------- Preview Scroll
    ["<C-d>"] = false,
    ["<C-u>"] = false,
    ["<C-k>"] = false,
    ["<C-f>"] = actions.preview_scrolling_down,
    ["<C-b>"] = actions.preview_scrolling_up,
    ["<C-Left>"] = actions.preview_scrolling_left,
    ["<C-right>"] = actions.preview_scrolling_right,
    -- ---------- Results Scroll
    ["<PageUp>"] = false,
    ["<PageDown>"] = false,
    ["<A-f>"] = false,
    ["<A-k>"] = false,
    ["<A-Left>"] = actions.results_scrolling_left,
    ["<A-Right>"] = actions.results_scrolling_right,
    -- ---------- Cycle History
    ["<C-Down>"] = actions.cycle_history_next,
    ["<C-Up>"] = actions.cycle_history_prev,
    -- ---------- Toggle Preview
    ["<C-p>"] = layout.toggle_preview,
    -- ---------- Toggle Help
    ["C-_"] = false,
    ["C-/"] = nil,
    -- ---------- Disable
    ["<C-n>"] = false,
    ["<C-l>"] = false,
    ["<C-w>"] = false,
    ["<C-r><C-w>"] = false,
    ["<C-r><C-a>"] = false,
    ["<C-r><C-f>"] = false,
    ["<C-r><C-l>"] = false,
  },


  -- ==================== Normal Mode ====================
  n = {
    -- ---------- Move
    ["j"]          = nil,
    ["k"]          = nil,
    ["<Down>"]     = nil,
    ["<Up>"]       = nil,
    -- ---------- Select
    ["<Space>"]    = actions.toggle_selection,
    ["<TAB>"]      = actions.toggle_selection + actions.move_selection_worse,   -- move to next
    ["<S-TAB>"]    = actions.toggle_selection + actions.move_selection_better,  -- move to last
    -- ---------- Open
    ["<CR>"]       = nil,
    ["<C-x>"]      = nil,
    ["<C-v>"]      = nil,
    -- ---------- Quit
    ["<ESC>"]      = nil,
    ["q"]          = actions.close,
    ["<C-c>"]      = actions.close,
    -- ---------- Send to QFList and Trouble
    ["<C-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,
    ["<A-q>"]      = nil,
    ["<C-t>"]      = trouble_open,
    -- ---------- Move Cursor
    ["H"]          = false,
    ["L"]          = false,
    ["M"]          = false,
    ["gg"]         = nil,
    ["G"]          = nil,
    ["zt"]         = actions.move_to_top,
    ["zz"]         = actions.move_to_middle,
    ["zb"]         = actions.move_to_bottom,
    -- ---------- Preview Scroll
    ["<C-d>"]      = false,
    ["<C-u>"]      = false,
    ["<C-k>"]      = false,
    ["<C-f>"]      = actions.preview_scrolling_down,
    ["<C-b>"]      = actions.preview_scrolling_up,
    ["<C-Left>"]   = actions.preview_scrolling_left,
    ["<C-right>"]  = actions.preview_scrolling_right,
    -- ---------- Results Scroll
    ["<PageUp>"]   = false,
    ["<PageDown>"] = false,
    ["<A-f>"]      = false,
    ["<A-k>"]      = false,
    ["<A-Left>"]   = actions.results_scrolling_left,
    ["<A-Right>"]  = actions.results_scrolling_right,
    -- ---------- Cycle History
    ["<C-Down>"]   = actions.cycle_history_next,
    ["<C-Up>"]     = actions.cycle_history_prev,
    -- ---------- Toggle Preview
    ["<C-p>"]      = layout.toggle_preview,
    -- ---------- Toggle Help
    ["?"]          = nil,
  },
}
