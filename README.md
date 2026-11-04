<h1 align="center">feature-today — .dev</h1>

<p align="center">
 <strong>Orchestration workspace for the feature-today organization. One devcontainer to rule them all.</strong>
</p>

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/badge/license-AGPL--3.0--or--later-blue" alt="license" /></a>
</p>

---

## Overview

This repository is the **central orchestrator** for all feature-today projects. It hosts:

- A unified [VS Code multi-root workspace](./feature-today.code-workspace) opening every sibling repo at once
- A single [DevContainer](./.devcontainer/devcontainer.json) configured for cross-repo development
- The [canonical AGENTS.md](./AGENTS.md) shared by every feature-today repo (Copilot / AI agents)
- Shared VS Code settings inherited by every folder in the workspace

It does **not** ship runtime code, packages, or actions. Each feature-today project lives in its own repo.

## Repository Layout

This repo is meant to be cloned **alongside** the other feature-today repos in a common parent directory:

```
feature-today/
├── .dev/         ← this repo (open feature-today.code-workspace)
├── .github/      ← org-wide GitHub config
├── website/      ← marketing landing (Qwik + Vercel Edge)
├── my/           ← the actual app (Qwik + Vercel Edge)
├── common/       ← shared TS lib (@feature-today/common)
└── server/       ← backend placeholder (TBD)
```

## Quick Start

### 1. Clone everything into a single parent

```bash
mkdir feature-today && cd feature-today
gh repo clone feature-today/.dev
gh repo clone feature-today/.github
gh repo clone feature-today/website
gh repo clone feature-today/my
gh repo clone feature-today/common
gh repo clone feature-today/server
```

### 2. Open the multi-root workspace

```bash
code .dev/feature-today.code-workspace
```

### 3. (Optional) Reopen in DevContainer

When prompted, *Reopen in Container* — or run **Dev Containers: Reopen in Container** from the command palette. The container:

- bind-mounts `.dev/` at `/workspaces/.dev`
- clones the org repos at `/workspaces/<name>` (`org-workspace` feature)
- runs `pnpm install` in every sibling that has a `package.json` (`package-auto-install` feature)

## Stack

- **Runtime**: Node.js ≥ 24, pnpm (latest)
- **Framework**: Qwik 2 + QwikCity
- **Bundler**: Vite 7+
- **Tooling**: oxlint + oxc-formatter (NOT ESLint/Prettier), Vitest
- **TS helpers**: prefer `@helpers4/*`
- **Deployment**: Vercel Edge (for `my` and `website`)

## License

[AGPL-3.0-or-later](./LICENSE). See [LICENSING.md](./LICENSING.md) for the org-wide licensing policy (what it allows, what it requires, FAQ).
