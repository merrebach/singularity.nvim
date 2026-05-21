-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Mason Highlights                           ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	hl(0, "MasonHeader", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "MasonHeaderSecondary", { fg = c.bg, bg = c.slate_grey, bold = true })
	hl(0, "MasonHighlight", { fg = c.orange })
	hl(0, "MasonHighlightBlock", { fg = c.bg, bg = c.orange })
	hl(0, "MasonMuted", { fg = c.grey })
	hl(0, "MasonMutedBlock", { fg = c.fg, bg = c.bg_soft })
end

return M
