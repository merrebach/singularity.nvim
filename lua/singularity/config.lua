-- Singularity runtime configuration. Updated by setup(); read by style_rules at call time.
local M = {
	italic = true,
	bold   = true,
	overrides = {},
	integrations = {
		treesitter    = true,
		lsp           = true,
		python        = true,
		typescript    = true,
		rust          = true,
		window_groups = true,
	},
}
return M
