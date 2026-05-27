# AGENTS.md — feature-today organization (canonical)

This is the **canonical, org-wide** agent guidance for the feature-today organization.
Every feature-today repository inherits these rules. Per-repo `AGENTS.md` files only add
project-specific details (scopes, structure, commands) on top of what is defined here.

## ⛔ CRITICAL RESTRICTIONS

- **NEVER execute `git push`** — The user pushes manually after review.
- **NEVER execute `git commit` or `git add`** — The user stages and commits manually. Fix files, then stop. Wait for an explicit "commit" instruction.
- **NEVER use GPT models** — Use Claude models only (claude-sonnet-4.x, Claude Opus 4.x+).
- **Everything in English** — Code, comments, commits, documentation, logs, PR descriptions.
- **License is AGPL-3.0-or-later** for every feature-today repo (commercial exception to be added later via NOTICE/CLA).

## Organization Context

**feature-today** is a platform to promote and prioritize custom feature requests, split across these repositories:

| Repo                                                       | Purpose                                                                |
| ---------------------------------------------------------- | ---------------------------------------------------------------------- |
| [`.dev`](https://github.com/feature-today/.dev)            | Orchestration workspace + unified DevContainer + canonical agent rules |
| [`.github`](https://github.com/feature-today/.github)      | Org-wide GitHub config (workflows, templates, community files)         |
| [`website`](https://github.com/feature-today/website)      | Marketing landing page (Qwik + Vercel Edge)                            |
| [`my`](https://github.com/feature-today/my)                | The actual application (Qwik + Vercel Edge)                            |
| [`common`](https://github.com/feature-today/common)        | Shared TypeScript library (types, UI components, helpers)              |
| [`server`](https://github.com/feature-today/server)        | Placeholder — backend API (currently lives in `my` via QwikCity)       |

All repos are licensed **AGPL-3.0-or-later**.

## Stack Conventions

- **Runtime**: Node.js ≥ 24
- **Package manager**: pnpm (latest)
- **Bundler**: Vite 7+
- **Framework**: Qwik 2 + QwikCity
- **Language**: TypeScript ≥ 5.7 (strict)
- **Linter**: oxlint (NOT ESLint)
- **Formatter**: oxc-formatter / `oxlint --fix` (NOT Prettier)
- **Test runner**: Vitest
- **TS helpers**: prefer `@helpers4/*` packages over custom utilities
- **Deployment**: Vercel Edge (for `my` and `website`)

## Commit Messages

All repos follow [Conventional Commits](https://www.conventionalcommits.org/) with a **gitmoji** between the scope and the description.

**Format:** `<type>(<scope>): <emoji> <description>`

**Rules:**

- Description ≤72 chars, lowercase, imperative mood, no trailing period
- Always include exactly ONE emoji
- Multiple logical changes → bullet list in body
- Allowed scopes are repo-specific — see each repo's `.vscode/settings.json` (`conventionalCommits.scopes`)

**Type / emoji table:**

| Type     | Primary | Alternatives (gitmoji.dev)                                                | When to use         |
| -------- | ------- | ------------------------------------------------------------------------- | ------------------- |
| feat     | ✨      | 🚸 UX, ♿️ a11y, 🌐 i18n, 💬 text/literals                                | New feature         |
| fix      | 🐛      | 🚑️ hotfix, 🔒️ security, 🩹 trivial, 🥅 errors, 🚨 warnings, ✏️ typo     | Bug fix             |
| docs     | 📝      | 💡 source comments, 📄 license                                            | Documentation       |
| refactor | ♻️      | 🎨 structure, 🔥 remove code, ⚰️ dead code, 🚚 move/rename                | Code refactoring    |
| test     | ✅      | 🧪 failing test, 💚 fix CI test                                           | Tests               |
| chore    | 🔧      | 🙈 gitignore, 🔖 tag/release, 📌 pin deps, 🩺 healthcheck                 | Maintenance         |
| perf     | ⚡️     | —                                                                         | Performance         |
| style    | 💄      | 🎨 code style                                                             | Code style / UI     |
| ci       | 👷      | 💚 fix CI                                                                 | CI/CD               |
| build    | 📦️     | ➕ add dep, ➖ remove dep, ⬆️ upgrade dep, ⬇️ downgrade dep                | Build system        |
| revert   | ⏪️     | —                                                                         | Revert              |

Pick the **most specific** gitmoji that matches the change. Full list: <https://gitmoji.dev>

**Examples:**

- `feat(select): ✨ add project filtering`
- `fix(ci): 🐛 pin pnpm version`
- `docs(governance): 📝 update contributing guide`
- `build(deps): ⬆️ upgrade qwik to 2.0.5`

## License Header

Every source file (TS, JS, sh, etc.) must include the AGPL-3.0 header. Comment syntax depends on the language.

**TypeScript / JavaScript:**

```ts
/**
 * This file is part of feature-today.
 * Copyright (C) 2026 feature-today contributors
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */
```

**Bash / shell:**

```bash
# This file is part of feature-today.
# Copyright (C) 2026 feature-today contributors
# SPDX-License-Identifier: AGPL-3.0-or-later
```

The `auto-header` devcontainer feature (or `psi-header` VS Code extension) is configured to inject these automatically.

## This Repository (.dev)

**Purpose:** Orchestrate the feature-today organization — multi-root VS Code workspace, unified DevContainer, canonical agent rules, shared VS Code settings.

**Scopes:** defined in `.vscode/settings.json` (`conventionalCommits.scopes`)

### Project Structure

```
.dev/
├── .devcontainer/
│   ├── devcontainer.json       # Cross-repo dev environment
│   └── setup-container.sh      # postCreateCommand: clone-fallback + install
├── .vscode/
│   └── settings.json           # Repo-specific overrides (scopes)
├── scripts/
│   ├── repos.mjs               # Source of truth (reads repos.json)
│   ├── run-each.mjs            # Run a pnpm script in every sibling repo
│   └── git-each.mjs            # Run a git command in every sibling repo
├── feature-today.code-workspace  # Multi-root workspace + shared settings
├── repos.json                  # List of sibling repos
├── package.json                # Cross-repo orchestration scripts
├── AGENTS.md                   # This file (canonical org-wide rules)
├── README.md
└── LICENSE                     # AGPL-3.0-or-later
```

Sibling repos (`.github`, `website`, `my`, `common`, `server`) live **next to** this folder on the host. The devcontainer bind-mounts each of them at `/workspaces/<name>` so the multi-root workspace sees them via `../<name>`.

### What NOT to do here

- Do **not** add runtime code, packages, or build outputs. This repo is configuration only.
- Do **not** duplicate per-repo agent rules — they live in their own `AGENTS.md`.
- When adding a new sibling repo, update `repos.json`, `feature-today.code-workspace`, and `.devcontainer/devcontainer.json` together.

## Repository Links

- Organization: <https://github.com/feature-today>
- Orchestrator: <https://github.com/feature-today/.dev>
- Org config: <https://github.com/feature-today/.github>
- Website: <https://github.com/feature-today/website>
- App: <https://github.com/feature-today/my>
- Common lib: <https://github.com/feature-today/common>
- Server (placeholder): <https://github.com/feature-today/server>

## Inheritance

This document inherits the spirit of [`helpers4/.dev/AGENTS.md`](https://github.com/helpers4/.dev/blob/main/AGENTS.md). Differences:

- License: AGPL-3.0-or-later (instead of LGPL-3.0)
- Framework: Qwik 2 + QwikCity (instead of generic TS lib)
- Linter/formatter: oxlint + oxc-formatter (Prettier dropped for trust reasons)
