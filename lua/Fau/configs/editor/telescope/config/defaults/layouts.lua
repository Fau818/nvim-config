return {
  horizontal = {
    height = 0.9,
    width  = 0.85,
    scroll_speed = nil,

    anchor = nil,
    anchor_padding = nil,

    mirror = false,  ---@type boolean
    prompt_position = "bottom",  ---@type "bottom"|"top"

    preview_cutoff = nil,
    preview_width = 0.55,
  },

  vertical = {
    height = 0.9,
    width  = 0.85,
    scroll_speed = nil,

    anchor = nil,
    anchor_padding = nil,

    mirror = false,  ---@type boolean
    prompt_position = "bottom",  ---@type "bottom"|"top"

    preview_cutoff = nil,
    preview_height = 0.6,
  },

  flex = {
    height = 0.9,
    width  = 0.85,
    scroll_speed = nil,

    anchor = nil,
    anchor_padding = nil,

    mirror = false,  ---@type boolean
    prompt_position = "bottom",  ---@type "bottom"|"top"

    flip_columns = nil,
    flip_lines = nil,
  },

  center = {
    height = 0.3,
    width  = 0.45,
    scroll_speed = nil,

    anchor = nil,
    anchor_padding = nil,

    mirror = false,  ---@type boolean
    prompt_position = "top",  ---@type "bottom"|"top"

    preview_cutoff = nil,
  },

  cursor = {
    height = 0.25,
    width  = 0.4,
    scroll_speed = nil,

    preview_cutoff = nil,
    preview_width = 0.65,
  },

  bottom_pane = {
    height = 0.3,
    prompt_position = "top",  ---@type "bottom"|"top"
  },

}
