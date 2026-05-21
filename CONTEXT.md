# Singularity Colorscheme

Glossary and design rules for the Singularity colorscheme. Read alongside [`README.md`](README.md) and [`docs/adr/0002-singularity-style-axes.md`](../../../../docs/adr/0002-singularity-style-axes.md).

## Language

**Palette**:
The raw set of named colours in `colors.lua` (`orange`, `cream`, `grass_green`, `slate_grey_80`, …). Hex strings, no styling.
_Avoid_: theme, scheme, skin.

**Semantic Role**:
A named entry in `color_semantic.lua` (`s.func`, `s.keyword_declaration`, `s.type_definition`, …). Composes a Palette colour with a Style Axis. Highlight files reference Semantic Roles, never Palette colours directly.
_Avoid_: highlight name, group, token (which mean other things below).

**Style Axis**:
A reason a glyph is italicised, bolded, struck-through, or underlined. The six canonical axes are `foreign`, `declaration`, `organizational`, `definition`, `deprecated`, `readonly`. Each is implemented as a function in `style_rules.lua`.
_Avoid_: attribute, modifier (used by LSP for something else), style.

**Foreign**:
Style Axis for identifiers that come from outside the user's code — language builtins, stdlib, default libraries. Italic. Token kind is identifier.
_Avoid_: builtin (also a Treesitter capture name; use the term only for the axis).

**Declaration Site**:
Style Axis for keywords that introduce a binding or declare storage (`def`, `class`, `import`, `let`, `const`, `type`, `interface`). Italic. Token kind is keyword.
_Avoid_: declaration (ambiguous — see Definition Site).

**Definition Site**:
Style Axis for the place where a type or constructor is *introduced*. Bold. Reserved for `type_definition` and `constructor` only. A type *reference* (`x: Foo`) is plain cream, not bold.
_Avoid_: type name, class name.

**Constructor**:
A callable whose call-site creates an instance (`new Foo()`, `Foo(...)` in Python, `Foo {}` in Rust). Treated as a Definition Site — bold cream. Distinct from `func` (warm sand).
_Avoid_: factory, builder.

**Foreground (`fg`)**:
The `fg` value in a highlight spec. Always sourced from the Palette. Never set as a literal hex outside `colors.lua`.

**Property**:
A member access (`obj.x`, `a.b.c`). Distinct from variable. Cream-tinted (`cream_80`) so type names and properties read as related but not identical.
_Avoid_: field (use only where the source language calls it that — e.g. `@field.yaml`).

**Module**:
A namespace or import target (`os`, `pathlib`, the `React` in `React.Fragment`). Italic (organizational) slate grey.
_Avoid_: package, namespace (used loosely; reserve "namespace" for the LSP token).

**Decorator**:
`@decorator` in Python, `@Attribute` in TS, `#[attr]` in Rust. Cream; built-in decorators get foreign italic.
_Avoid_: annotation (which usually means a type annotation).

**Float Surface (global)**:
The fill of any floating window that is not an LSP popup — file explorer popups, Telescope previewer, Lazy, Mason, diagnostic float. Maps to `NormalFloat` + `FloatBorder` + `FloatTitle`. Bg is `bg_dark`, border is `orange` rounded.
_Avoid_: popup (used for Pmenu/completion menu, which is a different surface).

**Hover Surface**:
The fill of the LSP hover popup (`<S-k>`). Maps to `LspHoverNormal` + `LspHoverBorder` + `LspHoverTitle`. Bg is `bg_soft`, border is `orange` rounded. Applied via `winhighlight` inside the `open_floating_preview` wrapper, not globally — see ADR 0003.
_Avoid_: hover float (the surface is the styling layer; the float is the window).

**Signature Surface**:
The fill of the LSP signature-help popup (auto-triggers inside `()`). Maps to `LspSignatureNormal` + `LspSignatureBorder` + `LspSignatureTitle`. Same `bg_soft` background as Hover Surface; border and inner separator use `grey` instead of `orange` so the separator between the signature line and documentation reads as a quiet divider, not an accent.
_Avoid_: signature float.

## Relationships

- Every highlight spec set in language files is **either** a Semantic Role from `color_semantic.lua` **or** a one-off (`{ fg = c.X, italic = true }`) — never imports the Palette to redefine a Semantic Role's colour.
- Every italic in `color_semantic.lua` flows through `r.foreign`, `r.declaration`, or `r.organizational` — three meanings, picked by token kind.
- Every bold in `color_semantic.lua` flows through `r.definition` — one meaning, two call sites.
- `deprecated` and `readonly` compose on top of any Semantic Role.

## Example dialogue

> **Dev:** "Why is `os` italic? It's not a keyword."
> **Resolution:** `os` is a module, and the **Organizational** axis covers modules, parameters, comments — all italic.

> **Dev:** "Why is `class Foo:` bold on `Foo` but `: Foo` is not?"
> **Resolution:** `class Foo` is a **Definition Site** (bold). `: Foo` is a type *reference* and falls under `@type`, which is plain cream.

> **Dev:** "Both `def` and `os.path.join` are italic — different reason?"
> **Resolution:** Yes. `def` is the **Declaration** axis. `os`, `path`, `join` are **Foreign**. Same struct today, two distinct axes. ADR 0002 explains why we don't collapse them.

## Flagged ambiguities

- "Builtin" used to mean both the **Foreign** style axis and the Treesitter capture `@*.builtin`. Resolved: the style axis is **Foreign**; `@*.builtin` is just a capture path that happens to map to it.
- "Declaration" used to overlap with **Definition**. Resolved: **Declaration Site** is for keywords introducing a binding (italic). **Definition Site** is the introduced symbol itself (bold). They appear on the same line but on different tokens.
- "Type" used to mean both `@type` references and `@type.definition`. Resolved: the bare reference is plain cream; only the definition is bold.
- `bg_soft` (`#353331`) is used by **Hover Surface** (`LspHoverNormal`), **Signature Surface** (`LspSignatureNormal`), AND by `ColorColumn` / `CursorColumn` / `Folded` / `QuickFixLine` / `StatusLine`. Accepted: LSP popups and subtle UI surfaces share one tint. Resolution path if it bites: promote to a dedicated `float_bg` palette entry. See ADR 0003.
- "Float surface" initially meant *all* floats with a lighter bg. After observing the explorer turn lighter as a side effect, the lighter bg was scoped to LSP hover only; then extended to signature help with a grey border. Three distinct surfaces now: **Float Surface (global)** (`bg_dark`), **Hover Surface** (`bg_soft` + orange border), **Signature Surface** (`bg_soft` + grey border).
