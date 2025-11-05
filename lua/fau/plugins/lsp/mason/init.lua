---@type LazySpec[]
return {
  {
    ---@module "mason-lspconfig"
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },

    keys = { { "<LEADER>li", "<CMD>checkhealth vim.lsp<CR>", desc = "LSP: Show Info" } },

    init = function()
      vim.lsp.inlay_hint.enable(true)
      vim.api.nvim_create_autocmd("FileType", {
        group = "fau_vim",
        pattern = "*",
        callback = function(args)
          if vim.bo[args.buf].buftype ~= "" then return end
          fvim.lsp.setup_by_ft(args.match)
        end,
      })
    end,

    ---@type MasonLspconfigSettings
    opts = {
      automatic_enable = false,
      -- ensure_installed = { "lua_ls" },
    },
  },

  {
    ---@module "mason"
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<LEADER>lI", "<CMD>Mason<CR>", desc = "LSP: Show Mason" } },

    ---@type MasonSettings
    opts =  {
      install_root_dir = nil,  -- Use default.
      PATH = "skip",  ---@type "prepend" | "append" | "skip"

      log_level = vim.log.levels.INFO,

      max_concurrent_installers = 4,

      registries = {
        "github:mason-org/mason-registry",
        "lua:fau.plugins.lsp.mason.custom_source",
      },

      providers = nil,  -- Use default.
      github = nil,  -- Use default.
      pip = nil,  -- Use default.

      ui = {
        check_outdated_packages_on_open = true,

        border = "double",
        backdrop = 100,
        width  = 0.9,
        height = 0.85,

        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },

        keymaps = nil,  -- Use default.
      },
    },
  },
}
