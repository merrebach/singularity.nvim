-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Vim Syntax (legacy highlight groups)       ║
-- ║                                                            ║
-- ║  These are Vim's built-in syntax groups (Comment, Keyword,  ║
-- ║  Function, etc.) used as fallback when neither Treesitter   ║
-- ║  nor LSP provides highlighting for a token.                 ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	hl(0, "Comment", s.comment)
	hl(0, "Keyword", s.keyword)
	hl(0, "Function", s.func)
	hl(0, "Identifier", s.variable)
	hl(0, "String", s.string)
	hl(0, "Number", s.number)
	hl(0, "Boolean", s.boolean)
	hl(0, "Type", s.type)
	hl(0, "Special", s.string_special)
	hl(0, "Conditional", s.keyword)
	hl(0, "Repeat", s.keyword)
	hl(0, "Statement", s.keyword)
	hl(0, "Exception", s.keyword)
	hl(0, "Operator", s.operator)
	hl(0, "PreProc", s.keyword)
	hl(0, "Include", s.keyword)
end

return M
