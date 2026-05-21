-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Neo-tree / NvimTree Highlights             ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	hl(0, "NeoTreeNormal", { fg = c.fg, bg = c.bg_dark })
	hl(0, "NeoTreeNormalNC", { fg = c.grey, bg = c.bg_dark })
	hl(0, "NeoTreeDirectoryName", { fg = c.grey_soft })
	hl(0, "NeoTreeDirectoryIcon", { fg = c.grey_soft })
	hl(0, "NeoTreeFileName", { fg = c.fg })
	hl(0, "NeoTreeFileIcon", { fg = c.grey_soft })
	hl(0, "NeoTreeRootName", { fg = c.orange, bold = true })
	hl(0, "NeoTreeIndentMarker", { fg = c.grey_dark })
	hl(0, "NeoTreeExpander", { fg = c.orange })
	hl(0, "NeoTreeGitAdded", s.git_add)
	hl(0, "NeoTreeGitDeleted", s.git_delete)
	hl(0, "NeoTreeGitModified", s.git_change)
	hl(0, "NeoTreeGitConflict", { fg = c.orange })
	hl(0, "NeoTreeGitUntracked", { fg = c.grey })
end

return M
