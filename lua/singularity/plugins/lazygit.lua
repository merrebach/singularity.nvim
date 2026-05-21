-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Lazygit Highlights                         ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	-- Float window that hosts the lazygit terminal
	hl(0, "LazyGitFloat", { fg = c.fg, bg = c.bg_dark })
	hl(0, "LazyGitBorder", { fg = c.orange_60, bg = c.bg_dark })
end

return M
