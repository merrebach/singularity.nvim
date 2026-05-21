-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Terminal Colors                            ║
-- ║                                                            ║
-- ║  Sets the 16 ANSI colors for Neovim's built-in terminal.   ║
-- ║  Warm palette aligned with the Singularity.                ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")

	-- Standard 16 ANSI colors (0–15)
	vim.g.terminal_color_0 = c.bg             -- Black
	vim.g.terminal_color_1 = c.error_red      -- Red (Ubuntu orange)
	vim.g.terminal_color_2 = c.grass_green   -- Green
	vim.g.terminal_color_3 = c.warn_yellow    -- Yellow (orange 80)
	vim.g.terminal_color_4 = c.slate_grey     -- Blue (warm slate)
	vim.g.terminal_color_5 = c.cream          -- Magenta (cream)
	vim.g.terminal_color_6 = c.slate_grey_60  -- Cyan (light slate)
	vim.g.terminal_color_7 = c.fg_soft        -- White

	-- Bright variants
	vim.g.terminal_color_8 = c.grey_dark      -- Bright Black
	vim.g.terminal_color_9 = c.orange_80      -- Bright Red
	vim.g.terminal_color_10 = c.success_green -- Bright Green
	vim.g.terminal_color_11 = c.orange_60     -- Bright Yellow
	vim.g.terminal_color_12 = c.slate_grey_80 -- Bright Blue
	vim.g.terminal_color_13 = c.cream_80      -- Bright Magenta
	vim.g.terminal_color_14 = c.slate_grey_50 -- Bright Cyan
	vim.g.terminal_color_15 = c.fg            -- Bright White
end

return M
