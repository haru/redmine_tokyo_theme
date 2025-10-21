# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Redmine Tokyo Theme is a static theme for Redmine that modernizes the default look while maintaining familiar functionality. It's maintained by the Redmine Tokyo community and requires no build process - just plain CSS, JavaScript, and static assets.

## Architecture

### Static Theme Structure
This is a **zero-build theme** designed to drop directly into Redmine's `public/themes/` directory. All files are served as-is by Redmine's asset pipeline without compilation.

### File Organization
- **stylesheets/application.css**: Main stylesheet that imports Redmine's base CSS and applies Material Design-inspired overrides using CSS custom properties
- **stylesheets/*.{png,svg}**: Theme assets (Gantt chart indicators, progress bars, logos) - must stay in same directory as CSS for relative path resolution
- **stylesheets/icons/**: SVG icons for menu items (activity, boards, calendar, gantt, issues, wiki, etc.)
- **javascripts/theme.js**: jQuery-based enhancements for mobile detection and menu visibility
- **favicon/**: Custom favicon for themed Redmine installations

### CSS Architecture
The theme uses CSS custom properties (CSS variables) defined in `:root` for consistent theming:
- Material Design color palette: `--md-primary`, `--md-secondary`, `--md-surface`
- Typography: Noto Sans JP and Roboto fonts from Google Fonts CDN
- Priority-based styling: Comprehensive color coding for issue priorities (priority-5 through priority-7)
- Overrides are applied on top of Redmine's base stylesheet via `@import url(../../../stylesheets/application.css)`

## Development Commands

### Local Development Setup
1. Copy theme to Redmine installation:
   ```bash
   cp -r /path/to/redmine_tokyo_theme /path/to/redmine/public/themes/
   ```

2. Clear Redmine asset cache when CSS/JS changes don't appear:
   ```bash
   bundle exec rails tmp:cache:clear
   ```

3. Restart Redmine Rails server if needed:
   ```bash
   bundle exec rails server
   ```

### Devcontainer Environment
The repository includes a `.devcontainer` setup with:
- Ruby 3.4
- Redmine 6.1-stable
- PostgreSQL and MySQL databases
- No special build commands needed - theme files are edited directly

### Distribution
Create release bundle:
```bash
zip -r redmine_tokyo_theme.zip . -x "*.git*" -x "*.devcontainer*"
```

## Testing Approach

Test changes across these key Redmine views:
- **Issue lists**: Priority colors, row styling, hover states
- **Gantt chart**: Custom progress bar images, timeline styling
- **Sidebar modules**: Box styling, border colors
- **Wiki pages**: Typography, heading styles
- **Calendar/Activity**: Icon rendering, date formatting
- **Mobile view**: Menu toggle behavior, responsive layout

Force browser cache clear when testing CSS/JS changes. Capture before/after screenshots for visual changes (naming: `view-name-YYYY-MM.png`).

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
- **Browser Support**: Modern browsers (Chrome, Firefox, Safari, Edge); IE11 compatibility if needed
- **Redmine Integration**: Must work with Redmine 5.x and 6.x
- **Asset Caching**: Redmine's Rails asset pipeline may cache files - users need to clear cache manually
- **Path Portability**: Theme must work regardless of Redmine's deployment path (subdir installations, etc.)

## Common Patterns

### Adding Priority Color Styling
Priority colors are defined for both odd/even table rows with hover states:
```css
tr.odd.priority-N,
table.list tbody tr.odd.priority-N:hover {
    color: #colorcode;
}
tr.odd.priority-N {
    background: #bgcolor;
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
