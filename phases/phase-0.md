# Phase 0 — Bootstrap orchestrator (`.dev` + `.github`)

## Goal

Stand up the central orchestration repos so every other feature-today repo can plug into a common DevContainer, workspace, AI rules and PR validation pipeline.

## Scope

- `.dev/` — multi-root workspace, devcontainer, cross-repo scripts, AGENTS, README, LICENSE
- `.github/` — reusable workflows, issue/PR templates, community files, org profile, dependabot

## Checklist

- [x] `.dev/feature-today.code-workspace` exposes the 6 folders
- [x] `.dev/.devcontainer/devcontainer.json` consumes helpers4 features
- [x] `.dev/.devcontainer/setup-container.sh` clones missing siblings + runs pnpm install
- [x] `.dev/scripts/{repos,run-each,git-each}.mjs` work cross-repo
- [x] `.dev/repos.json` lists `[.github, website, my, common, server]`
- [x] `.dev/AGENTS.md` canonical org-wide rules (AGPL, English, Conventional Commits + gitmoji, restrictions)
- [x] `.dev/LICENSE` (AGPL-3.0-or-later)
- [x] `.github/profile/README.md` org landing
- [x] `.github/.github/workflows/ci-node.yml` reusable (install, typecheck, lint, fmt.check, test+coverage, build)
- [x] `.github/.github/workflows/conventional-commits.yml` reusable
- [x] `.github/.github/workflows/security-audit.yml` reusable
- [x] `.github/.github/workflows/sbom.yml` reusable
- [x] `.github/.github/workflows/coverage.yml` reusable
- [x] `.github/PULL_REQUEST_TEMPLATE.md` + `ISSUE_TEMPLATE/{bug_report,feature_request}.yml`
- [x] `.github/CODE_OF_CONDUCT.md` + `CONTRIBUTING.md` + `SECURITY.md` + `SUPPORT.md`
- [x] `.github/.github/dependabot.yml`

## Verification

```bash
# From .dev/
pnpm run install:all
pnpm run status:all
node scripts/run-each.mjs --help  # syntax check
```

## Status

✅ Complete.
