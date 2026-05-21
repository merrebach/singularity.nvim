-- Singularity runtime configuration. Updated by setup(); read by style_rules at call time.
local M = {
	italic       = true,
	bold         = true,
	background   = true,   -- apply palette background to Normal; false = leave bg unset
	transparent  = false,  -- force bg = "NONE" on Normal and related groups (terminal transparency)
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
