local extensions = require("telescope").extensions

return {
  -- =============================================
  -- ========== Extension Pickers
  -- =============================================
  conda = function()
    local config = require("telescope.themes").get_dropdown({ initial_mode = "normal" })
    extensions.conda.conda(config)
  end,

  notify = function()
    local config = { layout_strategy = "vertical", initial_mode = "normal" }
    extensions.notify.notify(config)
  end,

  todo_comments = function()
    -- local config = { layout_strategy = "vertical", initial_mode = "normal" }
    extensions["todo-comments"].todo()
  end,



  -- =============================================
  -- ========== Custom Pickers
  -- =============================================
  find_files_by_filetype = function()
    -- Get user input.
    local PROMPT = "Enter filetypes to filter: "
    local input = vim.fn.input(PROMPT)
    local filetypes = vim.split(input, "%s+")

    -- Construct command extra args table.
    local ext_args = {}
    for _, filetype in ipairs(filetypes) do vim.list_extend(ext_args, { "-e", filetype }) end

    -- Make new command.
    local COMMAND = require("telescope.config").pickers.find_files.find_command  ---@type table
    local new_command = vim.list_extend(vim.deepcopy(COMMAND), ext_args)

    -- Call the picker with new command.
    require("telescope.builtin").find_files({ find_command = new_command })
  end,

}
