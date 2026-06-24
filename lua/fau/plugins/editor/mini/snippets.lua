---@type LazyPluginSpec
return {
  ---@module "mini.snippets"
  "nvim-mini/mini.snippets",

  opts = function()
    local gen_loader = require("mini.snippets").gen_loader

    return {
      -- Array of snippets and loaders (see |MiniSnippets.config| for details).
      -- Nothing is defined by default. Add manually to have snippets to match.
      snippets = {
        gen_loader.from_runtime("all.json"),
        function(context) if context.lang == "cpp" then return gen_loader.from_runtime("acm_cpp.json") end end,
        gen_loader.from_lang(),
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Expand snippet at cursor position. Created globally in Insert mode.
        expand = "",

        -- Interact with default `expand.insert` session.
        -- Created for the duration of active session(s)
        jump_next = "",
        jump_prev = "",
        stop = "<C-c>",
      },

      -- Functions describing snippet expansion. If `nil`, default values
      -- are `MiniSnippets.default_<field>()`.
      expand = {
        -- Resolve raw config snippets at context
        prepare = nil,
        -- Match resolved snippets at cursor position
        match = nil,
        -- Possibly choose among matched snippets
        select = nil,
        -- Insert selected snippet
        insert = nil,
      },
    }
  end,

  config = function(_, opts)
    require("mini.snippets").setup(opts)

    -- Keep the snippet tabstop underline visible: mini draws it at priority 102, but a
    -- diagnostic undercurl (priority 4096) would cover it. While a session is active,
    -- suppress only the diagnostic *underline* (signs + virtual text stay) and restore on
    -- exit. The depth counter keeps it correct across nested sessions.
    local saved_underline, depth = nil, 0
    local group = vim.api.nvim_create_augroup("MiniSnippetsDiagnosticUnderline", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "MiniSnippetsSessionStart",
      callback = function()
        depth = depth + 1
        if depth == 1 then
          saved_underline = vim.diagnostic.config().underline
          vim.diagnostic.config({ underline = false })
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "MiniSnippetsSessionStop",
      callback = function()
        depth = math.max(depth - 1, 0)
        if depth == 0 then
          vim.diagnostic.config({ underline = saved_underline == nil and true or saved_underline })
          saved_underline = nil
        end
      end,
    })
  end,
}
