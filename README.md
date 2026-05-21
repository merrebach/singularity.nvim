# singularity.nvim

A warm, italic-heavy dark colorscheme for Neovim. The palette descends from Ubuntu's signature orange (`#E95420`) — that hue is the primary accent — while the aesthetic leans toward rose-pine / catppuccin: more italic, lighter use of bold, and **explicit style axes** that document why each token is styled the way it is.

## Requirements

- Neovim >= 0.10
- Optional but recommended: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for language-aware highlighting

## Installation

```lua
-- lazy.nvim
{
  "merrebach/singularity.nvim",
  priority = 1000,
  config = function()
    require("singularity").setup({})
    vim.cmd("colorscheme singularity")
  end,
}
```

## Setup

```lua
require("singularity").setup({
  -- Toggle italic globally (affects foreign, declaration, organizational axes)
  italic = true,

  -- Toggle bold globally (affects definition-site axis only)
  bold = true,

  -- Surgical per-role overrides. Keys match color_semantic.lua role names.
  -- Example: { func = { fg = "#FFFFFF" } }
  overrides = {},

  -- Opt out of specific language or integration modules.
  integrations = {
    treesitter    = true,
    lsp           = true,
    python        = true,
    typescript    = true,
    rust          = true,
    window_groups = true,  -- GroupsActive/Current/Inactive/Sep/Fill for window-groups.nvim
  },
})
```

## Color hierarchy

| Color | Role |
|---|---|
| Orange `#E95420` | Control-flow keywords, booleans (`orange_80`), constants, UI accents |
| Warm sand `#D8B08A` | Functions, methods, callable identifiers |
| Cream `#D4C5A9` | Types, classes, interfaces, decorators |
| Grass green `#52931C` | Strings |
| Slate grey `#828079` | Modules, namespaces, parameters, type builtins — italic |
| Warm greys | Text, comments, subtle UI chrome |

## Style axes

Singularity assigns a documented reason to every italic, bold, strikethrough, and underline. See `CONTEXT.md` for the full glossary.

| Style | Axis | Token classes |
|---|---|---|
| `italic` | **Foreign** | Identifiers from stdlib / builtins (`os`, `print`, `Array.from`) |
| `italic` | **Declaration** | Keywords that introduce a binding (`def`, `class`, `import`, `let`, `const`, `type`) |
| `italic` | **Organizational** | Modules, parameters, comments, doc strings, markup quotes |
| `bold` | **Definition Site** | `type_definition`, `constructor` only |
| `strikethrough` | **Deprecated** | Any role |
| `underline` | **Readonly / URL** | Any role |

Control flow (`if`, `for`, `return`) is plain orange — no italic.

## Treesitter queries

Singularity ships custom treesitter queries in `queries/` (with `; extends`) for TypeScript, Python, and TSX. These extend the base treesitter highlights. Your own `after/queries/` take precedence.

## Float surfaces

Two distinct surfaces:

- **Global** (`NormalFloat` / `FloatBorder`) — `bg_dark` + orange rounded border. File explorer, Telescope, Lazy, Mason, diagnostic floats.
- **Hover** (`LspHoverNormal` / `LspHoverBorder`) — `bg_soft` + orange rounded border. Applied via `winhighlight` on the hover window only.

See `docs/adr/0002-float-ux.md` for the rationale.

## window-groups.nvim integration

When `integrations.window_groups = true` (default), Singularity defines the `GroupsActive`, `GroupsCurrent`, `GroupsInactive`, `GroupsSep`, and `GroupsFill` highlight groups for [window-groups.nvim](https://github.com/merrebach/window-groups.nvim).

## Extending

- **New language:** copy an existing language file, reference `color_semantic` roles only.
- **New role:** add to `color_semantic.lua` and compose via `style_rules` so the axis stays documented.
- **New style axis:** update `style_rules.lua` + `ADR-0001-style-axes.md` before adding call sites.

## Design

See `CONTEXT.md` for the domain glossary and `docs/adr/` for architectural decisions.

## License

MIT — see [LICENSE](LICENSE).
