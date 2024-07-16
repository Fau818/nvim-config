-- NOTE: This is a annotation file for `Fau_vim.keymaps` with a spot of additional overwrite and new key bindings.
local mode = { "n", "x" }

---@type wk.Spec
return {
  { "<LEADER>c", group = "ChatGPT" },
  { "<LEADER>cc", "<CMD>ChatGPT<CR>",                     mode = mode, desc = "Run ChatGPT" },
  { "<LEADER>ca", "<CMD>ChatGPTActAs<CR>",                mode = mode, desc = "Run ChatGPTActAs" },
  { "<LEADER>ci", "<CMD>ChatGPTEditWithInstructions<CR>", mode = mode, desc = "Run ChatGPTEditWithInstructions" },
  { "<LEADER>cC", "<CMD>ChatGPTCompleteCode<CR>",         mode = mode, desc = "Run ChatGPTCompleteCode" },
}
