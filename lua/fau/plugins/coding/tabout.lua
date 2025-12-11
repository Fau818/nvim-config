---@type LazySpec
return {
  -- DESC: Press <TAB> to jump out of brakets.
  ---@module "tabout"
  "abecodes/tabout.nvim",
  vscode = true,
  event = { "InsertEnter", "CmdlineEnter" },

  ---@type TaboutOptions
  opts = {
    tabkey            = "<Tab>",      -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey  = "<S-Tab>",    -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab        = true,         -- shift content if tab out is not possible
    act_as_shift_tab  = true,         -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    default_tab       = "<C-Tab>",    -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
    default_shift_tab = "<C-S-Tab>",  -- reverse shift default action,
    enable_backwards  = false,        -- Disable if you just want to move forward
    completion        = false,        -- If you use a completion pum that also uses the tab key for a smart scroll function. Setting this to true will disable tab out when the pum is open and execute the smart scroll function instead.
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "<", close = ">" },
    },
    ignore_beginning = false,  -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
    exclude = fvim.file.excluded_filetypes,  -- tabout will ignore these filetypes
  },
}
