-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Editor Highlights                          ║
-- ║                                                            ║
-- ║  Core Neovim UI: Normal, Cursor, Visual, LineNr, Search,   ║
-- ║  Pmenu, StatusLine, Diagnostics, Git signs, Diff, etc.     ║
-- ╚══════════════════════════════════════════════════════════════╝

local M = {}

function M.setup()
	local c   = require("singularity.colors")
	local s   = require("singularity.color_semantic")
	local cfg = require("singularity.config")
	local hl  = vim.api.nvim_set_hl

	-- ╔══════════════════════════════════════════════════════════════╗
	-- ║                     CORE EDITOR                             ║
	-- ╚══════════════════════════════════════════════════════════════╝

	local normal_bg, sidebar_bg
	if cfg.transparent then
		normal_bg  = "NONE"
		sidebar_bg = "NONE"
	elseif cfg.background then
		normal_bg  = c.bg
		sidebar_bg = c.bg_dark
	else
		normal_bg  = "NONE"
		sidebar_bg = "NONE"
	end

	hl(0, "Normal",   { fg = c.fg,   bg = normal_bg })
	hl(0, "NormalNC", { fg = c.grey, bg = normal_bg })
	hl(0, "NormalSB", { fg = c.fg, bg = sidebar_bg })
	-- Global floats: darker bg (rose-pine convention). All UI
	-- floats (file explorer popups, Telescope, Lazy, Mason) use
	-- these.
	hl(0, "NormalFloat", { fg = c.fg, bg = c.bg_dark })
	hl(0, "FloatBorder", { fg = c.orange, bg = c.bg_dark })
	hl(0, "FloatTitle", { fg = c.orange, bg = c.bg_dark, bold = true })
	hl(0, "FloatShadow", { bg = c.bg_dark, blend = 80 })

	-- LSP hover-only: lighter bg so the popup stands out from
	-- the editor surface. Applied via winhighlight in the LSP
	-- `open_floating_preview` wrapper, not globally.
	-- See docs/adr/0003-float-ux.md.
	hl(0, "LspHoverNormal", { fg = c.fg, bg = c.bg_soft })
	hl(0, "LspHoverBorder", { fg = c.orange, bg = c.bg_soft })
	hl(0, "LspHoverTitle", { fg = c.orange, bg = c.bg_soft, bold = true })

	-- LSP signature-help: same bg_soft surface as hover, but grey border
	-- so the inner separator (between signature line and documentation)
	-- reads as a subtle divider rather than an orange accent line.
	hl(0, "LspSignatureNormal", { fg = c.fg, bg = c.bg_soft })
	hl(0, "LspSignatureBorder", { fg = c.grey, bg = c.bg_soft })
	hl(0, "LspSignatureTitle", { fg = c.grey_soft, bg = c.bg_soft, bold = true })

	hl(0, "ColorColumn", { bg = c.bg_soft })
	hl(0, "Conceal", { fg = c.grey })

	-- Cursor variations
	hl(0, "Cursor", { fg = c.bg, bg = c.orange })
	hl(0, "lCursor", { fg = c.bg, bg = c.orange })
	hl(0, "CursorIM", { fg = c.bg, bg = c.orange })
	hl(0, "CursorLine", { bg = c.bg_soft })
	hl(0, "CursorColumn", { bg = c.bg_soft })
	hl(0, "Visual", { bg = c.orange_25, fg = c.bg })
	hl(0, "VisualNOS", { bg = c.orange_20, fg = c.bg })

	-- Directory and buffer
	hl(0, "Directory", { fg = c.grey_soft })
	hl(0, "EndOfBuffer", { fg = c.grey_dark })

	-- Line numbers and signs
	local sign_bg = cfg.transparent and "NONE" or nil
	hl(0, "LineNr",       { fg = c.grey_dark, bg = sign_bg })
	hl(0, "CursorLineNr", { fg = c.orange,    bg = sign_bg, bold = true })
	hl(0, "SignColumn",   { fg = c.grey_dark, bg = sign_bg })
	hl(0, "SignColumnSB", { fg = c.grey_dark, bg = sidebar_bg })
	hl(0, "FoldColumn",   { fg = c.grey,      bg = sign_bg })

	-- Folding
	hl(0, "Folded", { fg = c.grey, bg = c.bg_soft })

	-- Matching brackets and search
	hl(0, "MatchParen", { fg = c.orange, bg = c.bg_soft, bold = true })
	hl(0, "Search", { fg = c.bg, bg = c.orange_70 })
	hl(0, "IncSearch", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "CurSearch", { fg = c.bg, bg = c.error_red, bold = true })
	hl(0, "Substitute", { fg = c.bg, bg = c.warn_yellow, bold = true })

	-- Messages and prompts
	hl(0, "ErrorMsg", { fg = c.error_red, bold = true, italic = true })
	hl(0, "WarningMsg", { fg = c.warn_yellow })
	hl(0, "ModeMsg", { fg = c.fg, bold = true })
	hl(0, "MoreMsg", s.diag_info)
	hl(0, "Question", s.diag_info)

	-- Special characters
	hl(0, "NonText", { fg = c.grey_dark })
	hl(0, "SpecialKey", { fg = c.grey_dark })
	hl(0, "Whitespace", { fg = c.grey_dark })

	-- Spell checking
	hl(0, "SpellBad", { sp = c.error_red, undercurl = true })
	hl(0, "SpellCap", { sp = c.warn_yellow, undercurl = true })
	hl(0, "SpellLocal", { sp = c.info_grey, undercurl = true })
	hl(0, "SpellRare", { sp = c.success_green, undercurl = true })

	-- ╔══════════════════════════════════════════════════════════════╗
	-- ║                    DIAGNOSTICS                               ║
	-- ╚══════════════════════════════════════════════════════════════╝

	hl(0, "DiagnosticError", s.diag_error)
	hl(0, "DiagnosticWarn", s.diag_warning)
	hl(0, "DiagnosticInfo", s.diag_info)
	hl(0, "DiagnosticHint", s.diag_hint)
	hl(0, "DiagnosticUnderlineError", { sp = c.error_red, undercurl = true })
	hl(0, "DiagnosticUnderlineWarn", { sp = c.warn_yellow, undercurl = true })
	hl(0, "DiagnosticUnderlineInfo", { sp = c.info_grey, undercurl = true })
	hl(0, "DiagnosticUnderlineHint", { sp = c.grey_soft, undercurl = true })

	-- Git signs
	hl(0, "GitSignsAdd", s.git_add)
	hl(0, "GitSignsChange", s.git_change)
	hl(0, "GitSignsDelete", s.git_delete)

	-- ╔══════════════════════════════════════════════════════════════╗
	-- ║                      UI ELEMENTS                            ║
	-- ╚══════════════════════════════════════════════════════════════╝

	-- Popup menu (completion)
	hl(0, "Pmenu", { fg = c.fg, bg = c.bg_dark })
	hl(0, "PmenuSel", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "PmenuSbar", { bg = c.bg_soft })
	hl(0, "PmenuThumb", { bg = c.orange_60 })
	hl(0, "PmenuMatch", { fg = c.orange, bold = true })
	hl(0, "PmenuMatchSel", { fg = c.bg, bg = c.orange, bold = true })
	hl(0, "PmenuExtra", { fg = c.grey_soft })
	hl(0, "PmenuExtraSel", { fg = c.bg_dark, bg = c.orange })
	hl(0, "PmenuKind", { fg = c.warn_yellow })
	hl(0, "PmenuKindSel", { fg = c.bg, bg = c.orange })

	-- Completion hints
	hl(0, "ComplMatchIns", { fg = c.grey })
	hl(0, "PreInsert", { fg = c.grey })
	hl(0, "ComplHint", { fg = c.grey_soft })
	hl(0, "ComplHintMore", s.diag_info)

	-- Quickfix
	hl(0, "QuickFixLine", { bg = c.bg_soft, bold = true })

	-- Tabs
	hl(0, "TabLine", { fg = c.grey, bg = c.bg_dark })
	hl(0, "TabLineFill", { bg = c.bg })
	hl(0, "TabLineSel", { fg = c.fg, bg = c.bg })

	-- Terminal cursor
	hl(0, "TermCursor", { fg = c.bg, bg = c.orange })
	hl(0, "TermCursorNC", { fg = c.bg, bg = c.grey })

	-- Window elements
	hl(0, "Title", { fg = c.slate_grey_80, bold = true })
	hl(0, "WildMenu", { fg = c.bg, bg = c.orange })
	hl(0, "WinBar", { fg = c.orange })
	hl(0, "WinBarNC", { fg = c.grey })
	hl(0, "WinSeparator", { fg = c.bg_soft })

	-- Status line
	hl(0, "StatusLine", { fg = c.fg_soft, bg = c.bg_soft })
	hl(0, "StatusLineNC", { fg = c.grey, bg = c.bg_dark })
	hl(0, "VertSplit", { fg = c.bg_soft })

	-- Message separator
	hl(0, "MsgSeparator", { link = "WinSeparator" })

	-- Command line
	hl(0, "MsgArea", { fg = c.fg, bg = "NONE" })
	hl(0, "CmdLine", { fg = c.orange_70, bg = c.bg_dark })
	hl(0, "CmdLineIcon", { fg = c.orange, bg = c.bg_dark })
	hl(0, "CmdLineBorder", { fg = c.grey_soft, bg = c.bg_dark })
	hl(0, "CmdLineTitle", { fg = c.orange, bg = c.bg_dark, bold = true })
	hl(0, "CmdLinePopup", { fg = c.fg, bg = c.bg_dark })
	hl(0, "CmdLinePrompt", { fg = c.orange_70, bg = c.bg_dark })
end

return M
