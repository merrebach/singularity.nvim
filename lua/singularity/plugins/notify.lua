-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Notify Highlights                          ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	hl(0, "NotifyERRORBorder", { fg = c.error_red })
	hl(0, "NotifyWARNBorder", { fg = c.warn_yellow })
	hl(0, "NotifyINFOBorder", { fg = c.info_grey })
	hl(0, "NotifyDEBUGBorder", { fg = c.grey_soft })
	hl(0, "NotifyTRACEBorder", { fg = c.slate_grey })
	hl(0, "NotifyERRORIcon", { fg = c.error_red })
	hl(0, "NotifyWARNIcon", { fg = c.warn_yellow })
	hl(0, "NotifyINFOIcon", { fg = c.info_grey })
	hl(0, "NotifyDEBUGIcon", { fg = c.grey_soft })
	hl(0, "NotifyTRACEIcon", { fg = c.slate_grey })
	hl(0, "NotifyERRORTitle", { fg = c.error_red, bold = true })
	hl(0, "NotifyWARNTitle", { fg = c.warn_yellow, bold = true })
	hl(0, "NotifyINFOTitle", { fg = c.info_grey, bold = true })
	hl(0, "NotifyDEBUGTitle", { fg = c.grey_soft, bold = true })
	hl(0, "NotifyTRACETitle", { fg = c.slate_grey, bold = true })
end

return M
