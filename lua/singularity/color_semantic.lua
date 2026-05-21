-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Semantic Color Mapping                        ║
-- ║                                                              ║
-- ║  Maps raw palette colors to FUNCTIONAL meanings, composed    ║
-- ║  through named transforms in `style_rules.lua`. Every italic /║
-- ║  bold here is justified by an axis documented in ADR 0002.   ║
-- ║                                                              ║
-- ║  Language files (treesitter / lsp / python / typescript /     ║
-- ║  rust) reference these semantic names — never the raw         ║
-- ║  palette unless a one-off tint is unavoidable.               ║
-- ╚══════════════════════════════════════════════════════════════╝

local c = require("singularity.colors")
local r = require("singularity.style_rules")

local s = {}

-- ── Keywords ──────────────────────────────────────────────────
-- Control flow (`if`, `for`, `return`, `try`…) stays plain orange.
-- Declaration / storage (`def`, `class`, `import`, `let`, `const`,
-- `type`, `interface`…) carries italic via r.declaration().
-- `keyword_operator` is the muted orange used for `and`/`or`/`is`/`in`.
s.keyword = { fg = c.orange, bold = false }
s.keyword_declaration = r.declaration(c.orange)
s.keyword_operator = { fg = c.orange_70, bold = false }

-- ── Functions & Methods ───────────────────────────────────────
-- All callable identifiers share warm sand. Modifiers are expressed
-- through axes: async/abstract are NOT decorated; only foreign
-- (builtin / default-lib) and deprecated carry a style.
s.func = { fg = c.warm_sand, bold = false }
s.func_declaration = { fg = c.warm_sand, bold = false }
s.func_builtin = r.foreign(c.warm_sand)
s.func_default_lib = r.foreign(c.warm_sand)
s.func_async = { fg = c.warm_sand }
s.func_abstract = { fg = c.warm_sand }
s.func_deprecated = r.deprecated({ fg = c.warm_sand })

s.method = { fg = c.warm_sand }
s.method_declaration = { fg = c.warm_sand }
s.method_static = { fg = c.warm_sand }
s.method_async = { fg = c.warm_sand }
s.method_abstract = { fg = c.warm_sand }
s.method_default_lib = r.foreign(c.warm_sand)
s.method_deprecated = r.deprecated({ fg = c.warm_sand })

-- ── Types & Classes ───────────────────────────────────────────
-- Bare type reference is plain cream; only the definition site
-- (`type_definition`, `constructor`) carries bold. Builtins use
-- italic (foreign). Default-lib types use italic only — no bold.
s.type = { fg = c.cream }
s.type_builtin = r.foreign(c.slate_grey)
s.type_definition = r.definition({ fg = c.cream })
s.type_default_lib = r.foreign(c.cream)
s.type_deprecated = r.deprecated({ fg = c.cream })
s.constructor = r.definition({ fg = c.cream })

-- ── Variables ─────────────────────────────────────────────────
-- Regular variables blend with text; builtins (`self`, `this`)
-- stand out via orange_80 + foreign italic.
s.variable = { fg = c.w_grey_50 }
s.variable_builtin = r.foreign(c.orange_80)
s.variable_readonly = r.readonly({ fg = c.orange_80 })
s.variable_global = r.readonly({ fg = c.w_grey_50 })
s.variable_deprecated = r.deprecated({ fg = c.w_grey_50 })
s.variable_default_lib = r.foreign(c.orange_80)

-- ── Parameters ────────────────────────────────────────────────
-- Italic = organizational (parameter is metadata of the function).
s.parameter = r.organizational(c.slate_grey_60)
s.parameter_readonly = r.readonly(r.organizational(c.slate_grey_60))
s.parameter_deprecated = r.deprecated(r.organizational(c.slate_grey_60))

-- ── Properties / Members ──────────────────────────────────────
-- Slightly muted cream so it distinguishes from type names.
-- Default-lib properties are italic (foreign) — no bold.
s.property = { fg = c.cream_80 }
s.property_readonly = r.readonly({ fg = c.cream_80 })
s.property_deprecated = r.deprecated({ fg = c.cream_80 })
s.property_default_lib = r.foreign(c.cream_80)

