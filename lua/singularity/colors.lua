-- ╔══════════════════════════════════════════════════════════════╗
-- ║  Singularity — Color Palette                                ║
-- ║                                                              ║
-- ║  Structure:                                                  ║
-- ║    1. Active palette (backgrounds, text, orange, greys,      ║
-- ║       cream, sand, diagnostics, neutrals)                    ║
-- ║    2. Reserved palette (aubergine, teal, legacy)             ║
-- ║       Kept for reference — NOT used in highlights.           ║
-- ║                                                              ║
-- ║  Tint convention: _90 = 90% base + 10% white, etc.           ║
-- ╚══════════════════════════════════════════════════════════════╝

local colors = {

	-- ── Backgrounds ───────────────────────────────────────────────
	bg = "#1B1A19", -- warm dark grey (main background)
	bg_dark = "#131211", -- darker shade for floats, sidebars
	bg_soft = "#232221", -- cursorline, subtle UI surfaces

	-- ── Foregrounds / Text ────────────────────────────────────────
	fg = "#F2F1EF", -- primary text
	fg_soft = "#DDD6CF", -- secondary text

	-- ── Grey (warm neutral) ──────────────────────────────────────
	grey = "#AEA79F", -- mid grey (punctuation, borders)
	grey_soft = "#C7C1BA", -- light grey (hints, subtle text)
	grey_dark = "#6E6760", -- dark grey (comments, line numbers)

	-- ── Core Brand: Orange ───────────────────────────────────────
	-- Ubuntu's signature color. Primary accent for keywords,
	-- booleans, constants, and UI highlights.
	orange = "#E95420",
	orange_90 = "#EB6536",
	orange_80 = "#ED764D",
	orange_70 = "#F08763",
	orange_60 = "#F29879",
	orange_50 = "#F4AA90",
	orange_45 = "#F5B29B",
	orange_40 = "#F6BBA6",
	orange_35 = "#F7C3B1",
	orange_30 = "#F8CCBC",
	orange_25 = "#FAD4C7",
	orange_20 = "#FBDDD2",
	orange_15 = "#FCE5DE",
	orange_10 = "#FDEEE9",

	-- ── String Green (for string literals) ───────────────────────
	-- A natural green that harmonizes with the warm palette.
	-- Muted enough to not compete with orange, distinct enough
	-- to immediately identify string content.
	grass_green = "#52931C",
	grass_green_90 = "#63A02D",
	grass_green_80 = "#74AC3E",
	grass_green_70 = "#85B950",
	grass_green_60 = "#96C561",
	grass_green_50 = "#A8D173",
	grass_green_40 = "#B9DD84",
	grass_green_30 = "#CAEA95",
	grass_green_20 = "#DBF2A7",
	grass_green_10 = "#ECFAB8",

	-- ── Warm Grey Tints ──────────────────────────────────────────
	-- Extended warm grey ramp for text elements and UI.
	warm_grey = "#AEA79F",
	w_grey_90 = "#B6AFA8",
	w_grey_80 = "#BEB8B2",
	w_grey_70 = "#C6C1BB",
	w_grey_60 = "#CECAC5",
	w_grey_50 = "#D6D3CF",
	w_grey_45 = "#DAD7D3",
	w_grey_40 = "#DEDBD8",
	w_grey_35 = "#E2E0DD",
	w_grey_30 = "#E6E4E2",
	w_grey_25 = "#EAE9E7",
	w_grey_20 = "#EEEDEB",
	w_grey_15 = "#F2F1F0",
	w_grey_10 = "#F6F6F5",

	-- ── Slate Grey (warm neutral) ────────────────────────────────
	-- For modules, namespaces, type builtins, and parameters.
	-- Warmed from the original #6B8387 to remove blue cast.
	slate_grey = "#828079",
	slate_grey_90 = "#8F8D86",
	slate_grey_80 = "#9B9994",
	slate_grey_70 = "#A8A6A1",
	slate_grey_60 = "#B4B3AF",
	slate_grey_50 = "#C1C0BC",
	slate_grey_45 = "#C7C6C3",
	slate_grey_40 = "#CDCCC9",
	slate_grey_35 = "#D3D3D0",
	slate_grey_30 = "#DAD9D7",
	slate_grey_25 = "#E0DFDE",
	slate_grey_20 = "#E6E6E4",
	slate_grey_15 = "#ECECEB",
	slate_grey_10 = "#F3F2F2",

	-- ── Cream (for types, classes, interfaces) ───────────────────
	cream = "#D4C5A9",
	cream_90 = "#D7C8AC",
	cream_80 = "#DACBAF",
	cream_70 = "#DDCEB2",
	cream_60 = "#E0D1B5",
	cream_50 = "#E3D4B8",
	cream_40 = "#E6D7BB",
	cream_30 = "#E9DABE",
	cream_20 = "#ECDDC1",
	cream_10 = "#EFE0C4",

	-- ── Warm Sand (for functions and callables) ──────────────────
	warm_sand = "#D8B08A",

	-- ── Diagnostic Colors ────────────────────────────────────────
	-- Harmonious with the warm palette. Not traditional red/yellow/blue
	-- but derived from orange and sage tones for visual cohesion.
	error_red = "#E95420", -- Ubuntu orange (warm, not jarring)
	warn_yellow = "#ED764D", -- Orange 80 (soft warning tone)
	info_grey = "#828079", -- Warm slate (replaces old blue-tinted info)
	success_green = "#87A96B", -- Sage green (harmonious with warm palette)

	-- Success Green Tints
	success_green_90 = "#92B176",
	success_green_80 = "#9DB981",
	success_green_70 = "#A8C18C",
	success_green_60 = "#B3C997",
	success_green_50 = "#BED1A2",

	-- ── Neutral ──────────────────────────────────────────────────
	cool_grey = "#333333",
	text_grey = "#111111",
	white = "#FFFFFF",
	black = "#000000",

	-- ══════════════════════════════════════════════════════════════
	-- RESERVED — The following colors are part of the Ubuntu brand
	-- palette. They are kept for reference but are NOT used in
	-- active highlight definitions. Do not reference these in
	-- highlight groups.
	-- ══════════════════════════════════════════════════════════════

	-- ── Teal (reserved) ──────────────────────────────────────────
	-- Previously used for decorators/attributes, replaced by Cream.
	teal = "#5F9EA6",
	teal_90 = "#6BA6AE",
	teal_80 = "#77AEB6",
	teal_70 = "#83B6BE",
	teal_60 = "#8FBEC6",
	teal_50 = "#9BC6CE",
	teal_40 = "#A7CED6",
	teal_30 = "#B3D6DE",
	teal_20 = "#BFDEE6",
	teal_10 = "#CBE6EE",

	-- ── Canonical Aubergine (reserved) ───────────────────────────
	aubergine = "#772953",
	caub_90 = "#843E64",
	caub_80 = "#925375",
	caub_70 = "#9F6986",
	caub_60 = "#AD7E97",
	caub_50 = "#BB94A9",
	caub_45 = "#C19EB1",
	caub_40 = "#C8A9BA",
	caub_35 = "#CFB4C2",
	caub_30 = "#D6BECB",
	caub_25 = "#DDC9D4",
	caub_20 = "#E3D4DC",
	caub_15 = "#EADEE5",
	caub_10 = "#F1E9ED",

	-- ── Light Aubergine (reserved) ───────────────────────────────
	light_augb = "#77216F",
	laugb_90 = "#84377D",
	laugb_80 = "#924D8B",
	laugb_70 = "#9F639A",
	laugb_60 = "#AD79A8",
	laugb_50 = "#BB90B7",
	laugb_45 = "#C19BBE",
	laugb_40 = "#C8A6C5",
	laugb_35 = "#CFB1CC",
	laugb_30 = "#D6BCD3",
	laugb_25 = "#DDC7DB",
	laugb_20 = "#E3D2E2",
	laugb_15 = "#EADDE9",
	laugb_10 = "#F1E8F0",

	-- ── Mid Aubergine (reserved) ─────────────────────────────────
	mid_augb = "#5E2750",
	mid_augb_90 = "#6E3C61",
	mid_augb_80 = "#7E5273",
	mid_augb_70 = "#8E6784",
	mid_augb_60 = "#9E7D96",
	mid_augb_50 = "#AE93A7",
	mid_augb_45 = "#B69DB0",
	mid_augb_40 = "#BEA8B9",
	mid_augb_35 = "#C6B3C1",
	mid_augb_30 = "#CEBECA",
	mid_augb_25 = "#D6C9D3",
	mid_augb_20 = "#DED3DC",
	mid_augb_15 = "#E6DEE4",
	mid_augb_10 = "#EEE9ED",

	-- ── Dark Aubergine (reserved) ────────────────────────────────
	dark_augb = "#2C001E",
	dark_augb_90 = "#411934",
	dark_augb_80 = "#56334B",
	dark_augb_70 = "#6B4C61",
	dark_augb_60 = "#806678",
	dark_augb_50 = "#957F8E",
	dark_augb_45 = "#A08C99",
	dark_augb_40 = "#AA99A5",
	dark_augb_35 = "#B5A5B0",
	dark_augb_30 = "#BFB2BB",
	dark_augb_25 = "#CABFC6",
	dark_augb_20 = "#D4CCD2",
	dark_augb_15 = "#DFD8DD",
	dark_augb_10 = "#E9E5E8",
}

return colors
