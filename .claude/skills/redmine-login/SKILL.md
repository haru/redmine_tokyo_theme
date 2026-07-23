---
name: redmine-login
description: Log in to the devcontainer's Redmine instance (http://app:3000) through the Playwright MCP browser, using the REDMINE_USER/REDMINE_PASS (or REDMINE_UER) environment variables for credentials. Use this whenever the user asks to log in to Redmine, sign in as a specific user, or view/test any Redmine screen that requires authentication (issue lists, admin pages, personal "My page", theme changes visible only when logged in, etc.) via browser automation.
---

# Redmine Login (Playwright MCP)

Logs into the Redmine instance running in this devcontainer using a real
browser session (Playwright MCP), authenticating with credentials supplied
via environment variables rather than hardcoded values. Use this any time a
task requires an authenticated Redmine session in the browser — most theme
verification work (issue lists, sidebar, gantt, wiki, admin settings) only
looks right once logged in.

## Why credentials come from the environment

This repo's devcontainer exposes the login credentials as environment
variables instead of documenting a fixed account, so the skill must read
them fresh each time rather than assuming a name. In practice the *username*
variable has been observed under a **misspelled** name (`REDMINE_UER`)
alongside the correctly spelled `REDMINE_USER` — don't assume either one is
guaranteed to be set. Always look up both.

## Steps

1. **Discover the credentials.** Run:
   ```bash
   env | grep -i redmine
   ```
   Use `REDMINE_USER` if set, otherwise fall back to `REDMINE_UER`. The
   password is `REDMINE_PASS`. If neither username variable is set, ask the
   user rather than guessing a default account.

2. **Navigate to the login page.**
   Use `mcp__playwright__browser_navigate` with `http://app:3000/login`.
   (Use `app`, not `localhost` — the browser runs in the `browserless`
   container and resolves `app` as the devcontainer's Redmine service name,
   per this repo's CLAUDE.md.)

   If a call fails with an error like "Target page, context or browser has
   been closed", the browser session was dropped — just re-run
   `browser_navigate` to the same URL and continue; this is a transient
   disconnect, not a real failure.

3. **Get fresh element references.** Take a snapshot
   (`mcp__playwright__browser_snapshot`) and read the returned file. Element
   `ref` values are per-snapshot, so always re-snapshot rather than reusing
   refs from an earlier step or an earlier conversation. Look for the
   `Login` textbox and the `Password` textbox on the login form.

4. **Fill in and submit.**
   - `mcp__playwright__browser_type` into the Login textbox with the
     username.
   - `mcp__playwright__browser_type` into the Password textbox with the
     password.
   - `mcp__playwright__browser_click` the `Login` button.

5. **Confirm success.** A successful login redirects to `/my/page` (page
   title changes to "マイページ" / "My page"). If it instead reloads
   `/login` with an error message, the credentials were wrong or missing —
   report this to the user rather than retrying blindly.

## Security note

Never print the password value in chat output. It's fine to confirm which
username logged in, but treat the password as a secret even though it came
from a local dev environment variable.
