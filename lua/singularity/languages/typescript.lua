-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — TypeScript / TSX Highlights                ║
-- ║                                                            ║
-- ║  Custom captures from after/queries/typescript/            ║
-- ║  highlights.scm + standard overrides.                      ║
-- ║  Standard captures inherit from languages/treesitter.lua.  ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	local map = {
		-- ── Standard overrides (differ from treesitter base) ─────────
		-- @namespace.typescript omitted: query emits @module.namespace, never bare @namespace
		-- no base @variable.parameter.builtin
		["@variable.parameter.builtin.typescript"] = s.variable_builtin,
		-- no base @label
		["@label.typescript"]                   = s.label,
		-- no base @attribute.builtin
		["@attribute.builtin.typescript"]       = s.decorator_builtin,
		-- no base @string.template
		["@string.template.typescript"]         = s.string_special,
		-- @constant.enum.typescript omitted: query uses @type.enum.member.*, never emits @constant.enum
		-- base @punctuation.special = s.punctuation_special (orange_70); TS uses orange_60
		["@punctuation.special.typescript"]     = { fg = c.orange_60 },
		-- no base @punctuation.colon / .comma / .dot / .semicolon
		["@punctuation.colon.typescript"]       = { fg = c.orange_60 },
		["@punctuation.comma.typescript"]       = s.punctuation_delimiter,
		["@punctuation.dot.typescript"]         = s.punctuation_delimiter,
		["@punctuation.semicolon.typescript"]   = s.punctuation_delimiter,

		-- ╔══════════════════════════════════════════════════════════════╗
		-- ║            CUSTOM TREESITTER CAPTURES                       ║
		-- ║  Mapped from after/queries/typescript/highlights.scm        ║
		-- ╚══════════════════════════════════════════════════════════════╝

		-- ── 1. Variable Declarations ─────────────────────────────────
		["@keyword.declaration.const.typescript"]    = s.keyword_declaration,
		["@keyword.declaration.let.typescript"]      = s.keyword_declaration,
		["@keyword.declaration.var.typescript"]      = s.keyword_declaration,
		["@keyword.declaration.using.typescript"]    = s.keyword_declaration,
		["@variable.declaration.const.typescript"]   = vim.tbl_extend("force", s.variable, { bold = false }),
		["@variable.declaration.let.typescript"]     = s.variable,
		["@variable.declaration.var.typescript"]     = s.variable,
		["@variable.declaration.definite.typescript"] = vim.tbl_extend("force", s.variable, { underline = true }),

		-- ── 2. Type System ───────────────────────────────────────────
		["@type.generic.typescript"]                 = s.type,
		["@type.generic.nested.typescript"]          = s.type,
		["@type.module.typescript"]                  = s.module,
		["@type.argument.typescript"]                = { fg = c.cream_80 },
		["@type.parameter.typescript"]               = { fg = c.slate_grey_70, italic = true },
		["@type.parameter.default.typescript"]       = { fg = c.slate_grey_60, italic = true },
		["@type.constraint.typescript"]              = s.type,
		["@type.nested.typescript"]                  = s.type,
		["@type.union.typescript"]                   = s.type,
		["@type.intersection.typescript"]            = s.type,
		["@type.tuple_element.typescript"]           = s.type,
		["@variable.tuple_label.typescript"]         = { fg = c.cream_80, italic = true },
		["@variable.tuple_label.optional.typescript"] = { fg = c.cream_80, italic = true },
		["@type.rest.typescript"]                    = s.type,
		["@type.optional.typescript"]                = s.type,
		-- Mapped types
		["@type.mapped.key.typescript"]              = { fg = c.slate_grey_70, italic = true },
		["@keyword.operator.in_type.typescript"]     = s.keyword_operator,
		["@type.mapped.alias.typescript"]            = s.type,
		-- Conditional types
		["@type.conditional.check.typescript"]       = s.type,
		["@type.conditional.extends.typescript"]     = s.type,
		["@type.conditional.true.typescript"]        = s.type,
		["@type.conditional.false.typescript"]       = s.type,
		-- Index, keyof, typeof, infer
		["@type.lookup.typescript"]                  = s.type,
		["@keyword.operator.keyof.typescript"]       = s.keyword_operator,
		["@keyword.operator.typeof_type.typescript"] = s.keyword_operator,
		["@keyword.operator.infer.typescript"]       = s.keyword_operator,
		["@type.keyof_target.typescript"]            = s.type,
		["@type.inferred.typescript"]                = { fg = c.cream_80, italic = true },
		-- Assertions
		["@type.assertion.typescript"]               = s.type,
		["@type.assertion.as.typescript"]            = s.type,
		["@type.satisfies.typescript"]               = s.type,
		["@keyword.operator.as.typescript"]          = s.keyword_operator,
		["@keyword.operator.as_const.typescript"]    = s.keyword_operator,
		["@keyword.operator.satisfies.typescript"]   = s.keyword_operator,
		-- Other type constructs
		["@type.readonly.typescript"]                = s.type,
		["@type.array_element.typescript"]           = s.type,
		["@type.this.typescript"]                    = s.variable_builtin,
		["@type.existential.typescript"]             = s.type,
		["@type.literal.string.typescript"]          = s.type_builtin,
		["@type.literal.number.typescript"]          = s.type_builtin,
		["@type.literal.boolean.typescript"]         = s.type_builtin,
		["@type.literal.null.typescript"]            = s.type_builtin,
		["@type.literal.undefined.typescript"]       = s.type_builtin,
		["@type.literal.sign.typescript"]            = s.operator,
		["@type.template_literal.typescript"]        = s.type,
		["@punctuation.type.arrow.typescript"]       = s.operator,
		["@keyword.operator.new_type.typescript"]    = s.keyword,
		["@punctuation.type.colon.typescript"]       = { fg = c.orange_60 },
		["@type.parenthesized.typescript"]           = s.type,
		["@type.maybe.typescript"]                   = s.type,
		-- Utility types
		["@type.utility.typescript"]                 = vim.tbl_extend("force", s.type, { italic = true }),

		-- ── 3. Interface / Type Alias / Enum ─────────────────────────
		["@keyword.declaration.interface.typescript"] = s.keyword_declaration,
		["@type.interface.name.typescript"]           = s.type_definition,
		["@keyword.extends.typescript"]               = s.keyword,
		["@keyword.extends.class.typescript"]         = s.keyword,
		["@type.interface.extends.typescript"]        = s.type,
		["@type.interface.extends.nested.typescript"] = s.type,
		["@type.module.extends.typescript"]           = s.module,
		-- Property/method signatures
		["@property.signature.typescript"]            = s.property,
		["@property.signature.optional.typescript"]   = vim.tbl_extend("force", s.property, { italic = true }),
		["@property.signature.readonly.typescript"]   = vim.tbl_extend("force", s.property, { underline = true }),
		["@keyword.modifier.readonly.typescript"]     = s.keyword_declaration,
		["@function.method.signature.typescript"]     = s.method,
		["@function.method.signature.optional.typescript"] = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.call_signature.typescript"]       = s.func,
		["@keyword.operator.new_construct.typescript"] = s.keyword,
		-- Index signature
		["@variable.index_signature.typescript"]      = s.parameter,
		["@type.index_signature.typescript"]          = s.type,
		-- Type alias
		["@keyword.declaration.type.typescript"]      = s.keyword_declaration,
		["@type.alias.name.typescript"]               = s.type_definition,
		-- Enum
		["@keyword.declaration.enum.typescript"]      = s.keyword_declaration,
		["@type.enum.name.typescript"]                = s.type_definition,
		["@keyword.modifier.const_enum.typescript"]   = s.keyword,
		["@type.enum.member.typescript"]              = s.enum_member,
		["@type.enum.member.string.typescript"]       = s.enum_member,
		["@type.enum.member.numeric.typescript"]      = s.enum_member,

		-- ── 4. Classes ───────────────────────────────────────────────
		["@type.class.name.typescript"]               = s.type_definition,
		["@keyword.modifier.abstract.typescript"]     = s.keyword_declaration,
		["@type.class.abstract.typescript"]           = vim.tbl_extend("force", s.type, { italic = true }),
		["@type.class.extends.typescript"]            = s.type,
		["@keyword.implements.typescript"]            = s.keyword,
		["@type.class.implements.typescript"]         = s.type,
		["@type.class.type_parameter.typescript"]     = { fg = c.slate_grey_70, italic = true },
		-- Constructor
		["@constructor.typescript"]                   = s.constructor,
		["@property.constructor_param.typescript"]    = s.parameter,
		["@property.constructor_param.readonly.typescript"] = vim.tbl_extend("force", s.parameter, { underline = true }),
		-- Modifiers
		["@keyword.modifier.static.typescript"]       = s.keyword_declaration,
		["@keyword.modifier.static_block.typescript"] = s.keyword_declaration,
		["@keyword.modifier.override.typescript"]     = s.keyword_declaration,
		["@keyword.modifier.access.typescript"]       = s.keyword_declaration,
		["@keyword.modifier.access.param.typescript"] = s.keyword_declaration,
		["@keyword.modifier.declare.typescript"]      = s.keyword_declaration,
		["@keyword.modifier.accessor.typescript"]     = s.keyword_declaration,
		["@keyword.modifier.readonly.param.typescript"] = s.keyword_declaration,
		["@keyword.modifier.abstract.method.typescript"] = s.keyword_declaration,
		["@function.method.abstract.typescript"]      = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.method.abstract.optional.typescript"] = vim.tbl_extend("force", s.method, { italic = true }),
		-- Getter/Setter
		["@keyword.accessor.get.typescript"]          = s.keyword_declaration,
		["@keyword.accessor.set.typescript"]          = s.keyword_declaration,
		["@function.accessor.get.typescript"]         = s.func,
		["@function.accessor.set.typescript"]         = s.func,
		-- Class fields
		["@property.class_field.typescript"]          = s.property,
		["@property.class_field.optional.typescript"] = vim.tbl_extend("force", s.property, { italic = true }),
		["@property.class_field.definite.typescript"] = vim.tbl_extend("force", s.property, { underline = true }),
		["@property.class_field.readonly.typescript"] = vim.tbl_extend("force", s.property, { underline = true }),
		-- Decorators
		["@punctuation.special.decorator.typescript"] = { fg = c.cream },
		["@attribute.decorator.typescript"]           = s.decorator,
		["@attribute.decorator.call.typescript"]      = s.decorator,
		["@attribute.decorator.method.typescript"]    = s.decorator,
		["@attribute.decorator.method.call.typescript"] = s.decorator,
		["@attribute.decorator.module.typescript"]    = vim.tbl_extend("force", s.module, { italic = false }),
		["@attribute.decorator.module.call.typescript"] = vim.tbl_extend("force", s.module, { italic = false }),

		-- ── 5. Functions ─────────────────────────────────────────────
		["@function.declaration.typescript"]          = s.func_declaration,
		["@function.variable.arrow.typescript"]       = s.func,
		["@variable.parameter.optional.typescript"]   = vim.tbl_extend("force", s.parameter, { italic = true }),
		["@punctuation.parameter.optional.typescript"] = { fg = c.orange_60 },
		["@variable.parameter.rest.typescript"]       = s.parameter,
		["@variable.parameter.default.typescript"]    = s.parameter,
		["@variable.parameter.this.typescript"]       = s.variable_builtin,
		["@pattern.parameter.object.typescript"]      = s.punctuation,
		["@pattern.parameter.array.typescript"]       = s.punctuation,
		-- Return types
		["@type.return.typescript"]                   = s.type,
		["@type.return.builtin.typescript"]           = s.type_builtin,
		["@variable.type_predicate.typescript"]       = s.variable,
		["@keyword.operator.is.typescript"]           = s.keyword_operator,
		["@type.predicate.typescript"]                = s.type,
		["@keyword.operator.asserts.typescript"]      = s.keyword_operator,
		-- Function signature (overload/ambient)
		["@keyword.declaration.function.typescript"]  = s.keyword_declaration,
		["@function.signature.typescript"]            = s.func,
		-- Async/Generator
		["@keyword.coroutine.async.typescript"]       = s.keyword,
		["@function.generator.typescript"]            = s.func,
		["@punctuation.special.generator.typescript"] = s.punctuation_special,
		["@function.iife.typescript"]                 = s.func,

		-- ── 6. Object Literals ───────────────────────────────────────
		["@property.object.key.typescript"]           = s.property,
		["@property.object.key.string.typescript"]    = s.string,
		["@property.object.key.number.typescript"]    = s.number,
		["@property.object.key.computed.typescript"]  = { fg = c.cream_80, italic = true },
		["@property.object.shorthand.typescript"]     = s.property,
		["@function.method.object.typescript"]        = s.method,
		["@function.accessor.get.object.typescript"]  = s.func,
		["@operator.spread.typescript"]               = s.operator,

		-- ── 7. Destructuring ─────────────────────────────────────────
		["@variable.destructured.typescript"]          = s.variable,
		["@property.destructured.key.typescript"]      = s.property,
		["@variable.destructured.value.typescript"]    = s.variable,
		["@property.destructured.key.nested.typescript"] = s.property,
		["@variable.destructured.array.typescript"]    = s.variable,
		["@variable.destructured.rest.typescript"]     = s.variable,
		["@variable.destructured.rest.array.typescript"] = s.variable,
		["@variable.destructured.default.typescript"]  = s.variable,
		["@variable.destructured.array.default.typescript"] = s.variable,

		-- ── 8. Template Literals ─────────────────────────────────────
		["@punctuation.special.interpolation.open.typescript"]  = { fg = c.orange_70 },
		["@punctuation.special.interpolation.close.typescript"] = { fg = c.orange_70 },
		["@variable.interpolation.typescript"]        = s.variable,
		["@variable.interpolation.object.typescript"] = s.variable,
		["@property.interpolation.typescript"]        = s.property,
		["@function.interpolation.typescript"]        = s.func,
		["@function.tagged_template.typescript"]      = s.func,

		-- ── 9. Member Expressions (known APIs) ───────────────────────
		["@variable.builtin.console.typescript"]      = s.variable_builtin,
		["@function.method.console.typescript"]       = s.func_builtin,
		["@function.method.console.log.typescript"]   = { fg = c.slate_grey_80, italic = true },
		["@function.method.console.warn.typescript"]  = { fg = c.warn_yellow, italic = true },
		["@function.method.console.error.typescript"] = { fg = c.error_red, italic = true },
		["@function.method.promise.typescript"]       = s.method,
		["@variable.builtin.promise.typescript"]      = s.type,
		["@function.method.promise.static.typescript"] = s.func_builtin,
		["@function.method.array.iterate.typescript"] = s.method,
		["@function.method.array.mutate.typescript"]  = s.method,
		["@function.method.array.access.typescript"]  = s.method,
		["@variable.builtin.array.typescript"]        = s.variable_builtin,
		["@variable.builtin.object.typescript"]       = s.variable_builtin,
		["@variable.builtin.json.typescript"]         = s.variable_builtin,
		["@variable.builtin.math.typescript"]         = s.variable_builtin,
		["@variable.builtin.reflect.typescript"]      = s.variable_builtin,
		["@variable.builtin.symbol.typescript"]       = s.variable_builtin,
		["@function.method.array.static.typescript"]  = s.func_builtin,
		["@function.method.object.static.typescript"] = s.func_builtin,
		["@function.method.json.typescript"]          = s.func_builtin,
		["@function.method.math.typescript"]          = s.func_builtin,
		["@function.method.string.typescript"]        = s.func_builtin,
		["@function.builtin.global.typescript"]       = s.func_builtin,
		["@variable.builtin.global_object.typescript"] = s.variable_builtin,

		-- ── 10. Imports / Exports ────────────────────────────────────
		["@keyword.import.typescript"]                = s.keyword_declaration,
		["@keyword.import.type.typescript"]           = s.keyword_declaration,
		["@keyword.import.type.specifier.typescript"] = s.keyword_declaration,
		["@string.import.source.typescript"]          = s.string,
		["@variable.import.typescript"]               = s.variable,
		["@variable.import.original.typescript"]      = s.variable,
		["@variable.import.alias.typescript"]         = { fg = c.w_grey_50, italic = true },
		["@variable.import.default.typescript"]       = s.variable,
		["@keyword.import.wildcard.typescript"]       = s.keyword_declaration,
		["@module.import.namespace.typescript"]       = s.module,
		["@keyword.import.dynamic.typescript"]        = s.keyword_declaration,
		["@variable.import.require.typescript"]       = s.variable,
		["@function.builtin.require.typescript"]      = s.func_builtin,
		["@keyword.import.alias.typescript"]          = s.keyword_declaration,
		["@variable.import.alias.name.typescript"]    = { fg = c.w_grey_50, italic = true },
		["@keyword.import.attribute.typescript"]      = s.keyword_declaration,
		["@keyword.export.typescript"]                = s.keyword_declaration,
		["@keyword.export.default.typescript"]        = s.keyword_declaration,
		["@keyword.export.type.typescript"]           = s.keyword_declaration,
		["@variable.export.typescript"]               = s.variable,
		["@variable.export.alias.typescript"]         = { fg = c.w_grey_50, italic = true },
		["@string.export.source.typescript"]          = s.string,
		["@keyword.export.as.typescript"]             = s.keyword_declaration,
		["@keyword.export.namespace.typescript"]      = s.keyword_declaration,

		-- ── 11. Ambient / Declare ────────────────────────────────────
		["@keyword.declaration.declare.typescript"]   = s.keyword_declaration,
		["@keyword.declaration.global.typescript"]    = s.keyword_declaration,
		["@keyword.declaration.module.typescript"]    = s.keyword_declaration,

		-- ── 12. Operators ────────────────────────────────────────────
		["@operator.non_null.typescript"]             = s.operator,
		["@operator.optional_chain.typescript"]       = s.operator,
		["@operator.nullish_coalescing.typescript"]   = s.operator,
		["@operator.nullish_assignment.typescript"]   = s.operator,
		["@operator.logical_or_assignment.typescript"] = s.operator,
		["@operator.logical_and_assignment.typescript"] = s.operator,
		["@keyword.operator.typeof.typescript"]       = s.keyword_operator,
		["@keyword.operator.void.typescript"]         = s.keyword_operator,
		["@keyword.operator.delete.typescript"]       = s.keyword_operator,
		["@keyword.operator.in.typescript"]           = s.keyword_operator,
		["@keyword.operator.instanceof.typescript"]   = s.keyword_operator,
		["@keyword.operator.new.typescript"]          = s.keyword,
		["@type.constructor.typescript"]              = s.constructor,
		["@type.constructor.module.typescript"]       = s.module,
		["@type.constructor.name.typescript"]         = s.constructor,
		["@operator.ternary.question.typescript"]     = s.operator,
		["@operator.ternary.colon.typescript"]        = s.operator,
		["@operator.comma.typescript"]                = s.punctuation_delimiter,
		["@expression.instantiation.typescript"]      = s.type,

		-- ── 13. Control Flow ─────────────────────────────────────────
		["@keyword.coroutine.await.typescript"]       = s.keyword,
		["@keyword.coroutine.yield.typescript"]       = s.keyword,
		["@keyword.exception.throw.typescript"]       = s.keyword,
		["@keyword.exception.try.typescript"]         = s.keyword,
		["@keyword.exception.catch.typescript"]       = s.keyword,
		["@keyword.exception.finally.typescript"]     = s.keyword,
		["@variable.exception.typescript"]            = { fg = c.orange_80, italic = true },
		["@variable.exception.typed.typescript"]      = { fg = c.orange_80, italic = true },
		["@keyword.loop.for.typescript"]              = s.keyword,
		["@keyword.loop.in.typescript"]               = s.keyword,
		["@keyword.loop.of.typescript"]               = s.keyword,
		["@keyword.loop.await.typescript"]            = s.keyword,
		["@expression.switch.discriminant.typescript"] = s.variable,
		["@keyword.switch.case.typescript"]           = s.keyword,
		["@variable.switch.case.typescript"]          = s.variable,
		["@keyword.switch.default.typescript"]        = s.keyword,
		["@label.target.typescript"]                  = s.label,
		["@keyword.control.break.typescript"]         = s.keyword,
		["@keyword.control.continue.typescript"]      = s.keyword,
		["@keyword.control.return.typescript"]        = s.keyword,

		-- ── 14. Numeric Literals ─────────────────────────────────────
		["@number.hex.typescript"]                    = s.number,
		["@number.binary.typescript"]                 = s.number,
		["@number.octal.typescript"]                  = s.number,
		["@number.bigint.typescript"]                 = { fg = c.orange_80, italic = true },

		-- ── 15. Strings ──────────────────────────────────────────────
		["@string.escape.typescript"]                 = s.string_escape,
		["@string.regex.typescript"]                  = s.string_regex,
		["@string.regex.pattern.typescript"]          = s.string_regex,
		["@string.regex.flags.typescript"]            = { fg = c.grass_green_60 },

		-- ── 16. Special Identifiers ──────────────────────────────────
		["@constant.convention.typescript"]           = s.constant,
		["@type.convention.pascal.typescript"]        = s.type,
		["@boolean.true.typescript"]                  = s.boolean,
		["@boolean.false.typescript"]                 = s.boolean,
		["@constant.builtin.null.typescript"]         = s.constant_builtin,
		["@constant.builtin.undefined.typescript"]    = s.constant_builtin,
		["@constant.builtin.numeric.typescript"]      = s.constant_builtin,
		["@variable.builtin.this.typescript"]         = s.variable_builtin,
		["@variable.builtin.super.typescript"]        = s.variable_builtin,
		["@variable.builtin.arguments.typescript"]    = s.variable_builtin,
		["@module.name.typescript"]                   = s.module,
		["@module.name.string.typescript"]            = s.module,
		["@module.namespace.typescript"]              = s.module,

		-- ╔══════════════════════════════════════════════════════════════╗
		-- ║                     TSX LINKS                               ║
		-- ║  JSX/TSX-specific captures                                  ║
		-- ╚══════════════════════════════════════════════════════════════╝
		["@tag.tsx"]                                  = s.tag,
		["@tag.builtin.tsx"]                          = s.tag_builtin,
		["@tag.attribute.tsx"]                        = s.tag_attribute,
		["@tag.delimiter.tsx"]                        = s.tag_delimiter,
		["@string.special.tsx"]                       = s.string_special,
	}

	for group, spec in pairs(map) do
		hl(0, group, spec)
	end

	-- ╔══════════════════════════════════════════════════════════════╗
	-- ║             VIM SYNTAX FALLBACK                             ║
	-- ╚══════════════════════════════════════════════════════════════╝
	local syntax_map = {
		["typescriptAliasKeyword"]           = s.keyword,
		["typescriptCastKeyword"]            = s.keyword,
		["typescriptDefault"]                = s.keyword,
		["typescriptExceptions"]             = s.keyword,
		["typescriptExport"]                 = s.keyword,
		["typescriptExportType"]             = s.keyword,
		["typescriptImport"]                 = s.keyword,
		["typescriptImportType"]             = s.keyword,
		["typescriptReadonlyArrayKeyword"]   = s.keyword,
		["typescriptReadonlyModifier"]       = s.keyword,
		["typescriptStatementKeyword"]       = s.keyword,
		["typescriptTry"]                    = s.keyword,
		["typescriptUsing"]                  = s.keyword,
		["typescriptObjectLabel"]            = s.property,
		["typescriptDecorator"]              = s.decorator,
		["typescriptKeywordOp"]              = s.operator,
		["typescriptOperator"]               = s.operator,
		["typescriptBraces"]                 = s.punctuation,
		["typescriptParens"]                 = s.punctuation,
		["typescriptEndColons"]              = s.punctuation_delimiter,
		["typescriptVariable"]               = s.keyword,
		["typescriptType"]                   = s.type,
		["typescriptTypeReference"]          = s.type,
		["typescriptUserDefinedType"]        = s.type,
		["typescriptIdentifierName"]         = s.module,
		["typescriptTypeBlock"]              = s.module,
		["typescriptTemplateLiteralType"]    = s.module,
		["typescriptTypeQuery"]              = s.module,
		["typescriptUnion"]                  = s.module,
		["typescriptTypeParameter"]          = s.module,
		["typescriptTupleLable"]             = { fg = c.cream_80, italic = true },
		["typescriptTemplate"]               = s.string,
		["typescriptTemplateSB"]             = s.string_special,
		["typescriptStringProperty"]         = s.property,
		["typescriptSymbolStaticProp"]       = s.property,
		["typescriptURLUtilsProp"]           = s.property,
		["typescriptStringStaticMethod"]     = s.func_builtin,
		["typescriptSubtleCryptoMethod"]     = s.func_builtin,
		["typescriptSymbolStaticMethod"]     = s.func_builtin,
		["typescriptURLStaticMethod"]        = s.func_builtin,
		["typescriptSymbols"]                = s.variable_builtin,
	}

	for group, spec in pairs(syntax_map) do
		hl(0, group, spec)
	end

	-- ╔══════════════════════════════════════════════════════════════╗
	-- ║    TSX LINKS — Standard captures → TypeScript equivalents   ║
	-- ║    Kept explicit: full coverage visible at a glance.        ║
	-- ╚══════════════════════════════════════════════════════════════╝
	for _, group in ipairs({
		"@comment.documentation",
		"@comment",
		"@comment.error",
		"@comment.note",
		"@comment.todo",
		"@comment.warning",
		"@keyword",
		"@keyword.function",
		"@keyword.import",
		"@keyword.export",
		"@keyword.return",
		"@keyword.operator",
		"@keyword.conditional",
		"@keyword.conditional.ternary",
		"@keyword.repeat",
		"@keyword.exception",
		"@keyword.type",
		"@keyword.modifier",
		"@keyword.storage",
		"@type",
		"@type.builtin",
		"@type.definition",
		"@type.qualifier",
		"@module",
		"@module.builtin",
		"@namespace",
		"@variable",
		"@variable.parameter",
		"@variable.parameter.builtin",
		"@variable.member",
		"@variable.builtin",
		"@property",
		"@label",
		"@function",
		"@function.call",
		"@function.method",
		"@function.method.call",
		"@function.builtin",
		"@function.macro",
		"@attribute",
		"@attribute.builtin",
		"@constructor",
		"@string",
		"@string.documentation",
		"@string.escape",
		"@string.template",
		"@string.special",
		"@string.regexp",
		"@character",
		"@character.special",
		"@number",
		"@number.float",
		"@boolean",
		"@constant",
		"@constant.enum",
		"@constant.builtin",
		"@constant.macro",
		"@operator",
		"@punctuation.special",
		"@punctuation.colon",
		"@punctuation.delimiter",
		"@punctuation.bracket",
		"@punctuation.comma",
		"@punctuation.dot",
		"@punctuation.semicolon",
	}) do
		hl(0, group .. ".tsx", { link = group .. ".typescript" })
	end
end

return M
