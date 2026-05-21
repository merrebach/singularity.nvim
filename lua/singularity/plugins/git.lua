-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Git Highlights (GitSigns, etc.)            ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	hl(0, "GitSignsAddNr", s.git_add)
	hl(0, "GitSignsChangeNr", s.git_change)
	hl(0, "GitSignsDeleteNr", s.git_delete)
	hl(0, "GitSignsCurrentLineBlame", { fg = c.grey_dark, italic = true })
end

return M
