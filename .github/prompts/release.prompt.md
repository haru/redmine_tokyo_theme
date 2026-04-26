---
description: "Create a distribution zip bundle for the Redmine Tokyo theme"
agent: "agent"
---
Create a release bundle for the Redmine Tokyo theme.

1. Run the packaging command from the repo root (`/workspaces/redmine_tokyo_theme`):

```bash
zip -r redmine_tokyo_theme.zip . \
  -x "*.git*" \
  -x "*.devcontainer*" \
  -x "*.playwright-mcp*" \
  -x "*.claude*" \
  -x "*.vscode*" \
  -x "*.mcp.json"
```

2. Verify the zip contains the required files:
   - `stylesheets/application.css` and all assets in `stylesheets/`
   - `stylesheets/icons/*.svg`
   - `javascripts/theme.js`
   - `favicon/`
   - `README.md`, `LICENSE`, `AGENTS.md`

3. Verify the zip does NOT contain dev artifacts:
   - `.git/`, `.devcontainer/`, `.playwright-mcp/`, `.claude/`, `.vscode/`

Report the final zip file size and list of included top-level entries.
