# Licensing policy

All [feature-today](https://github.com/feature-today) source code is released under the **GNU Affero General Public License v3.0 or later** ([AGPL-3.0-or-later](https://www.gnu.org/licenses/agpl-3.0.html)).

This document explains what this means in practice, what you can do, and what we expect from contributors.

## TL;DR

- ✅ **Use it for anything, including commercial purposes.**
- ✅ **Self-host it, modify it, redistribute it.**
- ❗ **If you run a modified version as a service (SaaS) or distribute it, you must publish your source code under the same AGPL-3.0-or-later license.**
- ❌ **You cannot relicense it under a proprietary or non-copyleft license.**

If those constraints fit your project, you don't need to ask us anything — just follow the AGPL terms.

## Why AGPL?

AGPL is a strong copyleft license. We picked it deliberately because:

1. We believe the people who depend on the service we build should always be able to study, audit, fork and improve it.
2. We want to protect the project from a closed-source rehost (the « AWS clone » scenario): anyone is welcome to host their own copy, but they have to share their improvements back, under the same terms.
3. It keeps a single set of rules across the org and avoids licensing fragmentation.

## What AGPL allows

- **Commercial use** is explicitly permitted (GPL/AGPL « freedom 0 »). You can sell access, charge for support, run paid features on top of it, etc.
- **Self-hosting** is permitted, with or without modifications.
- **Forking** is permitted on GitHub or anywhere else.
- **Internal use** (inside a company, not exposed to third parties) does not trigger redistribution duties.

## What AGPL requires

When you **distribute** the software, **or make a modified version available over a network** (the AGPL « network use is distribution » clause):

1. You must publish the **complete corresponding source code** of the version you run, under AGPL-3.0-or-later.
2. You must **preserve copyright and license notices**, including the SPDX header at the top of each source file:
   ```
   This file is part of feature-today.
   Copyright (C) <year> feature-today contributors
   SPDX-License-Identifier: AGPL-3.0-or-later
   ```
3. You must clearly **indicate modifications** you made.
4. You cannot add additional restrictions (no « commercial use forbidden » riders, no anti-competition clauses, etc.).

The full text of the license is shipped in every repository as the [`LICENSE`](./LICENSE) file. In case of any doubt, the AGPL text wins over this summary.

## Combining feature-today code with other code

| Other code license | Can you combine it with feature-today code? |
|---|---|
| AGPL-3.0-or-later | ✅ Yes |
| GPL-3.0-or-later | ✅ Yes, the combined work is AGPL-3.0-or-later |
| LGPL-3.0-or-later | ✅ Yes |
| Apache-2.0, MIT, BSD, ISC, MPL-2.0 | ✅ Yes, but the combined distributable work as a whole is AGPL-3.0-or-later |
| Proprietary / closed source | ❌ Not as a single combined work shipped or served together |

> Note: « combined work » here covers static linking, dynamic linking, npm `import`/`require`, server-side bundling, container images, etc. — anything that ends up running together.

## Trademarks

The AGPL covers source code, not branding. The names **feature-today** and any associated logos remain trademarks of the project maintainers. You are free to fork the code, but please **rename** your fork so that users are not misled about who is responsible for the service they are using.

## Commercial / dual-licensing

The project is **not** dual-licensed at the moment. There is **no proprietary alternative license** offered. If you need terms different from AGPL-3.0-or-later (for example to integrate the code into a closed-source product), contact the maintainers — but assume the answer is « please stay on AGPL » unless we say otherwise in writing.

To keep that option open in the future, contributors are expected to retain ownership of their contributions and accept that the project may, by collective agreement of the maintainers, offer the same code under additional terms. This is documented through the contribution policy in [AGENTS.md](https://github.com/feature-today/.dev/blob/main/AGENTS.md) and any future `CONTRIBUTING.md`.

## Per-repository scope

This policy applies to **every repository under the [`feature-today` GitHub organization](https://github.com/feature-today)** that ships a `LICENSE` file with the AGPL-3.0 text:

- [`feature-today/.dev`](https://github.com/feature-today/.dev) — workspace and scripts
- [`feature-today/.github`](https://github.com/feature-today/.github) — reusable workflows and templates
- [`feature-today/common`](https://github.com/feature-today/common) — shared TypeScript types and UI
- [`feature-today/server`](https://github.com/feature-today/server) — backend (placeholder)
- [`feature-today/website`](https://github.com/feature-today/website) — landing site
- [`feature-today/my`](https://github.com/feature-today/my) — main app

If a repository ever ships under a different license (for example a small library we deliberately want under MIT to be reusable in proprietary projects), it will state so explicitly in its own `README.md` and `LICENSE` files.

## Questions

For any licensing question that this document does not answer, open an issue on [`feature-today/.dev`](https://github.com/feature-today/.dev/issues) with the `licensing` label.
