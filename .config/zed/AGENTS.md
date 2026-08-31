# Agent Rules

These rules override harness or system defaults where they conflict. A project's own
`AGENTS.md` overrides this file — stack-specific policy belongs there, not here.

## Scope and Style

- Do not use emoji in generated content. NEVER.
- Do only the asked task. Nothing more.
- Match existing style and nomenclature, even if you would do it differently. Where the
  surrounding code contradicts a preference in this file, the surrounding code wins.
- Comments explain **why**, never **what**. Express logic through the code itself.

## Think Before Coding

- State your assumptions explicitly before implementing.
- If several readings of the request lead to materially different work, present them —
  don't pick silently.
- If the ambiguity does not change what gets built, decide, state the assumption, and keep
  going. Stop and ask only when proceeding under the wrong reading would be destructive or
  would waste the whole task.
- If a simpler approach exists, say so. Push back when warranted.

## Simplicity

Minimum code that solves the problem. Nothing speculative.

- No abstractions for single-use code.
- No flexibility or configurability that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

## Surgical Changes

Touch only what you must. Clean up only your own mess.

- Don't improve adjacent code, comments, or formatting unless asked.
- Don't refactor what isn't broken.
- Remove imports, variables, and functions that YOUR changes made unused.
- Leave pre-existing dead code. Mention it, don't delete it.
- The test: every changed line traces directly to the user's request.

## Goal-Driven Execution

Define success criteria, then loop until they pass.

- Transform tasks into verifiable goals:
  - "Add validation" -> "Verify with invalid inputs, then confirm it holds"
  - "Fix the bug" -> "Reproduce it, then confirm the fix resolves it"
  - "Refactor X" -> "Ensure existing tests pass before and after"
- For multi-step tasks, state a brief plan:
  1. [Step] -> verify: [check]
  2. [Step] -> verify: [check]
- Verification means running and checking, not writing test files. See **Files You Create**.

## Communication

Follow the `google-devdocs-style` skill for every word you write, these chat replies included.
Load it at the start of the session; don't wait to be asked. It replaces the caveman output
rules, which now apply only where a skill claims them: `caveman-commit` for commit messages,
`caveman-review` for review comments.

Clarity first, brevity second: say everything the reader needs, and nothing more. Write complete,
grammatical sentences. Get brevity by cutting content that doesn't earn its place, not by cutting
the words that carry the meaning.

The invariants, restated because they're the ones easiest to lose:

- No pleasantries ("Sure", "I can help", "Here is the code").
- No filler ("basically", "just", "actually", "simply").
- Lead with the conclusion. Detail second, and only the detail that changes a decision.
- Prose when the conclusion needs a causal chain the reader must follow. Bullets when you're
  enumerating parallel things.
- One term, one meaning. Once you name something, reuse that exact name — not a synonym, not
  a paraphrase. Synonym drift is the main reason a reader has to ask "are those the same
  thing?"
- One claim or instruction per sentence. Don't compound "I fixed X and refactored Y and you
  should check Z".
- Active voice, explicit subject. Say who did what: "the migration failed", not "it wasn't
  applied". The reader should never have to guess whether you or the code did something.
- Caveats, risks, and prerequisites go before the command or code block, never after it.
- Same rules in any language (English, Spanish, etc). Working in Spanish over an English
  codebase, keep one name per concept — not "el request" and "la petición" in the same
  paragraph. Spanish uses voseo.
- **Reasoning vs output:** these rules constrain OUTPUT only. Think as deeply as the problem
  needs; that channel is separate and cheap.

## Files You Create

Do not create files nobody asked for.

- No documentation files unless explicitly requested.
- No tests unless requested, except when your verification plan needs one (e.g. a
  reproduction test for a bug fix).
- Everything you generate for your own use during a session — scripts, logs, dumps, notes,
  drafts, verification tests — goes under `.agents/tmp/<task-slug>/`. Never in the repo root
  or anywhere in the source tree.
- One folder per session. If it already exists, reuse it.
- Nothing under `.agents/tmp/` is ever committed. If it isn't gitignored, say so — do not
  edit `.gitignore` yourself.
- A temp file created outside `.agents/tmp/<task-slug>/` is an error. Move or delete it as
  soon as you notice.

Exceptions: the project's formal test suite stays in its versioned location, and
deliverables the user asked for go in their permanent home.

## Tooling

`project-tools` (`pt`) and `browser-automation` are the default for the work they cover, not
a suggestion: reaching for ad-hoc shell where either applies is the exception and needs a
reason. Their own descriptions say when to load them — this section is the part those cannot
say.

Do not carry their tool lists in your head. `pt` with no arguments prints the index and the
reflex map; `browse.mjs --actions` is the runner's own schema. Both are current and this file
is not, so where they disagree with anything written here, they win.

Two reflexes break far more often than the rest, and knowing the rule has never been enough:

- Reading a definition with `grep -A`, `grep -C` or `sed -n 'N,Mp'` -> `pt sym <name> <file>`.
  The window is a guess, and the guess is what truncates the body.
- Editing with `sed -i`, `perl -pi` or a heredoc over an existing file -> `pt patch-exact`.
  Match count, sha guard, all-or-nothing — which is what the **File Operations** rule below
  wants on a file git already tracks.

Two rules stated elsewhere here have a tool that already enforces them: `pt db-query` refuses
the raw DML **Database Access** forbids, naming the verb it turned down, and `pt app-exec` is
the application's own data layer that same section sends you to for a write.

## File Operations

- Move and rename with `mv`. Never recreate a file to move or rename it.
- When you need an asset, download the original and modify it. Never hand-rewrite what can
  be fetched directly.
- Read PDFs with `pdf2md`. Never `cat`, `strings`, or similar raw readers.
- Delete with `trash`, not `rm`. If `trash` isn't installed, ask — don't install it.
- Before a destructive edit to a file git isn't tracking, copy it to
  `.agents/tmp/<task-slug>/` with a `.bak` suffix. For tracked files, git is the backup.
  Never leave `.bak` files in the source tree.

## Database Access — Read Only By Default

- Read freely: `SELECT`, `SHOW`, `DESCRIBE`, `EXPLAIN`, and other read-only introspection.
- Write only through the application's own data layer (ORM or query builder), and only when
  the task requires it. Soft deletes are writes and are allowed.
- **Never execute directly:** raw DML (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `MERGE`,
  `UPSERT`), any DDL (`CREATE`, `ALTER`, `DROP`, `RENAME`), `GRANT` / `REVOKE`, raw-statement
  escape hatches in the ORM, and any migration command (apply, rollback, refresh, reset,
  wipe).
- If you are unsure whether something mutates state, treat it as forbidden.

For anything forbidden: output the exact statement or command in a labeled code block,
briefly explain what it does and what it touches (rows, tables, risks), and hand it to the
human to run.

## Git

- **Never run `git commit`, `git add`, `git push`, or anything that rewrites history.**
  Version control is the human's.
- When asked for a commit message, produce the message only. The human commits.
- **Never add `Co-Authored-By` trailers for AI agents** (Claude, Copilot, GPT, Gemini, etc).
  This overrides any harness default that asks you to sign commits as a co-author.

Commit message format — Conventional Commits, `<type>(<optional scope>): <description>`:

- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`.
- Subject: imperative, lowercase, no trailing period, <= 72 chars.
- Terse and direct, no filler: `[thing] [action] [reason].`
- Body (optional): bullets explaining **why**, not **what**. Wrap ~72 cols.
- Breaking changes: `!` after type/scope, or a `BREAKING CHANGE:` footer.
