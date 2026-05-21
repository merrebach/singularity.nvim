-- Singularity — Style Rules
--
-- Named transforms applied to highlight specs. Each function documents an
-- INTENT at the call site in color_semantic.lua.
--
-- italic carries three intents (foreign / declaration / organizational).
-- They share a struct today but the names are kept distinct so future
-- divergence is cheap and the meaning at the call site stays explicit.
-- See ADR-0001-style-axes.md.
--
-- Composition: deprecated() and readonly() take a full spec and add their
-- modifier. They compose with the italic rules.

local r = {}

--- italic — identifier comes from outside the user's code (stdlib, builtin).
function r.foreign(c)
	local cfg = require("singularity.config")
	return { fg = c, italic = cfg.italic, bold = false }
end

--- italic — keyword that introduces a binding or declares storage
--- (`def`, `class`, `import`, `let`, `const`, `type`, `interface`).
function r.declaration(c)
	local cfg = require("singularity.config")
	return { fg = c, italic = cfg.italic, bold = false }
end

--- italic — organizational/metadata token (module, parameter, comment,
--- doc string, markup quote).
function r.organizational(c)
	local cfg = require("singularity.config")
	return { fg = c, italic = cfg.italic, bold = false }
end

--- bold — definition / introduction site. Reserved for `type_definition`
--- and `constructor`. Do NOT add other call sites without an ADR update.
function r.definition(spec)
	local cfg = require("singularity.config")
	return vim.tbl_extend("force", spec, { bold = cfg.bold })
end

--- strikethrough — deprecated, any role.
function r.deprecated(spec)
	return vim.tbl_extend("force", spec, { strikethrough = true })
end

--- underline — readonly identifier, URL, or link.
function r.readonly(spec)
	return vim.tbl_extend("force", spec, { underline = true })
end

return r
