# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Redmine Tokyo Theme is a static theme for Redmine that modernizes the default look while maintaining familiar functionality. It's maintained by the Redmine Tokyo community and requires no build process - just plain CSS, JavaScript, and static assets.

## Architecture

### Static Theme Structure
This is a **zero-build theme** designed to drop directly into Redmine's `themes/` directory. All files are served as-is by Redmine's asset pipeline without compilation.

### File Organization
- **stylesheets/application.css**: Main stylesheet that imports Redmine's base CSS and applies Material Design-inspired overrides using CSS custom properties
- **stylesheets/*.{png,svg}**: Theme assets (Gantt chart indicators, progress bars, logos) - must stay in same directory as CSS for relative path resolution
- **stylesheets/icons/**: SVG icons for menu items (activity, boards, calendar, gantt, issues, wiki, etc.)
- **javascripts/theme.js**: jQuery-based enhancements for mobile detection and menu visibility
- **favicon/**: Custom favicon for themed Redmine installations

### CSS Architecture
The theme uses CSS custom properties (CSS variables) defined in `:root` for consistent theming:
- Material Design color palette: `--md-primary`, `--md-secondary`, `--md-surface`, `--md-border`, `--md-text`, `--md-shadow-sm`, `--md-shadow-md`
- Typography: Noto Sans JP and Roboto fonts from Google Fonts CDN
- Priority-based styling: Color coding for issue priorities 3, 5, 6, and 7 (odd/even rows with hover states)
- Overrides are applied on top of Redmine's base stylesheet via `@import url(../../../stylesheets/application.css)` — the three `../` levels navigate from `public/themes/redmine_tokyo_theme/stylesheets/` up to `public/stylesheets/`

## Development Commands

### Devcontainer Environment
The repository ships with a devcontainer (`docker-compose.yml`). Services:
- **app**: Main container (Ruby 4.0, Redmine 7.0-stable). The theme is **symlinked** into Redmine's themes directory on container creation: `/usr/local/redmine/themes/redmine_tokyo_theme -> /workspaces/redmine_tokyo_theme`
- **postgres** / **mysql**: Either database backend is initialized (`post-create.sh` runs migrations against both plus sqlite3); which one Redmine actually uses depends on `config/database.yml`
- **browserless**: Headless Chrome (`browserless/chrome`) for Playwright automation

Edit files in `/workspaces/redmine_tokyo_theme` and changes are immediately visible to Redmine.

The `$REDMINE_ROOT` environment variable points to `/usr/local/redmine`. Run Redmine commands from there:

```bash
# Clear asset cache when CSS/JS changes don't appear
cd $REDMINE_ROOT && bundle exec rails tmp:cache:clear

# Restart Redmine server
cd $REDMINE_ROOT && bundle exec rails server -b 0.0.0.0
```

### Playwright MCP / Browser Testing
The Playwright MCP server connects to browserless via `ws://browserless:3000` (configured in `.mcp.json`).

**Important**: When accessing Redmine from the Playwright MCP browser, use **`http://app:3000`** (not `localhost:3000`). The container running the browser resolves `app` as the DevContainer's service name, not `localhost`.

Login credentials come from `.devcontainer/.env` (gitignored, not committed), exposed to the `app` container as `REDMINE_UER` (note the typo — it's intentional and matches the actual variable name in `docker-compose.yml`, not a mistake to "fix") and `REDMINE_PASS`. Look them up with `env | grep -i redmine` rather than assuming a fixed admin/admin login — fall back to `REDMINE_USER` if `REDMINE_UER` isn't set. The `redmine-login` skill (`.claude/skills/redmine-login/`) automates this lookup-and-login flow.

Screenshots taken during browser testing must be saved under `tmp/` (gitignored) — pass an explicit path like `tmp/view-name-YYYY-MM.png` to the screenshot tool rather than the default filename, and never let one land in the repo root.

### Distribution
Create release bundle from the repo root:
```bash
zip -r redmine_tokyo_theme.zip . -x "*.git*" -x "*.devcontainer*" -x "*.playwright-mcp*" -x "*.claude*" -x "*.vscode*" -x "*tmp*"
```

## Testing Approach

Test changes across these key Redmine views:
- **Issue lists**: Priority colors, row styling, hover states
- **Gantt chart**: Custom progress bar images, timeline styling
- **Sidebar modules**: Box styling, border colors
- **Wiki pages**: Typography, heading styles
- **Calendar/Activity**: Icon rendering, date formatting
- **Mobile view**: Menu toggle behavior, responsive layout

Force browser cache clear when testing CSS/JS changes.

## Coding Standards

### CSS
- 2-space indentation
- Lowercase selectors with hyphenated class names (`.sidebar-box`, `.issue-list`)
- Semantic section comments: `/* Issue List */`, `/* Gantt Chart */`
- Group related declarations with blank line separators
- Use CSS custom properties from `:root` for themeable values

### JavaScript
- **Plain ES5 only** - no const/let, arrow functions, template literals, or modern syntax
- jQuery is available (Redmine dependency) - use `$(document).ready()`
- Guard all DOM selections against null/undefined
- No external dependencies beyond Redmine's included jQuery

### Asset References
All image paths in CSS must be relative (e.g., `url(gantt-blue.png)`) since they're served from `public/themes/redmine_tokyo_theme/stylesheets/`.

## Commit Conventions

- **Language**: English commit messages for international collaboration
- **Format**: Imperative mood (e.g., "Update Gantt colors", "Fix sidebar alignment")
- **References**: Use `refs #ID` for Redmine ticket references
- **Scope**: Single-concern commits
- **PR Requirements**: Include summary, before/after screenshots for visual changes, and verification steps

## Technical Constraints

- **No Build Tools**: No npm, webpack, sass, postcss, or any compilation step
- **Browser Support**: Modern browsers (Chrome, Firefox, Safari, Edge)
- **Redmine Integration**: Must work with Redmine 5.x and 6.x
- **Asset Caching**: Redmine's Rails asset pipeline may cache files - clear with `tmp:cache:clear`
- **Path Portability**: Theme must work regardless of Redmine's deployment path (subdir installations, etc.)

## Common Patterns

### Adding Priority Color Styling
Priority colors cover odd/even rows with hover states. Active priorities are 3, 5, 6, and 7:
```css
tr.odd.priority-N,
table.list tbody tr.odd.priority-N:hover {
    color: #colorcode;
}
tr.odd.priority-N {
    background: #bgcolor;
}
tr.even.priority-N,
table.list tbody tr.even.priority-N:hover {
    color: #colorcode;
}
tr.even.priority-N {
    background: #bgcolor-alt;
}
tr.odd.priority-N td,
tr.even.priority-N td {
    border-bottom-color: #bordercolor;
}
```

### Adding JavaScript Enhancements
Wrap in DOM-ready check using jQuery:
```javascript
$(document).ready(function() {
    var element = $('#selector');
    if (element.length > 0) {
        // Enhancement logic
    }
});
```

### Adding Theme Icons
Place SVG icons in `stylesheets/icons/` with lowercase-hyphenated names (e.g., `time-entries.svg`). Reference in CSS with relative paths.
