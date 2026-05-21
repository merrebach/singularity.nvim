-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Rust Highlights                            ║
-- ║                                                            ║
-- ║  Only captures that differ from treesitter/lsp base.        ║
-- ║  Everything else inherits from languages/treesitter.lua or  ║
-- ║  languages/lsp.lua.                                         ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	local map = {
		-- macros are keyword-like in Rust; base maps @function.macro → s.func
		["@function.macro.rust"]   = s.keyword,
		-- @namespace has no base mapping
		["@namespace.rust"]        = s.module,
		-- enum variants are constants, not constructors; base maps @constructor → s.constructor
		["@constructor.rust"]      = s.constant,
		-- lsp generic maps @lsp.type.macro → @keyword (= s.keyword); macro modifier is declaration-axis
		["@lsp.type.macro.rust"]   = s.keyword_declaration,
	}

	for group, spec in pairs(map) do
		hl(0, group, spec)
	end

	-- mutable variable underline — no generic equivalent
	hl(0, "@lsp.typemod.variable.mutable.rust", { fg = c.fg, underline = true })
end

return M
