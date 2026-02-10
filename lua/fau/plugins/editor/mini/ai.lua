---@type LazySpec
return {
  ---@module "mini.ai"
  "nvim-mini/mini.ai",
  vscode = true,
  event = "VeryLazy",

  opts = function()
    local ai = require("mini.ai")

    local function wrapper(cb, mode)
      return function(...)
        local regions = cb(...)
        if not regions or vim.tbl_isempty(regions) then return regions end
        vim.tbl_map(function(region) region.vis_mode = mode end, regions)
        return regions
      end
    end

    return {
      custom_textobjects = {
        A = ai.gen_spec.argument(),

        b = false,  -- NOTE: mini.ai has alias `b` for `)` and `]` and `}`; set to false to revert to `b` for `)`.

        s = {
          {
            "%b''", '%b""', "%b``",
            "%b()", "%b[]", "%b{}", "%b<>",
          },
          "^.().*().$",
        },
        -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },  -- From LazyVim

        h = wrapper(ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }), "v"),

        C = wrapper(ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), "v"),

        c = wrapper(ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }), "v"),
        f = wrapper(ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), "v"),
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        around = "a",
        inside = "i",

        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left  = "g[",
        goto_right = "g]",
      },

      -- Number of lines within which textobject is searched
      n_lines = 500,

      -- How to search for object (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      search_method = "cover_or_next",

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    }
  end,
}
