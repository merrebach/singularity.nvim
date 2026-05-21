-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Python Highlights                          ║
-- ║                                                            ║
-- ║  Only captures that differ from the base or are custom      ║
-- ║  (after/queries/python/highlights.scm). Standard captures   ║
-- ║  inherit from languages/treesitter.lua.                     ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	local map = {
		-- ── Standard overrides (differ from treesitter base) ─────────
		-- @keyword.directive base = { fg = c.w_grey_70 }; Python uses plain keyword orange
		["@keyword.directive.python"]       = s.keyword,
		-- @attribute.builtin has no base mapping
		["@attribute.builtin.python"]       = s.decorator_builtin,

		-- ╔══════════════════════════════════════════════════════════════╗
		-- ║            CUSTOM TREESITTER CAPTURES                       ║
		-- ║  Mapped from after/queries/python/highlights.scm            ║
		-- ╚══════════════════════════════════════════════════════════════╝

		-- ── 1. self / cls ────────────────────────────────────────────
		["@variable.builtin.self.python"]   = s.variable_builtin,
		["@variable.builtin.cls.python"]    = s.variable_builtin,
		["@property.instance.python"]       = s.property,
		["@property.class_attr.python"]     = vim.tbl_extend("force", s.property, { italic = true }),
		["@function.method.self.python"]    = s.method,
		["@function.method.cls.python"]     = vim.tbl_extend("force", s.method, { italic = true }),

		-- ── 2. Decorators ────────────────────────────────────────────
		["@punctuation.special.decorator.python"]           = { fg = c.cream, bold = false },
		["@attribute.decorator.python"]                     = s.decorator,
		["@attribute.decorator.call.python"]                = s.decorator,
		["@attribute.decorator.method.python"]              = s.decorator,
		["@attribute.decorator.method.call.python"]         = s.decorator,
		["@attribute.decorator.method.deep.python"]         = s.decorator,
		["@attribute.decorator.module.python"]              = vim.tbl_extend("force", s.module, { italic = false }),
		["@attribute.decorator.module.call.python"]         = vim.tbl_extend("force", s.module, { italic = false }),
		["@attribute.decorator.module.deep.python"]         = vim.tbl_extend("force", s.module, { italic = false }),
		["@attribute.decorator.submodule.python"]           = vim.tbl_extend("force", s.module, { italic = false }),
		["@attribute.decorator.builtin.python"]             = s.decorator_builtin,
		["@attribute.decorator.caching.python"]             = s.decorator_builtin,
		["@attribute.decorator.caching.call.python"]        = s.decorator_builtin,
		["@attribute.decorator.dataclass.python"]           = s.decorator_builtin,
		["@attribute.decorator.dataclass.call.python"]      = s.decorator_builtin,
		["@attribute.decorator.functools.python"]           = s.decorator_builtin,

		-- ── 3. Type Hints ────────────────────────────────────────────
		["@type.annotation.parameter.python"]               = s.type,
		["@type.annotation.parameter.default.python"]       = s.type,
		["@type.annotation.return.python"]                  = s.type,
		["@type.annotation.variable.python"]                = s.type,
		["@type.annotation.python"]                         = s.type,
		["@type.generic.python"]                            = s.type,
		["@type.generic.tuple.python"]                      = s.type,
		["@type.generic.callable.python"]                   = s.type,
		["@type.argument.generic.python"]                   = s.type,
		["@type.argument.python"]                           = { fg = c.cream_80 },
		["@type.builtin.python.python"]                     = s.type_builtin,
		["@type.typing.python"]                             = s.type_builtin,
		["@type.none.python"]                               = s.constant_builtin,
		["@type.union.operator.python"]                     = s.operator,
		["@type.unpack.python"]                             = s.operator,
		["@keyword.declaration.type.python"]                = s.keyword_declaration,
		["@type.alias.name.python"]                         = s.type_definition,
		["@type.typevar.python"]                            = { fg = c.slate_grey_70, italic = true },

		-- ── 4. Dunder Methods ────────────────────────────────────────
		["@function.dunder.python"]                         = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.lifecycle.python"]               = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.representation.python"]          = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.comparison.python"]              = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.arithmetic.python"]              = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.bitwise.python"]                 = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.container.python"]               = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.callable.python"]                = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.context.python"]                 = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.async.python"]                   = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.descriptor.python"]              = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.conversion.python"]              = vim.tbl_extend("force", s.method, { italic = true }),
		["@function.dunder.copy.python"]                    = vim.tbl_extend("force", s.method, { italic = true }),

		-- ── 5. F-Strings ─────────────────────────────────────────────
		["@string.fstring.start.python"]                    = s.string_fstring,
		["@punctuation.special.interpolation.open.python"]  = { fg = c.orange_70 },
		["@punctuation.special.interpolation.close.python"] = { fg = c.orange_70 },
		["@variable.interpolation.python"]                  = s.variable,
		["@variable.interpolation.object.python"]           = s.variable,
		["@property.interpolation.python"]                  = s.property,
		["@function.interpolation.python"]                  = s.func,
		["@function.method.interpolation.python"]           = s.method,
		["@variable.interpolation.subscript.python"]        = s.variable,
		["@string.fstring.format_spec.python"]              = { fg = c.grass_green_60 },
		["@punctuation.special.conversion.python"]          = { fg = c.orange_70 },

		-- ── 6. String Types ──────────────────────────────────────────
		["@string.raw.start.python"]                        = s.string_raw,
		["@string.bytes.start.python"]                      = s.string_bytes,
		["@string.raw_bytes.start.python"]                  = s.string_bytes,
		["@string.escape.python"]                           = s.string_escape,
		["@string.docstring.python"]                        = s.string_doc,
		["@string.docstring.module.python"]                 = vim.tbl_extend("force", s.string_doc, { bold = false }),

		-- ── 7. Comprehensions ────────────────────────────────────────
		["@expression.comprehension.body.python"]           = s.variable,
		["@expression.comprehension.dict.key.python"]       = s.property,
		["@expression.comprehension.dict.value.python"]     = s.variable,
		["@keyword.comprehension.for.python"]               = s.keyword,
		["@keyword.comprehension.in.python"]                = s.keyword,
		-- for.nested / in.nested omitted: grammar note in query says for_in_clause cannot be nested
		["@keyword.comprehension.filter.python"]            = s.keyword,
		["@variable.comprehension.target.python"]           = s.variable,
		["@variable.comprehension.target.unpack.python"]    = s.variable,

		-- ── 8. Classes ───────────────────────────────────────────────
		["@type.class.name.python"]                         = s.type_definition,
		["@type.class.parent.python"]                       = s.type,
		["@type.class.parent.builtin.python"]               = s.type_builtin,
		["@type.class.parent.generic.python"]               = s.type_builtin,
		["@keyword.class.metaclass.python"]                 = s.keyword,
		["@type.class.metaclass.python"]                    = s.type,
		["@property.class_variable.python"]                 = vim.tbl_extend("force", s.property, { italic = true }),
		["@property.class_variable.typed.python"]           = vim.tbl_extend("force", s.property, { italic = true }),
		["@variable.special.slots.python"]                  = { fg = c.orange_80, italic = true },
		["@variable.special.all.python"]                    = { fg = c.orange_80, italic = true },
		["@variable.special.version.python"]                = { fg = c.orange_80, italic = true },
		["@type.class.test.python"]                         = vim.tbl_extend("force", s.type, { underline = true }),

		-- ── 9. Functions and Parameters ──────────────────────────────
		["@function.definition.python"]                     = s.func_declaration,
		["@function.definition.async.python"]               = s.func_async,
		["@punctuation.parameter.positional_only.python"]   = s.punctuation_special,
		["@punctuation.parameter.keyword_only.python"]      = s.punctuation_special,
		["@variable.parameter.default.python"]              = s.parameter,
		["@variable.parameter.typed_default.python"]        = s.parameter,
		["@variable.parameter.typed.python"]                = s.parameter,
		["@variable.parameter.args.python"]                 = vim.tbl_extend("force", s.parameter, { bold = false }),
		["@variable.parameter.kwargs.python"]               = vim.tbl_extend("force", s.parameter, { bold = false }),
		["@keyword.lambda.python"]                          = s.keyword,
		["@variable.parameter.lambda.python"]               = s.parameter,
		["@variable.parameter.lambda.default.python"]       = s.parameter,

		-- ── 10. Built-in Function Calls ──────────────────────────────
		["@function.builtin.python.python"]                 = s.func_builtin,
		["@function.builtin.super.python"]                  = vim.tbl_extend("force", s.func_builtin, { bold = false }),
		["@function.builtin.constructor.python"]            = s.func_builtin,
		["@function.method.assert.python"]                  = { fg = c.orange_80, bold = false },
		["@type.constructor.call.python"]                   = s.constructor,
		["@function.method.logging.debug.python"]           = { fg = c.grey_dark, italic = true },
		["@function.method.logging.info.python"]            = { fg = c.slate_grey_80, italic = true },
		["@function.method.logging.warning.python"]         = { fg = c.warn_yellow, italic = true },
		["@function.method.logging.error.python"]           = { fg = c.error_red, italic = true },

		-- ── 11. Exceptions ───────────────────────────────────────────
		["@keyword.exception.raise.python"]                 = s.keyword,
		["@keyword.exception.reraise.python"]               = s.keyword,
		-- from.python omitted: query note says `from` is not an exposed anonymous node in raise_statement
		["@keyword.exception.try.python"]                   = s.keyword,
		["@keyword.exception.except.python"]                = s.keyword,
		["@keyword.exception.except_group.python"]          = s.keyword,
		["@keyword.exception.finally.python"]               = s.keyword,
		["@keyword.exception.else.python"]                  = s.keyword,
		["@type.exception.python"]                          = s.type,
		["@type.exception.caught.python"]                   = s.type,
		["@type.exception.caught.tuple.python"]             = s.type,
		["@variable.exception.python"]                      = { fg = c.orange_80, italic = true },
		["@variable.exception.cause.python"]                = { fg = c.orange_80, italic = true },

		-- ── 12. Control Flow and Async ───────────────────────────────
		["@keyword.coroutine.async.python"]                 = s.keyword,
		["@keyword.coroutine.async.for.python"]             = s.keyword,
		["@keyword.coroutine.async.with.python"]            = s.keyword,
		["@keyword.coroutine.await.python"]                 = s.keyword,
		["@keyword.coroutine.yield.python"]                 = s.keyword,
		["@variable.context_manager.python"]                = { fg = c.w_grey_50, italic = true },
		["@keyword.loop.else.python"]                       = s.keyword,
		["@keyword.conditional.ternary.if.python"]          = s.keyword,
		["@keyword.conditional.ternary.else.python"]        = s.keyword,
		["@variable.walrus.python"]                         = s.variable,
		["@operator.walrus.python"]                         = s.operator,
		["@keyword.assert.python"]                          = s.keyword,
		["@keyword.pass.python"]                            = s.keyword,
		["@keyword.control.break.python"]                   = s.keyword,
		["@keyword.control.continue.python"]                = s.keyword,
		["@keyword.control.return.python"]                  = s.keyword,
		["@keyword.del.python"]                             = s.keyword,
		["@string.assert_message.python"]                   = s.string,
		["@keyword.scope.global.python"]                    = s.keyword,
		["@keyword.scope.nonlocal.python"]                  = s.keyword,
		["@variable.scope.global.python"]                   = vim.tbl_extend("force", s.variable, { underline = true }),
		["@variable.scope.nonlocal.python"]                 = vim.tbl_extend("force", s.variable, { underline = true }),

		-- ── 13. Pattern Matching (3.10+) ─────────────────────────────
		["@keyword.match.python"]                           = s.keyword,
		["@keyword.case.python"]                            = s.keyword,
		["@keyword.pattern.guard.python"]                   = s.keyword,
		["@variable.match.subject.python"]                  = s.variable,
		["@variable.pattern.capture.python"]                = s.variable,
		["@variable.pattern.wildcard.python"]               = { fg = c.grey, italic = true },
		["@variable.pattern.star.python"]                   = s.variable,
		["@variable.pattern.keyword.python"]                = s.parameter,
		["@variable.pattern.member.python"]                 = s.property,
		["@type.pattern.class.python"]                      = s.type,
		["@type.pattern.enum.python"]                       = s.type,

		-- ── 14. Imports ──────────────────────────────────────────────
		["@keyword.import.python"]                          = s.keyword_declaration,
		["@keyword.import.from.python"]                     = s.keyword_declaration,
		["@keyword.import.wildcard.python"]                 = s.keyword_declaration,
		["@module.import.python"]                           = s.module,
		["@module.import.source.python"]                    = s.module,
		["@module.import.relative.python"]                  = s.module,
		["@module.import.future.python"]                    = s.module,
		["@module.import.typing.python"]                    = s.module,
		["@punctuation.import.relative.python"]             = s.punctuation_special,
		["@variable.import.python"]                         = s.variable,
		["@variable.import.original.python"]                = s.variable,
		["@variable.import.alias.python"]                   = { fg = c.w_grey_50, italic = true },

		-- ── 15. Assignments and Unpacking ────────────────────────────
		["@operator.assignment.add.python"]                 = s.operator,
		["@operator.assignment.sub.python"]                 = s.operator,
		["@operator.assignment.mul.python"]                 = s.operator,
		["@operator.assignment.div.python"]                 = s.operator,
		["@operator.assignment.floordiv.python"]            = s.operator,
		["@operator.assignment.mod.python"]                 = s.operator,
		["@operator.assignment.pow.python"]                 = s.operator,
		["@operator.assignment.or.python"]                  = s.operator,
		["@operator.assignment.and.python"]                 = s.operator,
		["@operator.assignment.xor.python"]                 = s.operator,
		["@operator.assignment.rshift.python"]              = s.operator,
		["@operator.assignment.lshift.python"]              = s.operator,
		["@variable.unpack.python"]                         = s.variable,
		["@variable.unpack.star.python"]                    = s.variable,
		["@variable.assignment.python"]                     = s.variable,

		-- ── 16. Special Identifiers and Constants ────────────────────
		["@constant.convention.python"]                     = s.constant,
		["@variable.private.python"]                        = { fg = c.w_grey_50, italic = true },
		["@variable.mangled.python"]                        = { fg = c.w_grey_50, italic = true },
		["@variable.dunder.python"]                         = { fg = c.orange_80, italic = true },
		["@variable.dunder.module.python"]                  = { fg = c.orange_80, italic = true },
		["@constant.builtin.ellipsis.python"]               = s.constant_builtin,
		["@boolean.true.python"]                            = s.boolean,
		["@boolean.false.python"]                           = s.boolean,
		["@constant.builtin.none.python"]                   = s.constant_builtin,
		["@number.integer.python"]                          = s.number,
		["@number.hex.python"]                              = s.number,
		["@number.binary.python"]                           = s.number,
		["@number.octal.python"]                            = s.number,
		["@number.complex.python"]                          = { fg = c.orange_80, italic = true },
		["@operator.unpack.args.python"]                    = s.operator,
		["@operator.unpack.kwargs.python"]                  = s.operator,
		["@variable.keyword_argument.python"]               = vim.tbl_extend("force", s.parameter, { italic = false }),
		["@punctuation.slice.python"]                       = s.punctuation,

		-- ── Comments ─────────────────────────────────────────────────
		["@comment.type.python"]                            = { fg = c.grey, italic = true },
		["@comment.todo.python"]                            = s.comment_todo,
		["@comment.fixme.python"]                           = { fg = c.bg, bg = c.error_red },
		["@comment.hack.python"]                            = { fg = c.bg, bg = c.warn_yellow },
		["@comment.note.python"]                            = s.comment_note,

		-- ── Test Functions/Classes ────────────────────────────────────
		["@function.test.python"]                           = vim.tbl_extend("force", s.func, { underline = true }),
		["@function.setup.python"]                          = vim.tbl_extend("force", s.func, { italic = true }),

		-- ── Comparison Operators ─────────────────────────────────────
		["@keyword.operator.is.python"]                     = s.keyword_operator,
		["@keyword.operator.is_not.python"]                 = s.keyword_operator,
		["@keyword.operator.in.python"]                     = s.keyword_operator,
		["@keyword.operator.not_in.python"]                 = s.keyword_operator,
	}

	for group, spec in pairs(map) do
		hl(0, group, spec)
	end
end

return M
