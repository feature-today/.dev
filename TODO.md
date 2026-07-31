# TODO — Rollout: main / dev/\* / hotfix/\* workflow

One-time migration to the branch/merge model documented in [AGENTS.md](AGENTS.md)'s
"Git Workflow" section. Checked against the real state of every repo on 2026-07-31 —
clean slate (no legacy `dev`/`hotfix` branches anywhere), but zero branch protection
configured yet either. Nothing on GitHub has been changed yet, this is a checklist.

## Current state (as of 2026-07-31)

| Repo | `main` protection | CI triggers on `dev`/`hotfix` |
| --- | --- | --- |
| `.dev` | none | no workflows |
| `.github` | none | no workflows |
| `website` | none | no — CI only runs on `main` |
| `my` | none | no — push CI only runs on `main` (PR CI has no branch filter) |
| `common` | none | no — CI only runs on `main` |
| `server` | none | no workflows yet |

All repos are public and their GitHub default branch is already `main` — no rename needed.

## Per-repo checklist

- [ ] Repo settings → Pull Requests: enable only "Allow rebase merging"; disable "Allow merge commits" and "Allow squash merging".
- [ ] Branch protection rule for `main`: require a PR before merging, no direct pushes, no force-pushes, no deletions.
- [ ] Branch protection rule (or ruleset) for pattern `dev/*`: same restrictions as `main`.
- [ ] Branch protection rule (or ruleset) for pattern `hotfix/*`: same restrictions.
- [ ] Update `website` and `common`'s CI push triggers (currently `branches: [main]` only) to also match `dev/**` and `hotfix/**`.
- [ ] Update `my`'s push trigger (currently `branches: [main]`) the same way.
- [ ] Cut the first `dev/<cycle>` (e.g. `dev/2026-08`) from `main` in every repo.

## Not yet done

Nothing on GitHub (repo settings, branch protection, CI workflows) has been touched for this
rollout — only this org's `AGENTS.md`/`CLAUDE.md` docs are updated so far.
