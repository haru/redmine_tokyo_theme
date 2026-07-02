# Repository Guidelines

> Full architecture, CSS/JS patterns, and devcontainer setup: see [CLAUDE.md](CLAUDE.md)

## Quick Reference

| Topic | Detail |
|---|---|
| **No build step** | Static files only — no npm, webpack, or sass |
| **Dev environment** | `$REDMINE_ROOT=/usr/local/redmine`; theme is symlinked, edits reflect immediately at http://localhost:3000 |
| **Cache busting** | `cd $REDMINE_ROOT && bundle exec rails tmp:cache:clear` |
| **Release bundle** | `zip -r redmine_tokyo_theme.zip . -x "*.git*" -x "*.devcontainer*" -x "*.playwright-mcp*" -x "*.claude*" -x "*.vscode*" -x "*tmp*"` |
| **Playwright screenshots** | Save under `tmp/` (gitignored), e.g. `tmp/view-name-YYYY-MM.png` — never the repo root |

## Critical Constraints

- **CSS**: Image paths must be relative (e.g., `url(gantt-blue.png)`); all images belong in `stylesheets/`
- **JavaScript**: ES5 only (`var`, named functions, no arrow functions); jQuery available from Redmine
- **Path portability**: `@import url(../../../stylesheets/application.css)` in `application.css` must not change

## Key Files

| File | Purpose |
|---|---|
| `stylesheets/application.css` | All CSS overrides; Material Design variables in `:root` |
| `stylesheets/icons/*.svg` | Menu icons (16 total); add new ones here with lowercase-hyphenated names |
| `javascripts/theme.js` | Mobile detection and menu visibility tweaks |
| `.devcontainer/post-create.sh` | Symlink setup, bundle install, DB init |

## Commit & PR Conventions

- English commit messages, imperative mood: "Update Gantt colors", "Fix sidebar alignment"
- `refs #ID` for Redmine ticket references
- PR must include before/after screenshots for visual changes
