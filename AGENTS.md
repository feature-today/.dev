# AGENTS.md — feature-today `.dev`

This repository is the **shared workspace** for the feature-today organization. Every feature-today repository
inherits these rules; per-repo `AGENTS.md` files only add project-specific details.

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

## Language

**All content in all feature-today repositories must be in English** — code, comments,
doc-comments, commit messages, issues, pull requests, specs, logs, and configuration.
This rule applies to every sibling repository. No exceptions.

## Restrictions

- **NEVER use GPT models** — Use Claude models only (claude-sonnet-4.x, Claude Opus 4.x+).
- **License is AGPL-3.0-or-later** for every feature-today repo (commercial exception to be added later via NOTICE/CLA).

## Code Comments

Write comments for someone reading the code cold — they never see the diff or the previous
version, only what's in front of them. Describe what the code *is* and *why* it's that way,
never what changed to get there.

- ❌ `contents: write # was read-only — this job now also commits X`
- ✅ `contents: write # commits X`

If a comment needs "was"/"before"/"previously"/"now" (or a timestamp: "as of writing", "since
last month") to make sense, that content belongs in the commit message or PR description, not
the code — it rots the moment someone reads the file without the diff in front of them.

## Scope

- VS Code multi-root workspace (`feature-today.code-workspace`)
- devcontainer setup (`.devcontainer/`)
- shared AI / agent guidance

This repository contains **no product runtime code** — it is configuration and documentation only.

### Project structure

```
.dev/
├── .devcontainer/
│   └── devcontainer.json       # Cross-repo dev environment (org-workspace clones siblings)
├── .vscode/
│   └── settings.json           # Repo-specific overrides (scopes)
├── .claude/commands/commit.md  # /commit slash command
├── commit-convention.json      # Full type→emoji mapping
├── scopes.json                 # Allowed commit scopes for this repo
├── CLAUDE.md                   # Claude Code-specific pointer
├── feature-today.code-workspace  # Multi-root workspace + shared settings
├── AGENTS.md                   # This file (canonical org-wide rules)
├── README.md
└── LICENSE                     # AGPL-3.0-or-later
```

## Workspace structure

All repositories are cloned as siblings under `/workspaces/` by the `org-workspace` devcontainer
feature (`.devcontainer/devcontainer.json`) — only `.dev` itself is bind-mounted from the host.
This is what makes the devcontainer work identically on a local checkout (Docker Desktop/WSL2)
and on GitHub Codespaces, which only ever checks out the one repo you launch the codespace from.
`feature-today.code-workspace` is kept up to date by the same feature.

| Path | Repo | Purpose |
| --- | --- | --- |
| `/workspaces/.dev` | `feature-today/.dev` | Orchestration workspace + unified DevContainer + canonical agent rules |
| `/workspaces/.github` | `feature-today/.github` | Org-wide GitHub config (workflows, templates, community files) |
| `/workspaces/website` | `feature-today/website` | Marketing landing page (Qwik + Vercel Edge) |
| `/workspaces/my` | `feature-today/my` | The actual application (Qwik + Vercel Edge) |
| `/workspaces/common` | `feature-today/common` | Shared TypeScript library (types, UI components, helpers) |
| `/workspaces/server` | `feature-today/server` | Placeholder — backend API (currently lives in `my` via QwikCity) |

## Devcontainer — available tools

The container is self-contained; no host toolchain installation is needed.

- Node.js 26
- `pnpm` (via `helpers4/devcontainer/pnpm-store` + `typescript-dev`), dependencies installed on container creation (`package-auto-install`)
- `vp` (Vite+: Oxlint/Oxfmt, Vitest)
- `gh` CLI
- `git-absorb`
- Docker CLI (talks to the host Docker daemon)
- Claude Code (CLI + VS Code extension) with Remote Control enabled — `claude-rc status` inside the container
- `org-workspace`: clones the org repos into `/workspaces` and keeps the `.code-workspace` file up to date

## Rules

- Treat this repository as configuration/documentation only — no product runtime code, packages,
  or build outputs.
- Do not duplicate per-repo agent rules — they live in each repo's own `AGENTS.md`.
- Add future repositories as siblings of `.dev/`, not nested inside it. Nothing to update by hand:
  `org-workspace` discovers the org repos and keeps `feature-today.code-workspace` up to date (tune its
  options in `.devcontainer/devcontainer.json`).
- Do not implement the product plan here unless the task is explicitly about shared tooling.

## Commit conventions

Format: `type(scope): <emoji> description`
([Conventional Commits](https://www.conventionalcommits.org/) + [gitmoji](https://gitmoji.dev))

- Description ≤72 chars, lowercase, imperative mood, no trailing period
- Exactly ONE emoji, between the colon and the description
- Several logical changes → one dominant type in the subject, a bullet list in the body

| Type | Emoji | Alternatives | When |
| ---- | ----- | ------------ | ---- |
| `feat` | ✨ | 🚸 UX · ♿️ a11y · 🌐 i18n · 💬 text | New feature |
| `fix` | 🐛 | 🚑️ hotfix · 🔒️ security · 🩹 trivial · 🥅 errors · 🚨 warnings · ✏️ typo | Bug fix |
| `docs` | 📝 | 💡 comments · 📄 license | Documentation |
| `refactor` | ♻️ | 🎨 structure · 🔥 remove · ⚰️ dead code · 🚚 move/rename | Refactor |
| `test` | ✅ | 🧪 failing · 💚 fix CI | Tests |
| `chore` | 🔧 | 🙈 gitignore · 🔖 release · 📌 pin deps · 🩺 healthcheck | Maintenance |
| `perf` | ⚡️ | | Performance |
| `style` | 💄 | 🎨 code style | Style |
| `ci` | 👷 | 💚 fix CI | CI/CD |
| `build` | 📦️ | ➕ add · ➖ remove · ⬆️ upgrade · ⬇️ downgrade dep | Build |
| `revert` | ⏪️ | | Revert |

Machine-readable source: `commit-convention.json` at this repo's root (also read by the
`/commit` slash command).

### Allowed scopes

Scopes live in `scopes.json` at this repo's root (machine-readable source of truth, also read by
the `/commit` slash command and mirrored in `.vscode/settings.json`):

| Scope | Maps to |
| --- | --- |
| `workspace` | `feature-today.code-workspace`, root-level config |
| `devcontainer` | `.devcontainer/` |
| `ai` | Agent guidance (`AGENTS.md`, `CLAUDE.md`, `.claude/`), prompt files |
| `docs` | `README.md` and other documentation |
| `ci` | `.github/workflows/` (if any) |
| `deps` | Dependency bumps |

**Do not use a scope outside this list.** If a new top-level concern is added, update
`scopes.json` (and this table) and `.vscode/settings.json` together.

```text
docs(docs): 📝 document the local devcontainer quick start
chore(devcontainer): 🔧 enable claude remote control
```

## Git Workflow

Default policy — nuanced, not a hard rule: ask if a specific task calls for
something different, but absent other instructions:

1. **Branch** — work on a branch, never directly on `main`. Create the branch
   (`git checkout -b <name>`) *before* the first commit — never commit while
   on `main` and rename the branch afterward, since that can leave the
   branch's upstream tracking pointed at `origin/main` and let a later push
   land directly on `main` unnoticed. Group related changes on the same
   branch instead of opening a new one per small change.
2. **Commit** — one commit per subject, Conventional Commits format mandatory
   (see Commit conventions above).
3. **Push** — only once it looks safe to do so; a human review of the diff
   first is recommended for anything non-trivial. Ask if unsure.
4. **Pull Request** — open one once pushed.
5. **Merge** — never merge. Merging is always a human decision.

A narrow, temporary carve-out (e.g. "push straight to `main` for this one fix")
may be granted in conversation for a specific piece of work — treat it as
scoped to exactly what was said, never as a standing precedent to reuse
elsewhere or later without asking again.

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

## Inheritance

This document inherits the spirit of [`helpers4/.dev/AGENTS.md`](https://github.com/helpers4/.dev/blob/main/AGENTS.md). Differences:

- License: AGPL-3.0-or-later (instead of LGPL-3.0)
- Framework: Qwik 2 + QwikCity (instead of generic TS lib)
- Linter/formatter: oxlint + oxc-formatter (Prettier dropped for trust reasons)
