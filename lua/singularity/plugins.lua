-- Singularity — Plugin Highlights Loader
-- Loads plugin-specific highlight modules. Each is a self-contained
-- module with a setup() function. Modules are gated by the integrations
-- table in config.lua.

local M = {}

-- Integration key → module path
local INTEGRATIONS = {
	treesitter    = nil,  -- handled by init.lua module list, not here
	lsp           = nil,
	python        = nil,
	typescript    = nil,
	rust          = nil,
	window_groups = "singularity.plugins.groups",
}

-- Plugin UI modules always loaded (no integration gate needed — nvim_set_hl on
-- undefined groups is a no-op, and these are pure UI chrome).
local PLUGIN_MODULES = {
	"singularity.plugins.telescope",
	"singularity.plugins.lazygit",
	"singularity.plugins.neo_tree",
	"singularity.plugins.completion",
	"singularity.plugins.dashboard",
	"singularity.plugins.git",
	"singularity.plugins.navigation",
	"singularity.plugins.notify",
	"singularity.plugins.indent",
	"singularity.plugins.bufferline",
	"singularity.plugins.statusline",
	"singularity.plugins.mason",
	"singularity.plugins.lazy",
	"singularity.plugins.snacks",
	"singularity.plugins.misc",
}

function M.setup()
	local cfg = require("singularity.config")

	-- Load UI plugin modules unconditionally
	for _, mod_name in ipairs(PLUGIN_MODULES) do
		local ok, mod = pcall(require, mod_name)
		if ok and mod.setup then
			mod.setup()
		end
	end

	-- Load integration modules based on config
	for key, mod_name in pairs(INTEGRATIONS) do
		if mod_name and cfg.integrations[key] ~= false then
			local ok, mod = pcall(require, mod_name)
			if ok and mod.setup then
				mod.setup()
			end
		end
	end
end

return M
