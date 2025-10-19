# Repository Guidelines

## Project Structure & Module Organization
Source assets live at the repository root. CSS overrides are in `stylesheets/application.css`, companion images (e.g., `stylesheets/gantt-blue.png`) ship alongside the stylesheet, and JavaScript tweaks reside in `javascripts/theme.js`. Place any new images or fonts under `stylesheets/` so relative paths remain valid when Redmine serves the theme. Keep third-party libraries out of the repo; instead, reference CDN links from `theme.js` when absolutely required.

## Build, Test, and Development Commands
This theme is static and does not require a build step. Develop iteratively against a local Redmine checkout: copy the folder into `public/themes/redmine_tokyo_theme` and restart the Rails server if assets are cached. When preparing a release bundle, run `zip -r redmine_tokyo_theme.zip .` from the repo root to package the theme for distribution.

## Coding Style & Naming Conventions
Follow existing CSS conventions: two-space indentation, lowercase selectors, and hyphenated class names (e.g., `.sidebar-box`). Group related declarations with blank lines for readability. Use semantic variable-style comments (`/* Issue List */`) to explain larger sections. JavaScript in `theme.js` is plain ES5—avoid modern bundling features and guard DOM lookups with `document.ready` checks.

## Testing Guidelines
Validate changes in a Redmine sandbox covering issue lists, Gantt chart, and sidebar modules. Force asset reloads with `bundle exec rails tmp:cache:clear` when necessary. Name screenshot comparisons using the view and date (`issue-list-2024-05.png`) and store them outside the repo if they exceed size limits. Document any browser-specific adjustments in your pull request so they can be regression-tested later.

## Commit & Pull Request Guidelines
Commit messages should be short, imperative statements mirroring the existing history (e.g., "Update Gantt colors"). Reference Redmine tickets with `refs #ID` when applicable. Pull requests must include a summary of UI changes, before/after screenshots for visual tweaks, and instructions for verifying the behavior. Confirm that `zip` packaging still succeeds to ensure downstream deployments remain seamless.
