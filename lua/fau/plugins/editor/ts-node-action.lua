---@type LazySpec
return {
  ---@module "ts-node-action"
  "ckolkey/ts-node-action",
  vscode = true,

  cmd = { "NodeAction", "NodeActionDebug" },
  keys = { { "<LEADER>n", "<CMD>NodeAction<CR>", desc = "Node Action: Node Action" } },
  config = true,
}
