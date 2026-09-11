#!/usr/bin/env bash
# This file is part of feature-today.
# Copyright (C) 2026 feature-today contributors
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# feature-today orchestrator — devcontainer setup
#
# ───────────────────────────────────────────────────────────────────────────────
# For every sibling repo declared in $FT_REPOS, ensure it exists at
# /workspaces/<repo>. Each sibling lives on its own named Docker volume; on a
# fresh volume (first-ever run, or after `docker volume rm`) the target is
# empty, so this clones it via `gh repo clone` (or `git clone`). A plain
# container rebuild keeps whatever was already cloned/committed there.
# pnpm install is handled by the package-auto-install feature (autoDiscover).
# ───────────────────────────────────────────────────────────────────────────────
set -euo pipefail

echo "✨ Setting up feature-today orchestrator…"

ORG="${FT_ORG:-feature-today}"
REPOS="${FT_REPOS:-.github website my common server}"

for repo in $REPOS; do
  target="/workspaces/${repo}"
  if [ -d "${target}/.git" ] || [ -f "${target}/package.json" ] || [ -n "$(ls -A "${target}" 2>/dev/null || true)" ]; then
    echo "✓ ${repo}: already present"
    continue
  fi

  echo "→ ${repo}: cloning missing sibling repository"
  rm -rf "${target}" 2>/dev/null || true
  if command -v gh >/dev/null 2>&1; then
    gh repo clone "${ORG}/${repo}" "${target}" || echo "⚠️  ${repo}: clone failed (continuing)"
  else
    git clone "https://github.com/${ORG}/${repo}.git" "${target}" || echo "⚠️  ${repo}: clone failed (continuing)"
  fi
done

echo ""
echo "🎉 feature-today orchestrator ready."
echo "   Open feature-today.code-workspace to load every repo at once."
