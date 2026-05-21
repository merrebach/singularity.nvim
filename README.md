# singularity.nvim

A warm, italic-heavy dark colorscheme for Neovim. The palette descends from Ubuntu's signature orange (`#E95420`) — that hue is the primary accent — while the aesthetic leans toward rose-pine / catppuccin: more italic, lighter use of bold, and **explicit style axes** that document why each token is styled the way it is.

## Requirements

- Neovim >= 0.10
- Optional but recommended: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for language-aware highlighting

## Installation

**lazy.nvim** (recommended)
```lua
{
  "merrebach/singularity.nvim",
  priority = 1000,
  config = function()
    require("singularity").setup({})
    vim.cmd("colorscheme singularity")
  end,
}
```

**packer.nvim**
```lua
use {
  "merrebach/singularity.nvim",
  config = function()
    require("singularity").setup({})
    vim.cmd("colorscheme singularity")
  end,
}
```

**mini.deps**
```lua
MiniDeps.add("merrebach/singularity.nvim")
require("singularity").setup({})
vim.cmd("colorscheme singularity")
```

**vim-plug**
```vim
Plug 'merrebach/singularity.nvim'
" then in your init.lua or after plug#end():
lua require("singularity").setup({})
lua vim.cmd("colorscheme singularity")
```

## Setup

All options with their defaults:

```lua
require("singularity").setup({
  -- Toggle italic globally (affects foreign, declaration, organizational axes)
  italic = true,

  -- Toggle bold globally (affects definition-site axis only)
  bold = true,

  -- Apply the palette background color to Normal and related groups.
  -- Set to false to leave the background unset (inherits from the terminal).
  background = true,

  -- Force bg = "NONE" on Normal and gutter groups regardless of `background`.
  -- Requires terminal-level transparency to be configured separately.
  transparent = false,

  -- Surgical per-role overrides. Keys match color_semantic.lua role names.
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

## Overrides

Override any semantic role by name. Keys come from `color_semantic.lua`.

**Change a single color:**
```lua
require("singularity").setup({
  overrides = {
    func = { fg = "#ffffff" },  -- make all function identifiers white
  },
})
```

**Force a style regardless of italic/bold toggles:**
```lua
require("singularity").setup({
  overrides = {
    keyword   = { fg = "#E95420", italic = false },  -- remove italic from keywords
    type      = { fg = "#D4C5A9", bold = true },     -- force bold on types
    parameter = { fg = "#828079", italic = true },   -- always italic, even if italic = false
  },
})
```

**Disable a role entirely (inherit default editor color):**
```lua
require("singularity").setup({
  overrides = {
    comment = { link = "Comment" },  -- link to the base Comment group
  },
})
```

## Background

**Opaque background (default)** — uses `#2B2A29` for `Normal`:
```lua
require("singularity").setup({ background = true })
```

**No background** — leaves `Normal.bg` unset; the terminal's own background color shows through:
```lua
require("singularity").setup({ background = false })
```

**Terminal transparency** — forces `bg = "NONE"` on `Normal`, `NormalNC`, `SignColumn`, `LineNr`, and related gutter groups. Requires your terminal emulator to have transparency configured:
```lua
require("singularity").setup({ transparent = true })
```

> `transparent = true` takes precedence over `background`. Both set to `false` and `transparent = true` produce the same result.

## Toggles

```lua
-- No italic anywhere
require("singularity").setup({ italic = false })

-- No bold anywhere
require("singularity").setup({ bold = false })

-- Minimal: no italic, no bold
require("singularity").setup({ italic = false, bold = false })
```

## Integrations

Disable integrations you don't need:

```lua
require("singularity").setup({
  integrations = {
    treesitter    = false,  -- skip all @-prefixed treesitter highlight groups
    rust          = false,  -- skip rust-specific groups
    window_groups = false,  -- skip GroupsActive/Current/etc.
  },
})
```

**What happens without treesitter?** Syntax highlighting falls back to Vim's built-in regex highlighter. Colors still apply — the assignment is just less precise (e.g. `Function` instead of `@function`).

**What happens without a language integration?** That language's semantic overrides are skipped. Base treesitter groups (`@function`, `@keyword`, etc.) still apply.

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

## Language support

All languages benefit from Singularity's treesitter highlight group assignments (the `@` capture groups). Some languages receive additional attention in the form of custom query files and/or dedicated semantic modules.

