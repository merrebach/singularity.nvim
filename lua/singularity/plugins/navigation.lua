-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Navigation Highlights (Which-key, Trouble, ║
-- ║  Leap)                                                     ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	-- Trouble
	hl(0, "TroubleText", { fg = c.fg })
	hl(0, "TroubleCount", { fg = c.orange, bg = c.bg_soft })
	hl(0, "TroubleNormal", { fg = c.fg, bg = c.bg_dark })

	-- Which-key
	hl(0, "WhichKey", { fg = c.orange, bold = true })
	hl(0, "WhichKeyGroup", { fg = c.slate_grey })
	hl(0, "WhichKeyDesc", { fg = c.fg })
	hl(0, "WhichKeySeparator", { fg = c.grey })
	hl(0, "WhichKeyFloat", { bg = c.bg_dark })
	hl(0, "WhichKeyBorder", { fg = c.orange_60, bg = c.bg_dark })

	-- Leap
	hl(0, "LeapMatch", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "LeapLabelPrimary", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "LeapLabelSecondary", { fg = c.bg, bg = c.orange_70, bold = true })
	hl(0, "LeapBackdrop", { fg = c.grey_dark })
end

return M
