-- DESC: This module is for treesitter.
---@type LazySpec[]
return {
  {
    -- BUG: When enter a buffer with no treesitter parser installed, it won't be installed automatically.
    -- DESC: An incremental parsing system for programming tools for Neovim.
    ---@module "nvim-treesitter"
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
    cond = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "TSInstall", "TSInstallSync", "TSInstallInfo",
      "TSUpdate", "TSUpdateSync", "TSUninstall",
      "TSToggle", "TSBufToggle", "TSEnable", "TSDisable",
      "TSBufEnable", "TSBufDisable",
      "TSBufToggle", "TSConfigInfo", "TSModuleInfo",
      "TSEditQuery", "TSEditQueryUserAfter",
    },
    config = function() require("fau.plugins.editor.treesitter.config") end,
  },

  {
    ---@module "nvim-treesitter-textobjects"
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cond = true,
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      local function set_keymap(lhs, query_string, bufnr)
        local to_select = require("nvim-treesitter.textobjects.select")

        bufnr = bufnr or 0
        local function query_fun_x()
          vim.cmd("normal! v")
          to_select.select_textobject(query_string, "textobjects", "x")
        end
        local function query_fun_o()
          to_select.select_textobject(query_string, "textobjects", "o")
        end
        vim.keymap.set("x", lhs, query_fun_x, { buffer = bufnr, desc = "Textobjects: " .. query_string })
        vim.keymap.set("o", lhs, query_fun_o, { buffer = bufnr, desc = "Textobjects: " .. query_string })
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then return end
          local query = vim.treesitter.query.get(lang, "textobjects")
          if not query then return end

          set_keymap("if", "@function.inner")
          set_keymap("af", "@function.outer")

          set_keymap("ic", "@class.inner")
          set_keymap("ac", "@class.outer")

          set_keymap("is", "@conditional.inner")
          set_keymap("as", "@conditional.outer")
        end,
      })
    end,
  },

  {
    -- DESC: Show context of the current buffer contents.
    ---@module "treesitter-context"
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    config = function() require("fau.plugins.editor.treesitter.context") end,
  },
}