| Language | Custom queries | Semantic module | Notes |
|---|---|---|---|
| TypeScript | ✓ | ✓ | Builtins, type-only imports, `Array`/`Promise`/`console` |
| TSX | ✓ | — | Shares TypeScript query overrides |
| Python | ✓ | ✓ | Stdlib builtins → `@function.builtin` (italic/foreign axis) |
| Rust | — | ✓ | Lifetime, attribute, macro captures |
| All others | — | — | Base treesitter `@` captures apply — full color, no extra specificity |

**Custom queries** ship in `queries/<lang>/highlights.scm` with `; extends`, so they layer on top of nvim-treesitter's bundled queries. Your own `after/queries/` take precedence — singularity's queries will not overwrite them.

**Semantic modules** are language-specific Lua files that set highlight groups beyond what treesitter captures (e.g. LSP semantic tokens, language-specific Vim syntax groups). Disable any module via `integrations = { python = false }` etc.

## Float surfaces

Two distinct surfaces:

- **Global** (`NormalFloat` / `FloatBorder`) — `bg_dark` + orange rounded border. File explorer, Telescope, Lazy, Mason, diagnostic floats.
- **Hover** (`LspHoverNormal` / `LspHoverBorder`) — `bg_soft` + orange rounded border. Applied via `winhighlight` on the hover window only.

See `docs/adr/0002-float-ux.md` for the rationale.

## window-groups.nvim integration

When `integrations.window_groups = true` (default), Singularity defines `GroupsActive`, `GroupsCurrent`, `GroupsInactive`, `GroupsSep`, and `GroupsFill` for [window-groups.nvim](https://github.com/merrebach/window-groups.nvim).

This only takes effect if window-groups.nvim is installed. The integration is safe to leave enabled even if you don't use window-groups.

## Plugin support

Plugins below have dedicated highlight files — every relevant group is explicitly set. Plugins not in this list still render correctly via Neovim's standard UI groups (`Normal`, `FloatBorder`, `CursorLine`, etc.).

| Plugin | Coverage |
|---|---|
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Explorer, picker/list cursor, dashboard, notifications, activity bar |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Input, results, preview panes; borders, titles, selection |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tabs, buffers, active/inactive/fill states |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | All item kinds, match and fuzzy-match highlighting |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Mode segment colors |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Sign column add/change/delete, current-line blame |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Normal, NC, sign column |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager UI |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Installer UI headers, blocks |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Float window and border |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | All five severity levels (border, icon, title) |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent chars, scope, whitespace |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Bracket levels mapped to orange tints |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Key popup, groups, separators |
| [leap.nvim](https://github.com/ggandor/leap.nvim) | Jump labels (primary, secondary, backdrop) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | NOTE, TODO, FIX, WARN, PERF, TEST badges |
| [dashboard.nvim](https://github.com/nvimdev/dashboard-nvim) / [alpha.nvim](https://github.com/goolord/alpha-nvim) | Header, center, shortcut, footer |
| [window-groups.nvim](https://github.com/merrebach/window-groups.nvim) | Winbar group indicators (gated by `integrations.window_groups`) |

## Edge cases

- **`:colorscheme singularity` before `setup()`** — the `colors/singularity.lua` entry point calls `load()` directly, which skips `setup()`. All options default to their values in `config.lua`. Call `setup()` before `:colorscheme singularity` to apply your configuration.
- **Calling `setup()` multiple times** — each call overwrites the running config. The last `setup()` before `:colorscheme singularity` wins.
- **`overrides` applies after all modules load.** Per-role overrides always win, regardless of what any integration sets.
- **Disabling `treesitter` does not remove base `@` groups** that the runtime already set. It only skips singularity's assignments to those groups.
- **`italic = false` in `setup()` vs `italic = false` in `overrides`** — the global toggle affects every role using the italic axes; an override for a specific role takes precedence and can re-enable italic on that role even when the global toggle is off.

## Extending

- **New language:** copy an existing language file, reference `color_semantic` roles only.
- **New role:** add to `color_semantic.lua` and compose via `style_rules` so the axis stays documented.
- **New style axis:** update `style_rules.lua` + `ADR-0001-style-axes.md` before adding call sites.

## Design

See `CONTEXT.md` for the domain glossary and `docs/adr/` for architectural decisions.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md).

```sh
make install-hooks   # install pre-commit lint hook
make lint            # run luacheck
make test            # run plenary tests (requires Neovim in PATH)
```

## License

MIT — see [LICENSE](LICENSE).
