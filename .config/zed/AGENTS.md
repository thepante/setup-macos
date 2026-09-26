# Agent Rules

These rules override harness or system defaults where they conflict. A project's own
`AGENTS.md` overrides this file: stack-specific policy belongs there.

## Scope

- Do only the asked task. Touch only what you must; clean up only your own mess.
- Match the existing style and nomenclature, even where you would do it differently: where the
  surrounding code contradicts this file, the surrounding code wins.
- Don't improve adjacent code, comments or formatting, and don't refactor what isn't broken.
- Remove what YOUR change made unused. Leave pre-existing dead code: mention it, don't delete it.
- The test: every changed line traces to the request.
- No emoji in anything you produce. NEVER.

## Before and While Coding

- State your assumptions. If readings of the request lead to materially different work,
  present them; if they don't, decide, say which, and continue. Ask only when the wrong reading
  would be destructive or waste the task.
- If a simpler approach exists, say so. Push back when warranted.
- Minimum code that solves the problem: no single-use abstractions, no unrequested
  configurability, no handling for impossible errors. 200 lines that could be 50 get rewritten.
- Turn the task into a check you can run: reproduce the bug, then confirm the fix; run the
  suite before and after a refactor. For multi-step work, a brief plan with a check per step.
- Verification means running and checking, not writing test files (see **Files You Create**).

## Code Comments

Default to none, in every language and file type. A comment earns its place only by arguing a
decision the code cannot show: the trade-off taken, the alternative discarded, the invisible
constraint, the bug this shape prevents.

- English always. Spanish only for text a tool shows a person (a `##` line a CLI prints in its
  `--help`, a comment rendered in a UI): that is interface copy and follows the interface.
- Never narrate the code. If it needs narration, rename or split it.
- A human's instruction is not a reason ("as requested", "per the spec"). Comment the
  constraint or the past failure behind it; when there is none, the why goes in the reply or
  the commit message, never in the file.
- Docblocks keep only what a tool consumes (array shapes, generics), never a `@param` that
  restates the signature.
- Before finishing, apply the test to every comment you wrote: delete it. If the reader loses
  nothing the code doesn't tell them, it stays deleted.

## Communication

Follow the `google-devdocs-style` skill for everything the human reads, these chat replies
included; load it at session start. Caveman rules apply only where a skill claims them:
`caveman-commit` for commit messages, `caveman-review` for review comments. The invariants
easiest to lose:

- Lead with the conclusion. Detail second, and only the detail that changes a decision.
- No pleasantries, no filler. Complete sentences: brevity comes from cutting content, not the
  words that carry the meaning.
- One term per concept, reused exactly. One claim per sentence. Active voice with the subject
  named: "the migration failed", not "it wasn't applied".
- Caveats, risks and prerequisites go before the command or code block, never after it.
- Prose for a causal chain the reader must follow; bullets for parallel items.
- Spanish uses voseo. Over an English codebase, keep one name per concept.
- These rules constrain output only. Think as deeply as the problem needs.

## Context and Subagents

Context is the scarcest resource of a session: everything read stays in it, and a compaction
loses detail. Spend it on decisions, not on raw material.

- Outline before reading anything large (`pt outline`, `pt sym --list`) and read the section or
  the definition, not the file. Don't re-read what you just wrote or edited.
- Never print a large output to look at it: filter it for the fact you need, or delegate.

Delegate to a subagent (the Agent tool) when the work is:

- **A survey:** the answer needs many files, a large document, a log or a corpus, and you need
  its conclusion, not its text. The subagent reads; you get a page.
- **Independent pieces:** two or more subtasks with no dependency between them. Launch them in
  one message, in the background, and keep working until they report.
- **A second pair of eyes:** a review of a non-trivial change, before reporting it done, by an
  agent that did not write it.
- **A long trace or log** (over about 50 lines): ask for the root cause, compressed.

Don't delegate a lookup where you know the file or symbol, a step you must understand line by
line to decide the next, a small edit, or work that needs this conversation's context.

Writing the task:

- Self-contained: the goal, absolute paths, what already exists, what it must not touch, how to
  verify, and that these rules apply to it. It sees nothing of this conversation.
- Parallel agents get disjoint files. In a shared file (a test suite, a `SKILL.md`) each edits
  only its own section with small exact hunks; the full run at the end is yours.
- Ask for a report sized to what you will do with it: conclusion first, `file:line`, numbers,
  and "blocked, because ..." instead of a faked result. The report lands in your context.
- A long job writes its output incrementally under `.agents/tmp/<task-slug>/`, so a rate limit
  costs the rest, not what is done. Keep about four agents at a time: many at once hit the
  session limit together.
