-- =============================================
-- ========== Plugin Loading
-- =============================================
local inlayhints_ok, inlayhints = pcall(require, "lsp-inlayhints")
if not inlayhints_ok then Fau_vim.load_plugin_error("lsp-inlayhints") return end



-- =============================================
-- ========== Configuration
-- =============================================
-- local config = {
--   inlay_hints = {
--     parameter_hints = {
--       show = true,
--       prefix = "<- ",
--       separator = ", ",
--       remove_colon_start = false,
--       remove_colon_end = true,
--     },
--     type_hints = {
--       -- type and other hints
--       show = true,
--       prefix = "",
--       separator = ", ",
--       remove_colon_start = false,
--       remove_colon_end = false,
--     },
--     only_current_line = false,
--     -- separator between types and parameter hints. Note that type hints are
--     -- shown before parameter
--     labels_separator = "  ",
--     -- whether to align to the length of the longest line in the file
--     max_len_align = false,
--     -- padding from the left if max_len_align is true
--     max_len_align_padding = 1,
--     -- highlight group
--     highlight = "LspInlayHint",
--     -- virt_text priority
--     priority = 0,
--   },
--   enabled_at_startup = true,
--   debug_mode = false,
-- }
local config = {
  inlay_hints = {
    parameter_hints = { show = true, },
    type_hints = { show = true, },
    label_formatter = function(tbl, kind, opts, client_name)
      if kind == 2 and not opts.parameter_hints.show then
        return ""
      elseif not opts.type_hints.show then
        return ""
      end

      return table.concat(tbl, ", ")
    end,
    virt_text_formatter = function(label, hint, opts, client_name)
      if client_name == "sumneko_lua" or client_name == "lua_ls" then
        if hint.kind == 2 then
          hint.paddingLeft = false
        else
          hint.paddingRight = false
        end
      end

      local vt = {}
      vt[#vt + 1] = hint.paddingLeft and { "", "None" } or nil
      vt[#vt + 1] = { label, opts.highlight }
      vt[#vt + 1] = hint.paddingRight and { " ", "None" } or nil

      return vt
    end,
    only_current_line = false,
    -- highlight group
    highlight = "LspInlayHint",
    -- virt_text priority
    priority = 0,
  },
  enabled_at_startup = true,
  debug_mode = false,
}


inlayhints.setup(config)
