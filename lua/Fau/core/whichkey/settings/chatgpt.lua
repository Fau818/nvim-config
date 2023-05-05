local keymaps = {
  -- ChatGPT
  ["<LEADER>cc"] = { "<CMD>ChatGPT<CR>", "Run ChatGPT" },
  ["<LEADER>Ca"] = { "<CMD>ChatGPTActAs<CR>", "Run ChatGPTActAs" },
  ["<LEADER>Ce"] = { "<CMD>ChatGPTEditWithInstructions<CR>", "Run ChatGPTEditWithInstructions" },
}


return {
  n = {
    keymaps,
    ["<LEADER>Cc"] = { "<CMD>ChatGPTCompleteCode<CR>", "Run ChatGPTCompleteCode" },
  },
  x = { keymaps },
}
