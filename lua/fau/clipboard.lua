-- ════════════════════════════════════════════════════════════
-- ════════════════════════ Clipboard ═════════════════════════
-- ════════════════════════════════════════════════════════════

-- Fall back to an OSC 52 provider on hosts with no clipboard tool of their own,
-- such as containers and plain ssh targets. OSC 52 smuggles the text out
-- through a terminal escape sequence, so it needs no display server.
--
-- IMPO: Must load before anything calls `has("clipboard")` -- that call resolves
-- \     the provider for good, so a later `vim.g.clipboard` is ignored.

-- VSCode brings its own clipboard bridge, set in `fau.vscode`.
if vim.g.vscode then return end

-- NOTE: `SSH_CONNECTION` as well, because tmux leaves a stale `SSH_TTY` behind in the panes it opens later.
local in_ssh = (vim.env.SSH_TTY or vim.env.SSH_CONNECTION or "") ~= ""

local function has_env(name) return (vim.env[name] or "") ~= "" end

---Over ssh the local-daemon tools would fill the clipboard of the host you are
---sshed into; X11 and Wayland are exempt because `ssh -X` forwards for real.
---@type table<string, boolean> Clipboard tool -> whether it can work on this host
local TOOLS = {
  ["pbcopy"]               = not in_ssh,                    -- macOS
  ["wl-copy"]              = has_env("WAYLAND_DISPLAY"), -- Wayland
  ["xclip"]                = has_env("DISPLAY"),         -- X11
  ["xsel"]                 = has_env("DISPLAY"),         -- X11
  ["win32yank.exe"]        = not in_ssh,                    -- Windows / WSL
  ["termux-clipboard-set"] = not in_ssh,                    -- Termux
}

for tool, usable in pairs(TOOLS) do
  if usable and vim.fn.executable(tool) == 1 then return end
end

-- NOTE: 0.12 takes `vim.g.clipboard = "osc52"` as an exact shorthand for this, but older versions reject a bare string.
local osc52 = require("vim.ui.clipboard.osc52")
vim.g.clipboard = {
  name  = "OSC 52",
  copy  = { ["+"] = osc52.copy("+"),  ["*"] = osc52.copy("*")  },
  paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
}
