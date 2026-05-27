# Phase 1 — Shared library (`common`)

## Goal

Stand up `@feature-today/common` as a tree-shakable TypeScript library shared by `website` and `my`.

## Scope

- `common/` repo with Vite lib mode + Vitest
- Initial content: the `Project` type migrated from `my/src/components/select/project-selector/project.model.ts`
- Build produces ESM + `.d.ts`
- Consumed by `my` (and later `website`) via git dependency: `"@feature-today/common": "github:feature-today/common#main"`

## Checklist

- [x] `common/package.json` — `name`, `type`, `exports`, `sideEffects:false`, scripts
- [x] `common/tsconfig.json` strict + Bundler
- [x] `common/vite.config.ts` lib mode + dts plugin
- [x] `common/vitest.config.ts` with coverage thresholds
- [x] `common/.oxlintrc.json`
- [x] `common/src/index.ts` exports
- [x] `common/src/types/project.ts` (`Project` interface, migrated from `my`)
- [x] `common/.github/workflows/pr-checks.yml` — calls reusable ci-node + conventional-commits
- [x] `common/AGENTS.md`, `README.md`, `LICENSE`, `.gitignore`, `.editorconfig`
- [ ] Removed `project.model.ts` from `my` and replaced imports with `@feature-today/common` (done in Phase 2)

## Verification

```bash
cd common
pnpm install
pnpm typecheck   # 0 error
pnpm lint        # 0 error
pnpm test        # passes
pnpm build       # produces dist/ + .d.ts
```

## Status

✅ Scaffold complete.
