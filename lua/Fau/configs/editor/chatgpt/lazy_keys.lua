local mode = { "n", "x" }

local function desc_wrapper(desc) return "ChatGPT: " .. desc end

---@type LazyKeysSpec[]
return {
  { "<LEADER>c", mode = mode, desc = "+ChatGPT" },
  { "<LEADER>cc", "<CMD>ChatGPT<CR>",                     mode = mode, desc = desc_wrapper("ChatGPT") },
  { "<LEADER>ci", "<CMD>ChatGPTEditWithInstructions<CR>", mode = mode, desc = desc_wrapper("ChatGPTEditWithInstructions") },
  { "<LEADER>ca", "<CMD>ChatGPTActAs<CR>",                mode = mode, desc = desc_wrapper("ChatGPTActAs") },
  { "<LEADER>cr", ":ChatGPTRun ",                  mode = mode, desc = desc_wrapper("ChatGPTActAs") },
}
