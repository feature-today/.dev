# Phase 2 — Modernize `my`

## Goal

Migrate the existing `my` app from Qwik 1.7 / ESLint 8 / Prettier / Vite 5 to the new stack while preserving the project-selector feature and removing all starter boilerplate.

## Scope

- Remove all Qwik starter boilerplate (counter, hero, infobox, next-steps, gauge, icons, header, footer, demo routes)
- Promote project-selector as the home (`/`)
- Replace ESLint+Prettier with oxlint + oxc-formatter
- Add Vitest + coverage
- Upgrade Qwik → 2.x, Vite → 7.x, TypeScript → 5.7+
- Import `Project` type from `@feature-today/common`
- Add `.vscode/settings.json` scopes
- Add `AGENTS.md` and minimal `.github/workflows/` calling org reusable workflows
- Auto-inject AGPL headers on all source files

## Checklist

- [x] Delete `src/components/starter/` (counter, hero, infobox, next-steps, gauge, icons, header, footer)
- [x] Delete `src/routes/demo/` (flower, todolist)
- [x] Delete `.eslintrc.cjs`, `.eslintignore`, `.prettierignore`
- [x] Update `package.json` (new name, scripts, deps, engines)
- [x] Update `tsconfig.json` (strict, bundler, paths)
- [x] Update `vite.config.ts` (Qwik 2, Vitest config)
- [x] Update `adapters/vercel-edge/vite.config.ts`
- [x] Rewrite minimal `layout.tsx`, `root.tsx`, `index.tsx` (project-selector as home)
- [x] Rewrite minimal local `Header` / `Footer`
- [x] Replace `Project` import with `@feature-today/common`
- [x] Add `.oxlintrc.json` + `vitest.config.ts`
- [x] Add `.vscode/settings.json` with scopes
- [x] Add `AGENTS.md`, update `README.md`
- [x] Add `.github/workflows/pr-checks.yml`
- [x] Delete `.history/`
- [x] Add `LICENSE` (AGPL-3.0)
- [x] Inject AGPL headers on every source file

## Verification

```bash
cd my
pnpm install
pnpm typecheck   # 0 error
pnpm lint        # 0 error
pnpm fmt.check   # 0 diff
pnpm test        # passes
pnpm build       # builds SSR + client + edge bundle
pnpm dev         # http://localhost:5173 shows project-selector at /
```

## Status

✅ Complete pending verification.
