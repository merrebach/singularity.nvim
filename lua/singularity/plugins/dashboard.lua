-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Dashboard & Alpha Highlights               ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	-- Dashboard
	hl(0, "DashboardHeader", { fg = c.orange, bold = true })
	hl(0, "DashboardCenter", { fg = c.slate_grey })
	hl(0, "DashboardShortcut", { fg = c.orange_70 })
	hl(0, "DashboardFooter", { fg = c.grey, italic = true })
	hl(0, "DashboardIcon", { fg = c.orange })
	hl(0, "DashboardDesc", { fg = c.fg })
	hl(0, "DashboardKey", { fg = c.orange_80 })

	-- Alpha (alternative dashboard)
	hl(0, "AlphaHeader", { fg = c.orange, bold = true })
	hl(0, "AlphaButtons", { fg = c.slate_grey })
	hl(0, "AlphaShortcut", { fg = c.orange_70 })
	hl(0, "AlphaFooter", { fg = c.grey, italic = true })
end

return M
