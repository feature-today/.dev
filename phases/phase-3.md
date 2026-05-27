# Phase 3 — Marketing landing (`website`)

## Goal

Stand up a Qwik 2 landing page at `feature-today.com` (or equivalent), separate from the app.

## Scope

- `website/` scaffold matching `my/`'s tooling (Qwik 2, Vite 7, oxlint, oxc-formatter, Vitest)
- Minimal `/` route with hero + features list
- Consume shared components/types from `@feature-today/common`
- Deploy to Vercel Edge
- Same CI pipeline as `my`

## Checklist

- [x] `website/package.json` with `@feature-today/website` name, full tooling
- [x] `website/tsconfig.json`, `website/vite.config.ts`, `website/vitest.config.ts`, `website/.oxlintrc.json`
- [x] `website/src/{root,routes/index,routes/layout}.tsx` minimal hero
- [x] `website/adapters/vercel-edge/vite.config.ts`
- [x] `website/.github/workflows/pr-checks.yml`
- [x] `website/AGENTS.md`, `README.md`, `LICENSE`, `.vscode/settings.json`
- [ ] Real content (copy, design) — out of scope for this phase

## Verification

```bash
cd website
pnpm install
pnpm dev     # http://localhost:5174
pnpm build
pnpm lint && pnpm typecheck && pnpm test
```

## Status

✅ Scaffold complete; content is iterative.
