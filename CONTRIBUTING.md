# Contributing

## Reporting bugs

Use the [Bug Report](.github/ISSUE_TEMPLATE/bug_report.md) issue template. Include your Neovim version (`nvim --version`), a minimal reproduction (ideally without other plugins), and a screenshot or description of the wrong highlight.

## Suggesting features

Use the [Feature Request](.github/ISSUE_TEMPLATE/feature_request.md) issue template. For new language integrations or highlight groups, include which token class it belongs to and which style axis it should follow.

## Submitting pull requests

1. Fork the repo and create a branch from `main`.
2. Make your changes. Keep the scope tight — one language, one integration, one fix per PR.
3. Run `make lint` and `make test` locally. Both must pass.
4. Open a PR against `main` with a clear description of what changed and why.

## Code style

- **No comments** unless the *why* is non-obvious.
- **Reference `color_semantic` roles only** in language and plugin files. Never reference raw hex values or `colors.lua` entries directly from a language file.
- **New style axis → update `style_rules.lua` and `ADR-0001-style-axes.md` first.**
- All Lua must pass `luacheck lua/ tests/` with zero warnings.

## Tests

Highlight changes need coverage in `tests/singularity/highlights_spec.lua`. At minimum, add a spot-check that the affected group has the expected `fg`, `italic`, or `bold` value. Run the full suite:

```sh
make test
```

## Architecture

Before adding something significant, read:

- `CONTEXT.md` — domain glossary (role, axis, palette, etc.)
- `docs/adr/0001-style-axes.md` — why each style exists
- `docs/adr/0002-float-ux.md` — float surface split rationale

If your change introduces a new hard-to-reverse decision, consider whether an ADR is warranted.
