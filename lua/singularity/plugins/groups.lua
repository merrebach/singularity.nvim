-- Singularity — window-groups.nvim integration
-- Highlight groups for the window-scoped buffer groups winbar.
-- No-op if window-groups.nvim is not installed (nvim_set_hl on an
-- undefined group is harmless).
-- Disable via setup({ integrations = { window_groups = false } }).

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	-- Current buffer in the active window: full contrast.
	hl(0, "GroupsActive",   { fg = c.fg,       bg = c.bg,      bold = true  })
	-- Current buffer in a non-active window: visible but not bold.
	hl(0, "GroupsCurrent",  { fg = c.fg_soft,  bg = c.bg,      bold = false })
	-- Other buffers in any group: dimmed.
	hl(0, "GroupsInactive", { fg = c.grey_dark, bg = c.bg_dark })
	-- Separator between buffers.
	hl(0, "GroupsSep",      { fg = c.bg,        bg = c.bg_dark })
	-- Trailing fill of the winbar.
	hl(0, "GroupsFill",     { bg = c.bg_dark })
end

return M
