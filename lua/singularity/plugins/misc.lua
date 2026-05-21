-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Miscellaneous Plugin Highlights            ║
-- ║  (Todo-comments, etc.)                                     ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	-- Todo-comments
	hl(0, "TodoBgNOTE", s.comment_doc)
	hl(0, "TodoFgNOTE", { fg = c.grey })
	hl(0, "TodoSignNOTE", { fg = c.grey })
end

return M
