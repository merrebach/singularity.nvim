-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Statusline (Lualine) Highlights            ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	hl(0, "LualineNormal", { fg = c.bg, bg = c.orange })
	hl(0, "LualineInsert", { fg = c.bg, bg = c.success_green })
	hl(0, "LualineVisual", { fg = c.bg, bg = c.warn_yellow })
	hl(0, "LualineReplace", { fg = c.bg, bg = c.error_red })
	hl(0, "LualineCommand", { fg = c.bg, bg = c.info_grey })
	hl(0, "LualineInactive", { fg = c.grey, bg = c.bg_soft })
end

return M
