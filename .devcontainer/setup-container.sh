#!/usr/bin/env bash
# This file is part of feature-today.
# Copyright (C) 2026 feature-today contributors
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# feature-today orchestrator — devcontainer setup
#
# ───────────────────────────────────────────────────────────────────────────────
# 1. For every sibling repo declared in $FT_REPOS, ensure it exists at
#    /workspaces/<repo>. If the bind-mount target is empty (Codespaces or
#    fresh machine), fall back to `gh repo clone` (or `git clone`).
# 2. Run `pnpm install` on each sibling that has a package.json (best effort).
#
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

if command -v pnpm >/dev/null 2>&1; then
  for repo in $REPOS; do
    target="/workspaces/${repo}"
    if [ -f "${target}/package.json" ]; then
      echo "📦 pnpm install — ${repo}"
      (cd "${target}" && pnpm install --prefer-offline) \
        || echo "⚠️  pnpm install failed in ${repo} (continuing)"
    fi
  done
fi

echo ""
echo "🎉 feature-today orchestrator ready."
echo "   Open feature-today.code-workspace to load every repo at once."
echo "   Try: pnpm run status:all | pull:all | branch:all"
