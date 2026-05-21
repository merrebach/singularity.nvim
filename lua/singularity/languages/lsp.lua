-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — LSP Highlights (Central)                    ║
-- ║                                                              ║
-- ║  This file defines ALL LSP-related highlight groups:         ║
-- ║    1. Neovim built-in Lsp* groups (Document Highlight,       ║
-- ║       Inlay Hints, CodeLens, Signature Help)                 ║
-- ║    2. Diagnostic virtual text links                          ║
-- ║    3. Generic @lsp.type.* fallbacks (link → Treesitter)      ║
-- ║    4. Generic @lsp.mod.* modifiers                           ║
-- ║    5. Generic @lsp.typemod.* combinations                    ║
-- ║                                                              ║
-- ║  Language-specific overrides live in typescript.lua,          ║
-- ║  python.lua, rust.lua — they take precedence over these      ║
-- ║  generic fallbacks.                                          ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	local map = {
		-- ── Document Highlight (References) ──────────────────────────
		["LspReferenceText"]          = { bg = c.bg_soft },
		["LspReferenceRead"]          = { bg = c.bg_soft },
		["LspReferenceWrite"]         = { bg = c.bg_soft, underline = true },
		["LspReferenceTarget"]        = { bg = c.bg_soft, bold = true },

		-- ── Inlay Hints ───────────────────────────────────────────────
		["LspInlayHint"]              = { fg = c.grey_dark, bg = "NONE", italic = true },

		-- ── CodeLens ─────────────────────────────────────────────────
		["LspCodeLens"]               = { fg = c.grey_dark, italic = true },
		["LspCodeLensSeparator"]      = { fg = c.bg_soft },

		-- ── Signature Help ────────────────────────────────────────────
		["LspSignatureActiveParameter"] = { fg = c.orange, bold = true },

		-- ── Diagnostic virtual text / signs / floats ──────────────────
		["DiagnosticVirtualTextError"] = { link = "DiagnosticError" },
		["DiagnosticVirtualTextWarn"]  = { link = "DiagnosticWarn" },
		["DiagnosticVirtualTextInfo"]  = { link = "DiagnosticInfo" },
		["DiagnosticVirtualTextHint"]  = { link = "DiagnosticHint" },
		["DiagnosticFloatingError"]    = { link = "DiagnosticError" },
		["DiagnosticFloatingWarn"]     = { link = "DiagnosticWarn" },
		["DiagnosticFloatingInfo"]     = { link = "DiagnosticInfo" },
		["DiagnosticFloatingHint"]     = { link = "DiagnosticHint" },
		["DiagnosticSignError"]        = { link = "DiagnosticError" },
		["DiagnosticSignWarn"]         = { link = "DiagnosticWarn" },
		["DiagnosticSignInfo"]         = { link = "DiagnosticInfo" },
		["DiagnosticSignHint"]         = { link = "DiagnosticHint" },

		-- ── Generic @lsp.type.* fallbacks ────────────────────────────
		["@lsp.type.variable"]        = { link = "@variable" },
		["@lsp.type.parameter"]       = { link = "@variable.parameter" },
		["@lsp.type.property"]        = { link = "@property" },
		["@lsp.type.event"]           = { link = "@property" },
		["@lsp.type.class"]           = { link = "@type" },
		["@lsp.type.struct"]          = { link = "@type" },
		["@lsp.type.enum"]            = { link = "@type" },
		["@lsp.type.interface"]       = { link = "@type" },
		["@lsp.type.type"]            = { link = "@type" },
		["@lsp.type.typeParameter"]   = { link = "@module" },
		["@lsp.type.enumMember"]      = s.enum_member,
		["@lsp.type.function"]        = { link = "@function" },
		["@lsp.type.method"]          = { link = "@function.method" },
		["@lsp.type.decorator"]       = { link = "@attribute" },
		["@lsp.type.namespace"]       = { link = "@module" },
		["@lsp.type.module"]          = { link = "@module" },
		["@lsp.type.keyword"]         = { link = "@keyword" },
		["@lsp.type.modifier"]        = s.keyword_declaration,
		["@lsp.type.operator"]        = { link = "@operator" },
		["@lsp.type.string"]          = { link = "@string" },
		["@lsp.type.number"]          = { link = "@number" },
		["@lsp.type.boolean"]         = { link = "@boolean" },
		["@lsp.type.regexp"]          = { link = "@string.regexp" },
		["@lsp.type.comment"]         = { link = "@comment" },
		-- Rust/generic extras
		["@lsp.type.trait"]           = vim.tbl_extend("force", s.type, { italic = true }),
		["@lsp.type.lifetime"]        = { link = "@label" },
		["@lsp.type.macro"]           = { link = "@keyword" },
		["@lsp.type.selfKeyword"]     = s.variable_builtin,

		-- ── Generic @lsp.mod.* modifiers ─────────────────────────────
		["@lsp.mod.deprecated"]       = { strikethrough = true },
		["@lsp.mod.readonly"]         = { underline = true },
		["@lsp.mod.async"]            = { italic = true },
		["@lsp.mod.static"]           = {},
		["@lsp.mod.abstract"]         = { italic = true },
		["@lsp.mod.declaration"]      = {},
		["@lsp.mod.defaultLibrary"]   = { italic = true },
		["@lsp.mod.definition"]       = {},

		-- ── Generic @lsp.typemod.* combinations ──────────────────────
		-- Variable modifiers
		["@lsp.typemod.variable.readonly"]        = s.variable_readonly,
		["@lsp.typemod.variable.defaultLibrary"]  = s.variable_default_lib,
		["@lsp.typemod.variable.deprecated"]      = s.variable_deprecated,
		["@lsp.typemod.variable.global"]          = s.variable_global,
		-- Parameter modifiers
		["@lsp.typemod.parameter.readonly"]       = s.parameter_readonly,
		["@lsp.typemod.parameter.deprecated"]     = s.parameter_deprecated,
		-- Function modifiers
		["@lsp.typemod.function.declaration"]     = s.func_declaration,
		["@lsp.typemod.function.async"]           = s.func_async,
		["@lsp.typemod.function.defaultLibrary"]  = s.func_default_lib,
		["@lsp.typemod.function.deprecated"]      = s.func_deprecated,
		-- Method modifiers
		["@lsp.typemod.method.declaration"]       = s.method_declaration,
		["@lsp.typemod.method.async"]             = s.method_async,
		["@lsp.typemod.method.static"]            = s.method_static,
		["@lsp.typemod.method.abstract"]          = s.method_abstract,
		["@lsp.typemod.method.defaultLibrary"]    = s.method_default_lib,
		["@lsp.typemod.method.deprecated"]        = s.method_deprecated,
		-- Class modifiers
		["@lsp.typemod.class.declaration"]        = s.type_definition,
		["@lsp.typemod.class.abstract"]           = vim.tbl_extend("force", s.type, { italic = true }),
		["@lsp.typemod.class.defaultLibrary"]     = s.type_default_lib,
		["@lsp.typemod.class.deprecated"]         = s.type_deprecated,
		-- Interface modifiers
		["@lsp.typemod.interface.declaration"]    = s.type_definition,
		["@lsp.typemod.interface.defaultLibrary"] = s.type_default_lib,
		["@lsp.typemod.interface.deprecated"]     = s.type_deprecated,
		-- Enum modifiers
		["@lsp.typemod.enum.declaration"]         = s.type_definition,
		["@lsp.typemod.enum.deprecated"]          = s.type_deprecated,
		["@lsp.typemod.enumMember.deprecated"]    = { fg = c.orange_80, strikethrough = true },
		-- Type modifiers
		["@lsp.typemod.type.declaration"]         = s.type_definition,
		["@lsp.typemod.type.defaultLibrary"]      = s.type_default_lib,
		["@lsp.typemod.type.deprecated"]          = s.type_deprecated,
		["@lsp.typemod.typeParameter.declaration"] = s.module,
		-- Namespace modifiers
		["@lsp.typemod.namespace.declaration"]    = s.module,
		["@lsp.typemod.namespace.defaultLibrary"] = s.module_builtin,
		-- Property modifiers
		["@lsp.typemod.property.declaration"]     = s.property,
		["@lsp.typemod.property.readonly"]        = s.property_readonly,
		["@lsp.typemod.property.static"]          = s.property,
		["@lsp.typemod.property.defaultLibrary"]  = s.property_default_lib,
		["@lsp.typemod.property.deprecated"]      = s.property_deprecated,
	}

	for group, spec in pairs(map) do
		hl(0, group, spec)
	end
end

return M
