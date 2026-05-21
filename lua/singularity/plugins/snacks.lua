-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Snacks Highlights                          ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	-- ── Explorer ─────────────────────────────────────────────────
	hl(0, "SnacksExplorerFolder", { fg = c.grey_soft })
	hl(0, "SnacksExplorerRoot", { fg = c.orange, bold = true })
	hl(0, "SnacksExplorerFile", { fg = c.fg })
	hl(0, "SnacksExplorerNormal", { fg = c.fg, bg = c.bg_dark })
	hl(0, "SnacksExplorerPathIgnored", { fg = c.grey_dark, italic = true })
	hl(0, "SnacksExplorerPathHidden", { fg = c.grey_dark, italic = true })
	hl(0, "SnacksExplorerIndent", { fg = c.grey_dark })
	hl(0, "SnacksExplorerExpander", { fg = c.orange })

	-- ── Picker ───────────────────────────────────────────────────
	hl(0, "SnacksPickerPathIgnored", { fg = c.grey_dark, italic = true })
	hl(0, "SnacksPickerPathHidden", { fg = c.grey_dark, italic = true })
	hl(0, "SnacksPickerTree", { fg = c.cool_grey })

	-- ── Git Status (Explorer + Picker) ───────────────────────────
	hl(0, "SnacksPickerGitStatusModified", s.git_change)
	hl(0, "SnacksPickerGitStatusAdded", s.git_add)
	hl(0, "SnacksPickerGitStatusDeleted", s.git_delete)
	hl(0, "SnacksPickerGitStatusStaged", s.git_add)
	hl(0, "SnacksPickerGitStatusUntracked", { fg = c.grey })
	hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey_dark })
	hl(0, "SnacksPickerGitStatusUnmerged", s.git_delete)
	hl(0, "SnacksPickerGitStatus", { fg = c.grey_soft })

	-- ── General ──────────────────────────────────────────────────
	hl(0, "SnackNormal", { fg = c.fg, bg = c.bg_dark })
	hl(0, "SnackInactive", { fg = c.grey, bg = c.bg_dark })
	hl(0, "SnackFile", { fg = c.fg, bg = c.bg_dark })
	hl(0, "SnackSecondary", { fg = c.grey_soft, bg = c.bg_dark })
	hl(0, "SnackSelected", { fg = c.orange_80, bg = c.bg_soft, bold = true })
	hl(0, "SnackHovered", { fg = c.orange_70, bg = c.bg_dark, bold = true })
	hl(0, "SnackRoot", { fg = c.orange, bold = true })

	-- ── Dashboard ────────────────────────────────────────────────
	hl(0, "SnacksDashboardDir", { fg = c.grey_soft, bold = true })
	hl(0, "SnacksDashboardHeader", { fg = c.orange, bold = true })
	hl(0, "SnacksDashboardIcon", { fg = c.orange })
	hl(0, "SnacksDashboardDesc", { fg = c.fg })
	hl(0, "SnacksDashboardKey", { fg = c.orange_80 })
	hl(0, "SnacksDashboardSpecial", { fg = c.orange_70 })
	hl(0, "SnacksDashboardTitle", { fg = c.orange, bold = true })
	hl(0, "SnacksDashboardFooter", { fg = c.grey, italic = true })

	-- ── Activity Bar ─────────────────────────────────────────────
	hl(0, "SnackActivityBar", { fg = c.orange_70, bg = c.bg_dark })
	hl(0, "SnackActivityBarInactive", { fg = c.fg, bg = c.bg_dark })
end

return M
