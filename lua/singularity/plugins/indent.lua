-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Indent & Whitespace Highlights             ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local hl = vim.api.nvim_set_hl

	-- Indent Blankline
	hl(0, "IblIndent", { fg = c.bg })
	hl(0, "IblScope", { fg = c.bg })
	hl(0, "IblWhitespace", { fg = c.bg })
	hl(0, "IndentBlanklineChar", { fg = c.bg })
	hl(0, "IndentBlanklineContextChar", { fg = c.bg })

	-- Rainbow Delimiters — Orange ramp
	hl(0, "RainbowDelimiterRed", { fg = c.orange })
	hl(0, "RainbowDelimiterYellow", { fg = c.orange_80 })
	hl(0, "RainbowDelimiterBlue", { fg = c.orange_70 })
	hl(0, "RainbowDelimiterOrange", { fg = c.orange_60 })
	hl(0, "RainbowDelimiterGreen", { fg = c.orange_50 })
	hl(0, "RainbowDelimiterViolet", { fg = c.orange_40 })
	hl(0, "RainbowDelimiterCyan", { fg = c.orange_30 })

	-- Mini indentscope
	hl(0, "MiniIndentscopeSymbol", { fg = c.orange_40 })
	hl(0, "MiniIndentscopeSymbolOff", { fg = c.orange_15 })

	-- Whitespace
	hl(0, "Whitespace", { fg = c.bg })
end

return M
