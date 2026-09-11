# AGENTS.md — feature-today organization (canonical)

This is the **canonical, org-wide** agent guidance for the feature-today organization.
Every feature-today repository inherits these rules. Per-repo `AGENTS.md` files only add
project-specific details (scopes, structure, commands) on top of what is defined here.

## ⛔ CRITICAL RESTRICTIONS

- **Git workflow** — branch, commit, push, and PR per the default policy in
  [Git Workflow](#git-workflow) below; never merge (see that section).
- **Everything in English** — Code, comments, commits, documentation, logs, PR descriptions.
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

## Git Workflow

feature-today ships to production, so branches go through an intermediate stage before `main`.
Every merge is **rebase + fast-forward only** — no merge commits, no squash merges, anywhere.

**Branches:**

| Branch | Purpose | Lifetime |
| --- | --- | --- |
| `main` | Production | Permanent |
| `dev/*` (e.g. `dev/2026-08`) | Internal/staging release train | One per cycle — deleted after merging into `main` |
| `hotfix/*` | Urgent production fix, bypasses `dev/*` | One per fix — deleted after merging into `main` |
| `feat/*`, `bug/*` | Regular work | One per change — deleted after merging into the current `dev/*` |

**Merging (always via PR, never a direct push to `main` or `dev/*`):**

- `feat/*` / `bug/*` → rebase onto the current `dev/*` tip, then fast-forward merge into `dev/*`.
- `dev/*` → rebase onto `main`'s tip, then fast-forward merge into `main`.
- `hotfix/*` → branched from `main`, rebase onto `main`'s tip, then fast-forward merge into `main`.
- If a `hotfix/*` lands on `main` while a `dev/*` is still in flight, rebase that `dev/*` onto the
  new `main` before its own merge — fast-forward tolerates no divergence.
- Releases are tracked with **tags on `main`** (there's no merge commit to mark them, since every
  merge is a fast-forward).

The agent never merges — not even a fast-forward merge. Push a branch and open the PR; a human
merges it. A narrow, temporary carve-out (e.g. "push straight to `main` for this one fix") may be
granted in conversation for a specific piece of work — treat it as scoped to exactly what was
said, never as a standing precedent to reuse elsewhere or later without asking again.

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
│   ├── devcontainer.json       # Named Docker volume per sibling + postCreateCommand
│   └── setup-container.sh      # postCreateCommand: clone-into-volume-if-empty
├── .vscode/
│   └── settings.json           # Repo-specific overrides (scopes)
├── feature-today.code-workspace  # Multi-root workspace + shared settings
├── AGENTS.md                   # This file (canonical org-wide rules)
├── README.md
└── LICENSE                     # AGPL-3.0-or-later
```

Sibling repos (`.github`, `website`, `my`, `common`, `server`) each live on their own named
Docker volume, cloned into place by `setup-container.sh` on first run (empty volume) — not
bind-mounted from the host, so this works identically on GitHub Codespaces and local Docker
Desktop/WSL2. The multi-root workspace sees them via `../<name>` inside the container.

### What NOT to do here

- Do **not** add runtime code, packages, or build outputs. This repo is configuration only.
- Do **not** duplicate per-repo agent rules — they live in their own `AGENTS.md`.
- When adding a new sibling repo, update `FT_REPOS` in `.devcontainer/devcontainer.json`,
  its `mounts` entry, and `feature-today.code-workspace` together.

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
- Orchestration: sibling repos clone into named Docker volumes via
  `postCreateCommand` (matching `brig-id/roots`/`tuxery/.dev`), not the
  `repos.json`+`scripts/`+`package.json` layer this repo used to have
- `phases/*.md` tracks implementation phases across the org — no equivalent in helpers4
