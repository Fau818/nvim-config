---@type LazySpec[]
return {
  {
    ---@module "csvview"
    "hat0uma/csvview.nvim",

    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
    keys = {
      { "<C-r>",      "<Cmd>CsvViewToggle<Cr>", desc = "Toggle CSV View", ft = "csv" },
      { "<Leader>rf", "<Cmd>CsvViewInfo<Cr>",   desc = "Toggle CSV View", ft = "csv" },
    },

    init = function()
      local group = vim.api.nvim_create_augroup("CsvViewEvents", {})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "csv",
        group = group,
        callback = function(args) vim.cmd("CsvViewEnable") end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "CsvViewAttach",
        group = group,
        callback = function(args)
          local bufnr = tonumber(args.data)
          fvim.notify("CSV view enabled. (Use `<C-r>` to toggle)")
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "CsvViewDetach",
        group = group,
        callback = function(args)
          local bufnr = tonumber(args.data)
          fvim.notify("CSV view disabled. (Use `<C-r>` to toggle)")
        end,
      })
    end,

    ---@type CsvView.Options
    opts = {
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end    = { "<Tab>", mode = { "n", "x" } },
        jump_prev_field_end    = { "<S-Tab>", mode = { "n", "x" } },
        jump_next_row          = { "<Enter>", mode = { "n", "x" } },
        jump_prev_row          = { "<S-Enter>", mode = { "n", "x" } },
      },
    },
  },
}
