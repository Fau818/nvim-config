local keymaps = {
  -- ChatGPT
  ["<LEADER>cc"] = { "<CMD>ChatGPT<CR>", "Run ChatGPT" },
  ["<LEADER>ca"] = { "<CMD>ChatGPTActAs<CR>", "Run ChatGPTActAs" },
  ["<LEADER>ci"] = { "<CMD>ChatGPTEditWithInstructions<CR>", "Run ChatGPTEditWithInstructions" },
  ["<LEADER>cC"] = { "<CMD>ChatGPTCompleteCode<CR>", "Run ChatGPTCompleteCode" },
}


return {
  n = { keymaps },
  x = { keymaps },
}
