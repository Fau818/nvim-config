---@type LazySpec
return {
  ---@module "ts-node-action"
  "ckolkey/ts-node-action",
  cond = true,
  config = true,
  cmd = { "NodeAction", "NodeActionDebug" },
  keys = { { "<LEADER>n", "<CMD>NodeAction<CR>", desc = "Node Action: Node Action" } },
}
