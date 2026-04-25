---
description: "Use when writing or editing CSS for the Redmine Tokyo theme. Covers CSS variable usage, selector patterns, and asset references."
applyTo: "stylesheets/**/*.css"
---
# CSS Guidelines — Redmine Tokyo Theme

Full architecture details: [CLAUDE.md](../../CLAUDE.md)

## Hard Constraints

- Image paths **must be relative** (e.g., `url(gantt-blue.png)`) — all images must live in `stylesheets/`
- Never use absolute URLs for assets
- The `@import url(../../../stylesheets/application.css)` at the top of `application.css` traverses from `public/themes/redmine_tokyo_theme/stylesheets/` → `public/stylesheets/` — do not change this path

## CSS Custom Properties

Use `:root` variables instead of hardcoded values:

| Variable | Purpose |
|---|---|
| `--md-primary` | Primary brand color (#1976d2) |
| `--md-secondary` | Secondary color (#43a047) |
| `--md-surface` | Card/panel background |
| `--md-border` | Border color |
| `--md-text` | Body text color |
| `--md-shadow-sm` / `--md-shadow-md` | Elevation shadows |

## Conventions

- 2-space indentation; lowercase, hyphenated selectors (`.sidebar-box`)
- Section comments: `/* Issue List */`, `/* Gantt Chart */`
- Group related declarations; blank line between groups

## Priority Row Pattern

When adding issue priority styles, cover all four states for each priority level:

```css
tr.odd.priority-N,
table.list tbody tr.odd.priority-N:hover { color: #hex; }
tr.odd.priority-N                        { background: #hex; }
tr.even.priority-N,
table.list tbody tr.even.priority-N:hover { color: #hex; }
tr.even.priority-N                        { background: #hex-alt; }
tr.odd.priority-N td,
tr.even.priority-N td                     { border-bottom-color: #hex; }
```

Active priorities: 3, 5, 6, 7.
