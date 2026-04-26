---
description: "Use when writing or editing JavaScript for the Redmine Tokyo theme. Enforces ES5 syntax and jQuery patterns."
applyTo: "javascripts/**/*.js"
---
# JavaScript Guidelines — Redmine Tokyo Theme

Full architecture details: [CLAUDE.md](../../CLAUDE.md)

## Strict ES5 — No Modern Syntax

| Forbidden | Use instead |
|---|---|
| `const` / `let` | `var` |
| Arrow functions `() =>` | `function() {}` |
| Template literals `` `${x}` `` | String concatenation `"" + x` |
| Destructuring, spread, optional chaining | Explicit property access |

## DOM-Ready Pattern

jQuery is provided by Redmine — use it:

```javascript
$(document).ready(function() {
    var el = $('#selector');
    if (el.length > 0) {
        // logic here
    }
});
```

## Rules

- Guard every DOM selection: check `.length > 0` (or truthy) before acting on it
- No external libraries beyond Redmine's bundled jQuery
- No `console.log` left in production code
- No CDN references unless absolutely necessary — note them in a comment explaining why