-- ── Modules & Namespaces ──────────────────────────────────────
-- Italic = organizational. Warm slate grey.
s.module = r.organizational(c.slate_grey_80)
s.module_builtin = r.organizational(c.slate_grey_80)

-- ── Constants ─────────────────────────────────────────────────
-- Orange family. Builtins (None / null / undefined) get full orange.
s.constant = { fg = c.orange_80 }
s.constant_builtin = { fg = c.orange }
s.constant_macro = { fg = c.orange_70 }
s.enum_member = { fg = c.orange_80 }

-- ── Strings ───────────────────────────────────────────────────
s.string = { fg = c.grass_green }
s.string_escape = { fg = c.orange_80, bold = false }
s.string_special = { fg = c.grass_green_70 }
s.string_regex = { fg = c.grass_green_80 }
s.string_doc = r.organizational(c.grey_dark)
s.string_url = r.readonly({ fg = c.slate_grey_80 })
s.string_fstring = { fg = c.grass_green_90 }
s.string_raw = { fg = c.grass_green_80 }
s.string_bytes = { fg = c.grass_green_70 }

-- ── Characters ────────────────────────────────────────────────
s.character = { fg = c.w_grey_70 }
s.character_special = { fg = c.w_grey_60 }

-- ── Numbers & Booleans ────────────────────────────────────────
-- boolean joins the constant family (orange_80) — was full orange.
s.number = { fg = c.orange_80 }
s.boolean = { fg = c.orange_80, bold = false }

-- ── Operators & Punctuation ───────────────────────────────────
s.operator = { fg = c.orange_70 }
s.punctuation = { fg = c.grey }
s.punctuation_delimiter = { fg = c.grey_dark }
s.punctuation_special = { fg = c.orange_70 }

-- ── Comments ──────────────────────────────────────────────────
-- Italic = organizational. Low contrast so they recede.
s.comment = r.organizational(c.grey_dark)
s.comment_doc = r.organizational(c.grey_dark)
s.comment_error = { fg = c.error_red, bold = false }
s.comment_warning = { fg = c.warn_yellow, bold = false }
s.comment_todo = { fg = c.bg, bg = c.warn_yellow, bold = false }
s.comment_note = r.organizational(c.grey)

-- ── Decorators & Attributes ───────────────────────────────────
s.decorator = { fg = c.cream, bold = false }
s.decorator_builtin = r.foreign(c.cream)
s.attribute = { fg = c.cream, bold = false }

-- ── Labels ────────────────────────────────────────────────────
-- Lifetimes (Rust), goto labels — organizational.
s.label = r.organizational(c.orange_60)

-- ── Tags (HTML, JSX, XML) ─────────────────────────────────────
s.tag = { fg = c.orange }
s.tag_builtin = r.foreign(c.orange_60)
s.tag_attribute = { fg = c.cream }
s.tag_delimiter = { fg = c.grey }

-- ── Diagnostics ───────────────────────────────────────────────
s.diag_error = { fg = c.error_red }
s.diag_warning = { fg = c.warn_yellow }
s.diag_info = { fg = c.info_grey }
s.diag_hint = { fg = c.grey_soft }
s.diag_success = { fg = c.success_green }

-- ── Git ───────────────────────────────────────────────────────
s.git_add = { fg = c.success_green }
s.git_change = { fg = c.warn_yellow }
s.git_delete = { fg = c.error_red }

-- ── Markup ────────────────────────────────────────────────────
s.markup_heading = { fg = c.orange }
s.markup_link = r.readonly({ fg = c.slate_grey_80 })
s.markup_code = { fg = c.success_green }
s.markup_math = { fg = c.slate_grey_70 }
s.markup_quote = r.organizational(c.grey)

-- ── UI Accents ────────────────────────────────────────────────
s.accent = c.orange
s.accent_soft = c.orange_60
s.accent_subtle = c.orange_20

return s