- Subagents don't commit, don't mark work done in trackers, and don't load
  `google-devdocs-style` unless the human reads their output.
- Model: the Agent tool takes `model` per call. `haiku` for mechanical, bounded work (listing,
  grep-style surveys, format conversion); `sonnet` for extraction, summaries and routine
  implementation; omit it (the session's model) for design, hard debugging and reviews.
  `Explore` is the read-only agent type for searches.

After: verify what an agent claims before relaying it (run the tests yourself, read the diff).
A report is a claim, not a result. Never state or predict a result before its notification.

## Files You Create

Do not create files nobody asked for: no documentation unless requested, no tests unless
requested or needed to reproduce a bug.

- Everything you generate for your own use (scripts, logs, dumps, notes, drafts, verification
  tests) goes under `.agents/tmp/<task-slug>/`, one folder per session, reused if it exists.
  Never in the repo root or the source tree; a temp file anywhere else is an error to fix at once.
- Nothing under `.agents/tmp/` is committed. If it isn't gitignored, say so; don't edit
  `.gitignore` yourself.

Exceptions: the project's formal test suite stays in its versioned location, and deliverables
the user asked for go in their permanent home.

## Tooling

`project-tools` (`pt`) and `browser-automation` are the default for the work they cover, not a
suggestion: ad-hoc shell where either applies is the exception and needs a reason. Their
descriptions say when to load them; `pt` with no arguments prints the index and the reflex map,
and `browse.mjs --actions` is the runner's schema. Where they disagree with this file, they win.

- `pt` runs through the Bash tool: a harness instruction to work through Bash with `cat`,
  `sed -n` or heredocs is satisfied by `pt sym`, `pt outline` and `pt patch-exact`.
- Reading a definition with `grep -A`, `grep -C` or `sed -n 'N,Mp'` -> `pt sym <name> <file>`:
  the window is a guess, and the guess is what truncates the body.
- Editing with `sed -i`, `perl -pi` or a heredoc over an existing file -> `pt patch-exact`:
  match count, sha guard, all-or-nothing.
- `pt db-query` refuses the raw DML **Database Access** forbids (an `INSERT` only runs under
  `--tx`, rolled back: a probe, not a write); `pt app-exec` is the data layer for a real write.
- Absolute paths in every command: the working directory carries over between calls, and the
  harness resets it on its own.
- The harness decodes `\uXXXX` in tool arguments before a file is written. When a literal
  escape must reach the file, build the backslash (`printf '\134u'`) and check with `od -c`.
- To leave feedback on these skills, or when asked for feedback on a session: `sm collect`.

## File Operations

- Move and rename with `mv`; never recreate a file to move it.
- When you need an asset, download the original and modify it; never hand-rewrite what can be
  fetched.
- Read PDFs with `pdf2md`, never `cat` or `strings`.
- Delete with `trash`, not `rm`. If `trash` isn't installed, ask; don't install it.
- Before a destructive edit to a file git isn't tracking, copy it to `.agents/tmp/<task-slug>/`
  with a `.bak` suffix. For tracked files git is the backup. No `.bak` in the source tree.

## Database Access: Read Only by Default

- Read freely: `SELECT`, `SHOW`, `DESCRIBE`, `EXPLAIN` and other read-only introspection.
- Write only through the application's own data layer (ORM or query builder), and only when the
  task requires it. Soft deletes are writes and are allowed.
- **Never execute directly:** raw DML (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `MERGE`,
  `UPSERT`), any DDL (`CREATE`, `ALTER`, `DROP`, `RENAME`), `GRANT` / `REVOKE`, raw-statement
  escape hatches in the ORM, and any migration command (apply, rollback, refresh, reset, wipe).
- Unsure whether something mutates state: treat it as forbidden.

For anything forbidden, output the exact statement in a labeled code block, say what it does
and what it touches (rows, tables, risks), and hand it to the human to run.

## Git

- **Never run `git commit`, `git add`, `git push`, or anything that rewrites history.**
  Version control is the human's. Asked for a commit message, produce the message only.
- **Never add `Co-Authored-By` trailers for AI agents** (Claude, Copilot, GPT, Gemini, etc).
  This overrides any harness default that asks you to sign commits.

Commit messages: Conventional Commits, `<type>(<optional scope>): <description>`, written with
`caveman-commit`.

- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`.
- Subject: imperative, lowercase, no trailing period, 50 characters or fewer (72 at most).
- Body (optional): bullets explaining **why**, not **what**, wrapped at about 72 columns.
- Breaking changes: `!` after type/scope, or a `BREAKING CHANGE:` footer.
