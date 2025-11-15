if vim.b.fvim_snacks_picker_input_ftplugin_loaded then return end
vim.b.fvim_snacks_picker_input_ftplugin_loaded = true

vim.keymap.set({ "n", "x", "o" }, "J", "5j", { buffer = true, remap = true, desc = "Goto: Five Lines Down" })
vim.keymap.set({ "n", "x", "o" }, "K", "5k", { buffer = true, remap = true, desc = "Goto: Five Lines Up" })
