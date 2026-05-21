-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Completion (cmp) Highlights                ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	hl(0, "CmpItemAbbr", { fg = c.fg })
	hl(0, "CmpItemAbbrDeprecated", { fg = c.grey, strikethrough = true })
	hl(0, "CmpItemAbbrMatch", { fg = c.orange, bold = true })
	hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.orange_70, bold = true })
	hl(0, "CmpItemKind", s.type)
	hl(0, "CmpItemKindVariable", s.variable)
	hl(0, "CmpItemKindInterface", s.type)
	hl(0, "CmpItemKindText", { fg = c.fg })
	hl(0, "CmpItemKindFunction", s.func)
	hl(0, "CmpItemKindMethod", s.method)
	hl(0, "CmpItemKindKeyword", s.keyword)
	hl(0, "CmpItemKindProperty", s.property)
	hl(0, "CmpItemKindUnit", s.number)
	hl(0, "CmpItemKindClass", s.type)
	hl(0, "CmpItemKindStruct", s.type)
	hl(0, "CmpItemKindEnum", s.type)
	hl(0, "CmpItemKindModule", s.module)
	hl(0, "CmpItemKindSnippet", s.diag_success)
end

return M
