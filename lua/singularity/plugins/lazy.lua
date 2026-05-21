-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Lazy Plugin Manager Highlights             ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c = require("singularity.colors")
	local s = require("singularity.color_semantic")
	local hl = vim.api.nvim_set_hl

	hl(0, "LazyProgressTodo", { fg = c.grey_dark })
	hl(0, "LazyProgressDone", { fg = c.orange })
	hl(0, "LazyCommit", s.diag_success)
	hl(0, "LazyCommitType", s.diag_info)
	hl(0, "LazyReasonPlugin", s.diag_error)
	hl(0, "LazyReasonRuntime", s.diag_warning)
	hl(0, "LazyReasonCmd", { fg = c.orange })
	hl(0, "LazyReasonEvent", s.diag_success)
	hl(0, "LazyReasonFt", s.diag_info)
	hl(0, "LazyReasonKeys", { fg = c.slate_grey })
	hl(0, "LazyReasonImport", s.diag_warning)
	hl(0, "LazyReasonSource", { fg = c.grey_soft })
	hl(0, "LazyReasonStart", { fg = c.fg })
end

return M
