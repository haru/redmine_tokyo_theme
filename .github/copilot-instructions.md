# GitHub Copilot Instructions for Redmine Tokyo Theme

## Project Overview

This is a static theme for Redmine that provides Tokyo-inspired styling. The theme consists of CSS overrides, JavaScript enhancements, and accompanying assets (images, fonts) without requiring a build process.

## Key Technical Constraints

- **No Build Step**: This is a static theme with no compilation or bundling required
- **Redmine Integration**: Files must be placed in `public/themes/redmine_tokyo_theme` within a Redmine installation
- **Plain JavaScript**: Use ES5 syntax only; no modern ES6+ features or bundlers
- **Relative Paths**: All asset references must use relative paths from the stylesheet location

## File Structure & Responsibilities

- `stylesheets/application.css`: Main CSS file with all style overrides
- `stylesheets/*.png|*.svg`: Theme images that must be in the same directory as the CSS
- `javascripts/theme.js`: Optional JavaScript enhancements (plain ES5, DOM-ready wrapped)
- `favicon/`: Custom favicon assets for Redmine
- `doc/`: Documentation and screenshots

## Coding Standards

### CSS

- Use 2-space indentation
- Lowercase selectors with hyphenated class names (`.sidebar-box`, `.issue-list`)
- Group related declarations with blank line separators
- Add semantic comments for major sections: `/* Issue List */`
- Maintain specificity appropriate for overriding Redmine's default styles

### JavaScript

- Plain ES5 only (no const/let, arrow functions, or template literals)
- Wrap all code in `document.ready` or equivalent DOM-ready checks
- Avoid external dependencies; use CDN links only when absolutely necessary
- Guard DOM selections against null/undefined

### Naming Conventions

- CSS classes: lowercase-hyphenated (`.gantt-header`)
- JavaScript variables: camelCase (`var itemCount`)
- Files: lowercase-hyphenated (`gantt-blue.png`)

## Development Workflow

1. Copy theme folder to Redmine's `public/themes/` directory
2. Restart Rails server if asset caching is enabled: `bundle exec rails tmp:cache:clear`
3. Test changes across key views: issue list, Gantt chart, sidebar modules, wiki pages
4. Force browser cache clear for CSS/JS validation

## Testing Requirements

- Verify visual changes in a local Redmine sandbox
- Test across major views: issues, Gantt, calendar, wiki, settings
- Capture before/after screenshots for UI changes (name: `view-name-YYYY-MM.png`)
- Document browser-specific workarounds in commit messages

## Commit Guidelines

- **Language**: Write all commit messages in English for international collaboration
- Use imperative mood: "Update Gantt colors", "Fix sidebar alignment"
- Reference issues with `refs #ID` when applicable
- Keep commits focused on single concerns
- Include screenshots in PR description for visual changes

## Distribution

- Release bundle created with: `zip -r redmine_tokyo_theme.zip .`
- Ensure `.git` and temporary files are excluded
- Verify package structure allows drop-in installation to Redmine themes directory

## Common Patterns

### Adding a New Style Override

```css
/* Section Name */
.redmine-selector {
  property: value;
  /* Keep overrides minimal and specific */
}
```

### Adding JavaScript Enhancement

```javascript
(function () {
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }

  function init() {
    var element = document.querySelector(".selector");
    if (element) {
      // Enhancement logic here
    }
  }
})();
```

## What NOT to Do

- Don't add build tools, package managers, or transpilers
- Don't use modern JavaScript features (ES6+)
- Don't reference external assets with absolute URLs
- Don't modify Redmine core files
- Don't add large binary files to the repository

## Context for AI Assistance

When helping with this project:

- Assume deployment to Redmine 5.x or 6.x
- Prioritize cross-browser compatibility (modern browsers + IE11 if needed)
- Keep solutions simple and maintainable
- Consider that users manually install this theme by copying files
- Remember that Redmine uses Rails asset pipeline, so cache busting may be needed
