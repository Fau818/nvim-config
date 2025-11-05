---@class snacks.image.Config
return {
  enabled = true,

  formats = nil,  -- Use default.

  force = false,  -- try displaying the image, even if the terminal does not support it

  doc = {
    -- enable image viewer for documents
    -- a treesitter parser must be available for the enabled languages.
    enabled = true,
    -- render the image inline in the buffer
    -- if your env doesn't support unicode placeholders, this will be disabled
    -- takes precedence over `opts.float` on supported terminals
    inline = true,
    -- render the image in a floating window
    -- only used if `opts.inline` is disabled
    float = true,
    max_width = 80,
    max_height = 40,
    -- Set to `true`, to conceal the image text when rendering inline.
    -- (experimental)
    ---@param lang string tree-sitter language
    ---@param type snacks.image.Type image type
    conceal = function(lang, type)
      -- only conceal math expressions
      return type == "math"
    end,
  },

  img_dirs = nil,  -- Use default.

  -- window options applied to windows displaying image buffers
  -- an image buffer is a buffer with `filetype=image`
  wo = {
    wrap = false,
    number = false,
    relativenumber = false,
    cursorcolumn = false,

    foldenable = false,
    signcolumn = "no",
    foldcolumn = "0",
    statuscolumn = "",

    list = false,
    spell = false,
  },

  cache = nil,  -- Use default.
  debug = { request = false, convert = false, placement = false },
  -- env = nil,  -- Use default.
  icons = nil,  -- Use default.

  ---@class snacks.image.convert.Config
  convert = nil,  -- Use default.
  math = nil,  -- Use default.
}
