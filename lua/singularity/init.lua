-- Singularity — Main Loader
--
-- Module load order:
--   1. editor     — base UI (must come first)
--   2. syntax     — Vim legacy fallback groups
--   3. treesitter — generic @captures (base for all languages)
--   4. lsp        — generic LSP token fallbacks
--   5. languages  — language-specific overrides (highest priority)
--   6. terminal   — ANSI colors (independent)
--   7. plugins    — plugin-specific highlights (last, can override anything)

local M = {}

-- Language modules gated by integrations table
local LANGUAGE_MODULES = {
	{ key = "treesitter", mod = "singularity.languages.treesitter" },
	{ key = "lsp",        mod = "singularity.languages.lsp"        },
	{ key = "python",     mod = "singularity.languages.python"      },
	{ key = "typescript", mod = "singularity.languages.typescript"  },
	{ key = "rust",       mod = "singularity.languages.rust"        },
}

-- Always-loaded modules (no integration gate)
local CORE_MODULES = {
	"singularity.editor",
	"singularity.syntax",
	"singularity.terminal",
	"singularity.plugins",
}

local function clear_module_cache()
	for key in pairs(package.loaded) do
		if key:match("^singularity%.") and key ~= "singularity.config" then
			package.loaded[key] = nil
		end
	end
end

function M.setup(opts)
	opts = opts or {}
	local cfg = require("singularity.config")

	if opts.italic ~= nil then cfg.italic = opts.italic end
	if opts.bold   ~= nil then cfg.bold   = opts.bold   end

	if opts.overrides then
		cfg.overrides = vim.tbl_deep_extend("force", cfg.overrides, opts.overrides)
	end

	if opts.integrations then
		cfg.integrations = vim.tbl_deep_extend("force", cfg.integrations, opts.integrations)
	end
end

function M.load()
	local cfg = require("singularity.config")

	-- Force modules to re-evaluate so italic/bold toggles take effect.
	clear_module_cache()

	local ok_c, err_c = pcall(require, "singularity.colors")
	if not ok_c then
		vim.notify("singularity: failed to load colors: " .. err_c, vim.log.levels.ERROR)
		return false
	end

	local ok_s, err_s = pcall(require, "singularity.color_semantic")
	if not ok_s then
		vim.notify("singularity: failed to load color_semantic: " .. err_s, vim.log.levels.ERROR)
		return false
	end

	vim.cmd("highlight clear")
	if vim.g.syntax_on then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "singularity"

	-- Core modules
	for _, mod_name in ipairs(CORE_MODULES) do
		local ok, mod = pcall(require, mod_name)
		if ok and mod.setup then
			mod.setup()
		else
			vim.notify("singularity: failed to load " .. mod_name, vim.log.levels.WARN)
		end
	end

	-- Language modules (gated by integrations)
	for _, entry in ipairs(LANGUAGE_MODULES) do
		if cfg.integrations[entry.key] ~= false then
			local ok, mod = pcall(require, entry.mod)
			if ok and mod.setup then
				mod.setup()
			else
				vim.notify("singularity: failed to load " .. entry.mod, vim.log.levels.WARN)
			end
		end
	end

	-- Apply user overrides on top of everything
	if next(cfg.overrides) ~= nil then
		local s = require("singularity.color_semantic")
		for role, spec in pairs(cfg.overrides) do
			if s[role] then
				vim.api.nvim_set_hl(0, role, vim.tbl_extend("force", s[role], spec))
			else
				vim.notify("singularity: unknown role in overrides: " .. role, vim.log.levels.WARN)
			end
		end
	end

	return true
end

return M
