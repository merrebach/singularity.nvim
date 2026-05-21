-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Bufferline Highlights                      ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	hl(0, "BufferLineFill", { bg = c.bg })
	hl(0, "BufferLineBackground", { fg = c.grey, bg = c.bg_dark })
	hl(0, "BufferLineTab", { fg = c.grey, bg = c.bg_dark })
	hl(0, "BufferLineTabSelected", { fg = c.fg, bg = c.bg })
	hl(0, "BufferLineTabClose", { fg = c.error_red, bg = c.bg_dark })
	hl(0, "BufferLineBuffer", { fg = c.grey, bg = c.bg_dark })
	hl(0, "BufferLineBufferSelected", { fg = c.fg, bg = c.bg, bold = true })
	hl(0, "BufferLineBufferVisible", { fg = c.grey_soft, bg = c.bg_soft })
	hl(0, "BufferLineCloseButton", { fg = c.grey, bg = c.bg_dark })
	hl(0, "BufferLineCloseButtonSelected", { fg = c.error_red, bg = c.bg })
	hl(0, "BufferLineCloseButtonVisible", { fg = c.grey, bg = c.bg_soft })
	hl(0, "BufferLineIndicatorSelected", { fg = c.orange, bg = c.bg })
	hl(0, "BufferLineSeparator", { fg = c.bg, bg = c.bg_dark })
	hl(0, "BufferLineSeparatorSelected", { fg = c.bg, bg = c.bg })
	hl(0, "BufferLineSeparatorVisible", { fg = c.bg, bg = c.bg_soft })
	hl(0, "BufferLineModified", { fg = c.warn_yellow, bg = c.bg_dark })
	hl(0, "BufferLineModifiedSelected", { fg = c.warn_yellow, bg = c.bg })
	hl(0, "BufferLineModifiedVisible", { fg = c.warn_yellow, bg = c.bg_soft })
end

return M
