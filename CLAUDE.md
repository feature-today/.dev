# Claude Code — feature-today workspace

Full org-wide rules (commit format, license headers, git restrictions, stack
conventions) live in [AGENTS.md](AGENTS.md). This file adds Claude Code-specific
context.

## Workspace layout

All repos are bind-mounted at `/workspaces/<name>` and open together in
`feature-today.code-workspace`:

| Path | Repo | Role |
| ---- | ---- | ---- |
| `/workspaces/.dev` | `.dev` | Orchestration — canonical AGENTS.md, devcontainer, scripts |
| `/workspaces/.github` | `.github` | Org-wide GitHub config (workflows, templates) |
| `/workspaces/website` | `website` | Marketing landing page (Qwik + Vercel Edge) |
| `/workspaces/my` | `my` | The application (Qwik + Vercel Edge) |
| `/workspaces/common` | `common` | Shared TypeScript library |
| `/workspaces/server` | `server` | Placeholder — backend API (currently in `my` via QwikCity) |

## Cross-repo commands (run from `/workspaces/.dev`)

```bash
pnpm run status:all   # git status -sb in every repo
pnpm run fetch:all    # git fetch --all --prune in every repo
pnpm run pull:all     # git pull --rebase in every repo
pnpm run branch:all   # show active branch in every repo
pnpm run build:all    # pnpm build in every repo
pnpm run test:all     # pnpm test in every repo
```

## Common gotchas

**Commit scopes**: always read `scopes.json` at the active repo root before choosing a scope.
Never invent a scope that isn't listed. Full type→emoji mapping: `/workspaces/.dev/commit-convention.json`.
Use `/commit` (Claude Code slash command) to auto-generate a message from staged changes.

**Linting/formatting**: this org uses **oxlint**, not ESLint, and **oxc-formatter**
(`oxlint --fix`), not Prettier — see AGENTS.md's Stack Conventions. Don't suggest ESLint/Prettier
configs or commands.

**License header**: every new source file needs the AGPL-3.0-or-later header — see AGENTS.md for
the exact comment syntax per language (TS/JS vs Bash).

**pnpm install on rebuild**: handled by the `package-auto-install` devcontainer feature with
`autoDiscover` (parses `feature-today.code-workspace`), not by a manual loop in
`setup-container.sh` — same approach as helpers4.

**Phase tracking**: `phases/*.md` tracks implementation phases across the org — read the
relevant phase file before starting product work.

**Git workflow**: `main` and `dev/*` are protected — never push directly. Branch from `dev/*`
(`feat/*`/`bug/*`) or from `main` for an urgent prod fix (`hotfix/*`). Every merge is rebase +
fast-forward only — rebase onto the target's tip before merging, no merge commits, no squash.
See AGENTS.md's Git Workflow section.

## AI persistence

`~/.claude` is bind-mounted from the host and symlinked at every container start by
`claude-dev`. Memory, credentials, and settings survive all rebuilds.
