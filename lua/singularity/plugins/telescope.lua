-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Telescope Highlights                       ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	-- ── Layout ───────────────────────────────────────────────────
	hl(0, "TelescopeNormal", { fg = c.fg, bg = c.bg_dark })
	hl(0, "TelescopeBorder", { fg = c.orange_60, bg = c.bg_dark })

	-- ── Prompt ───────────────────────────────────────────────────
	hl(0, "TelescopePromptNormal", { fg = c.fg, bg = c.bg_dark })
	hl(0, "TelescopePromptBorder", { fg = c.orange, bg = c.bg_dark })
	hl(0, "TelescopePromptTitle", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "TelescopePromptPrefix", { fg = c.orange, bg = c.bg_dark })
	hl(0, "TelescopePromptCounter", { fg = c.grey, bg = c.bg_dark })

	-- ── Results ──────────────────────────────────────────────────
	hl(0, "TelescopePathPrefix", { fg = c.grey_dark })
	hl(0, "TelescopeHiddenFile", { fg = c.grey_dark, italic = true })
	hl(0, "TelescopeResultsNormal", { fg = c.fg, bg = c.bg_dark })
	hl(0, "TelescopeResultsBorder", { fg = c.orange_60, bg = c.bg_dark })
	hl(0, "TelescopeResultsTitle", { fg = c.bg, bg = c.grey_soft, bold = true })

	-- ── Preview ──────────────────────────────────────────────────
	hl(0, "TelescopePreviewNormal", { fg = c.fg, bg = c.bg })
	hl(0, "TelescopePreviewBorder", { fg = c.orange_60, bg = c.bg })
	hl(0, "TelescopePreviewTitle", { fg = c.bg, bg = c.slate_grey, bold = true })
	hl(0, "TelescopePreviewLine", { bg = c.bg_soft })
	hl(0, "TelescopePreviewMatch", { fg = c.orange, bold = true })

	-- ── Selection & Matching ─────────────────────────────────────
	hl(0, "TelescopeSelection", { fg = c.fg, bg = c.bg_soft })
	hl(0, "TelescopeSelectionCaret", { fg = c.orange, bg = c.bg_soft })
	hl(0, "TelescopeMultiSelection", { fg = c.orange, bg = c.bg_soft })
	hl(0, "TelescopeMultiIcon", { fg = c.orange })
	hl(0, "TelescopeMatching", { fg = c.orange, bold = true })

	-- ── Preview Syntax Highlighting ──────────────────────────────
	-- These ensure the preview window respects our theme colors
	-- for key syntax elements even when treesitter is not active.
	hl(0, "TelescopePreviewMessageFillchar", { fg = c.grey_dark })
	hl(0, "TelescopePreviewMessage", { fg = c.grey })
	hl(0, "TelescopePreviewDate", { fg = c.slate_grey_80 })
	hl(0, "TelescopePreviewUser", { fg = c.warm_sand })
	hl(0, "TelescopePreviewGroup", { fg = c.cream })
	hl(0, "TelescopePreviewSize", { fg = c.orange_80 })
	hl(0, "TelescopePreviewHyphen", { fg = c.grey_dark })
	hl(0, "TelescopePreviewDirectory", { fg = c.grey_soft })
	hl(0, "TelescopePreviewExecute", { fg = c.success_green })
	hl(0, "TelescopePreviewRead", { fg = c.w_grey_70 })
	hl(0, "TelescopePreviewWrite", { fg = c.warn_yellow })
	hl(0, "TelescopePreviewCharDev", { fg = c.slate_grey })
	hl(0, "TelescopePreviewBlock", { fg = c.grey })
	hl(0, "TelescopePreviewLink", { fg = c.orange_70, underline = true })
	hl(0, "TelescopePreviewSocket", { fg = c.orange })
	hl(0, "TelescopePreviewPipe", { fg = c.orange_60 })
	hl(0, "TelescopePreviewSticky", { fg = c.warn_yellow })
end

return M
