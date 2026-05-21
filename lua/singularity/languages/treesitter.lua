-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Treesitter Base Highlights                 ║
-- ║                                                            ║
-- ║  Generic @capture groups used as cross-language defaults.   ║
-- ║  Language-specific files (python.lua, typescript.lua, etc.) ║
-- ║  can override these with .<ft> suffix.                      ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	local map = {
		-- ── Identifiers ──────────────────────────────────────────────
		["@variable"]               = s.variable,
		["@variable.builtin"]       = s.variable_builtin,
		["@variable.parameter"]     = s.parameter,
		["@variable.member"]        = s.property,

		-- ── Constants ────────────────────────────────────────────────
		["@constant"]               = s.constant,
		["@constant.builtin"]       = s.constant_builtin,
		["@constant.macro"]         = s.constant_macro,

		-- ── Modules & Namespaces ─────────────────────────────────────
		["@module"]                 = s.module,
		["@module.builtin"]         = s.module_builtin,

		-- ── Symbols ──────────────────────────────────────────────────
		["@symbol"]                 = { fg = c.grey_soft },

		-- ── Text & Markup (legacy @text.*) ───────────────────────────
		["@text"]                          = { fg = c.fg },
		["@text.strong"]                   = { fg = c.orange, bold = true },
		["@text.emphasis"]                 = { fg = c.orange, italic = true },
		["@text.underline"]                = { underline = true },
		["@text.strike"]                   = { strikethrough = true },
		["@text.title"]                    = s.markup_heading,
		["@text.title.1"]                  = { fg = c.orange, bold = true },
		["@text.title.2"]                  = { fg = c.orange_80, bold = true },
		["@text.title.3"]                  = { fg = c.orange_70, bold = true },
		["@text.title.4"]                  = { fg = c.orange_60, bold = true },
		["@text.title.5"]                  = { fg = c.orange_50 },
		["@text.title.6"]                  = { fg = c.orange_40 },
		["@text.literal"]                  = s.markup_code,
		["@text.uri"]                      = s.string_url,
		["@text.math"]                     = s.markup_math,
		["@text.environment"]              = { fg = c.grey_soft },
		["@text.environment.name"]         = { fg = c.warm_grey },
		["@text.reference"]                = { fg = c.slate_grey_80, bold = true },
		["@text.todo"]                     = s.comment_todo,
		["@text.note"]                     = s.comment_note,
		["@text.warning"]                  = s.comment_todo,
		["@text.danger"]                   = { fg = c.bg, bg = c.error_red },
		["@text.diff.add"]                 = s.git_add,
		["@text.diff.delete"]              = s.git_delete,

		-- ── Strings ──────────────────────────────────────────────────
		["@string"]                        = s.string,
		["@string.documentation"]          = s.string_doc,
		["@string.regexp"]                 = s.string_regex,
		["@string.escape"]                 = s.string_escape,
		["@string.special"]                = s.string_special,
		["@string.special.symbol"]         = { fg = c.grey_soft },
		["@string.special.url"]            = s.string_url,
		["@string.special.path"]           = { fg = c.slate_grey_80 },

		-- ── Characters ───────────────────────────────────────────────
		["@character"]                     = s.character,
		["@character.special"]             = s.character_special,

		-- ── Booleans & Numbers ───────────────────────────────────────
		["@boolean"]                       = s.boolean,
		["@number"]                        = s.number,
		["@number.float"]                  = s.number,

		-- ── Types ────────────────────────────────────────────────────
		["@type"]                          = s.type,
		["@type.builtin"]                  = s.type_builtin,
		["@type.definition"]               = s.type_definition,
		["@type.qualifier"]                = s.keyword_declaration,
		["@attribute"]                     = s.attribute,
		["@property"]                      = s.property,

		-- ── Functions ────────────────────────────────────────────────
		["@function"]                      = s.func,
		["@function.builtin"]              = s.func_builtin,
		["@function.call"]                 = s.func,
		["@function.macro"]                = s.func,
		["@function.method"]               = s.method,
		["@function.method.call"]          = s.method,
		["@constructor"]                   = s.constructor,

		-- ── Keywords ─────────────────────────────────────────────────
		-- Control flow: plain orange. Declaration / storage: orange + italic.
		["@keyword"]                       = s.keyword,
		["@keyword.coroutine"]             = s.keyword,
		["@keyword.function"]              = s.keyword_declaration,
		["@keyword.operator"]              = s.keyword_operator,
		["@keyword.import"]                = s.keyword_declaration,
		["@keyword.export"]                = s.keyword_declaration,
		["@keyword.storage"]               = s.keyword_declaration,
		["@keyword.type"]                  = s.keyword_declaration,
		["@keyword.modifier"]              = s.keyword_declaration,
		["@keyword.repeat"]                = s.keyword,
		["@keyword.return"]                = s.keyword,
		["@keyword.debug"]                 = { fg = c.orange, bold = false },
		["@keyword.exception"]             = s.keyword,
		["@keyword.conditional"]           = s.keyword,
		["@keyword.conditional.ternary"]   = s.keyword_operator,
		["@keyword.directive"]             = { fg = c.w_grey_70 },
		["@keyword.directive.define"]      = { fg = c.warm_grey },

		-- ── Operators & Punctuation ──────────────────────────────────
		["@operator"]                      = s.operator,
		["@punctuation.delimiter"]         = s.punctuation_delimiter,
		["@punctuation.bracket"]           = s.punctuation,
		["@punctuation.special"]           = s.punctuation_special,

		-- ── Comments ─────────────────────────────────────────────────
		["@comment"]                       = s.comment,
		["@comment.documentation"]         = s.comment_doc,
		["@comment.error"]                 = s.comment_error,
		["@comment.warning"]               = s.comment_warning,
		["@comment.todo"]                  = s.comment_todo,
		["@comment.note"]                  = s.comment_note,

		-- ── Markup ───────────────────────────────────────────────────
		["@markup.strong"]                 = { fg = c.orange, bold = true },
		["@markup.italic"]                 = { fg = c.orange, italic = true },
		["@markup.strikethrough"]          = { strikethrough = true },
		["@markup.underline"]              = { underline = true },
		["@markup.heading"]                = { fg = c.orange, bold = true },
		["@markup.heading.1"]              = { fg = c.orange, bold = true },
		["@markup.heading.2"]              = { fg = c.orange_80, bold = true },
		["@markup.heading.3"]              = { fg = c.orange_70, bold = true },
		["@markup.heading.4"]              = { fg = c.orange_60, bold = true },
		["@markup.heading.5"]              = { fg = c.orange_50 },
		["@markup.heading.6"]              = { fg = c.orange_40 },
		["@markup.quote"]                  = s.markup_quote,
		["@markup.math"]                   = s.markup_math,
		["@markup.link"]                   = s.markup_link,
		["@markup.link.label"]             = { fg = c.slate_grey_80 },
		["@markup.link.url"]               = { fg = c.slate_grey_80, underline = true, italic = true },
		["@markup.raw"]                    = s.markup_code,
		["@markup.raw.block"]              = s.markup_code,
		["@markup.list"]                   = { fg = c.orange_70 },
		["@markup.list.checked"]           = { fg = c.success_green, bold = true },
		["@markup.list.unchecked"]         = { fg = c.orange_70 },

		-- ── Tags (HTML, XML) ─────────────────────────────────────────
		["@tag"]                           = s.tag,
		["@tag.builtin"]                   = s.tag_builtin,
		["@tag.attribute"]                 = s.tag_attribute,
		["@tag.delimiter"]                 = s.tag_delimiter,

		-- ── Language-specific base overrides ─────────────────────────
		-- CSS
		["@property.css"]                  = s.diag_info,
		["@string.special.url.css"]        = { fg = c.info_grey, underline = true },
		-- YAML
		["@field.yaml"]                    = s.diag_info,
		-- TOML
		["@property.toml"]                 = s.diag_info,
		-- JSON
		["@label.json"]                    = s.diag_info,
		-- Lua
		["@constructor.lua"]               = { fg = c.orange_70 },
		-- Diff
		["@diff.plus"]                     = s.git_add,
		["@diff.minus"]                    = s.git_delete,
		["@diff.delta"]                    = s.git_change,
	}

	for group, spec in pairs(map) do
		hl(0, group, spec)
	end
end

return M
