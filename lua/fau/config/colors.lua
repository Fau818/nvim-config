return {
  bg      = "#151518",
  comment = "#717CBD",

  wathet      = "#87CEEB",
  blue        = "#00A9EF",
  light_blue  = "#65BCFF",
  dark_blue   = "#5C8DBC",
  deep_blue   = "#4169E1",
  purple_blue = "#82AAFF",

  cyan_blue  = "#0DB9D7",
  cyan       = "#32C8C8",
  light_cyan = "#4FD6BE",
  dark_cyan  = "#20B2AA",

  purple      = "#C099FF",
  dark_purple = "#7D7DFF",
  cobalt      = "#9999FF",

  yellow        = "#FFFF00",
  dark_yellow   = "#C8C864",
  orange_yellow = "#FBBF24",
  yellow_orange = "#FFC777",

  green       = "#6ECD82",
  light_green = "#ADEB96",  -- #AFEBB9
  dark_green  = "#39CC8F",

  red       = "#DC2626",
  fresh_red = "#FF5647",
  light_red = "#D7829F",
  red1      = "#C53B53",

  pink       = "#FCA7EA",
  light_pink = "#FFC8E1",

  orange  = "#F59C4E",  -- #FF966C
  nacarat = "#C78B76",

  gray       = "#6F7A9A",  -- #697391
  light_gray = "#A9B1D6",
  cyan_gray  = "#7D96AF",

  bufferline = { bg = "#2B2B35", selected_bg = "#151518", visible_bg = "#2B2B35" },

  -- tokyonight = ...,  -- Loaded by the colorscheme module.

  diagnostic = {
    error = "#2C1418",
    warn  = "#362716",
    info  = "#182A3A",
    hint  = "#1B251D",
  },

  -- Snippet tabstop backgrounds (mini.snippets), tuned to be visible over `bg`.
  snippet = {
    current   = "#274E33",  -- active tabstop ($1, $2, …)     — green
    replace   = "#5C3A1B",  -- active tabstop, to replace     — orange
    unvisited = "#4A2740",  -- not yet filled                 — pink
    visited   = "#26405E",  -- already filled                 — blue
    final     = "#372E5C",  -- final tabstop ($0)             — purple
  },

  diff = {
    add          = "#233844",
    delete       = "#3a2230",
    addInline    = "#305f6f",
    deleteInline = "#6b2e43",
  },

  lualine = {
    yellow = "#ECBE7B",
    green  = "#98BE65",
    red    = "#EC5F67",
  },
}
