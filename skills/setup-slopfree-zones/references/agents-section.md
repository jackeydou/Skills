# AGENTS.md Section Template

Add this section to the project's agent-instruction file. Replace each `<...>` with the project's real value and write the section in the file's language. Keep the three steps, both checks and the final line. They are the parts that make the zones work. Rewording to fit the file's voice is fine.

| Placeholder | Fill with |
| --- | --- |
| `<zones summary>` | One sentence: what goes wrong in these paths, and the groups, named the way the project names them. It must match the group comments in `.slopfree`. |
| `<design location>` | Where designs go: "in the spec (`spec/`) the code belongs to", "in a design doc under `docs/design/`", or "in the PR description". |
| `<default branch>` | `main`, `master`, `develop`, … |
| `<commit convention>` | Usually "in the commit message body". Use the PR/MR description if the project squashes and only the PR text survives. |

````markdown
## Slopfree zones

[`.slopfree`](.slopfree) lists the paths where <zones summary>. Tests next to that code count
too. A change there goes in this order:

1. **Design first.** Write down what changes and why, what it breaks or migrates, how it rolls
   back, and how it is tested, <design location>. No code yet.
2. **Discuss and get approval.** A person explicitly approves that design. An agent that finds
   its task needs a slopfree file stops there and asks; it does not start editing on its own
   reading of the request, however small the change looks.
3. **Change only what was approved.** No edits there that the design does not cover: no
   formatting, renames or "while I'm here" fixes, and no formatter run that touches these files.

Two checks keep it honest:

- **When designing.** Every plan or design names the slopfree files it would touch, under its own
  heading, or says it touches none. A plan that touches one is not ready to build until step 2
  has happened for it.
- **Before every commit.** List the staged files in slopfree zones (git reads the patterns in
  `.slopfree` directly):

  ```bash
  git diff --cached --name-only -- $(grep -vE '^[[:space:]]*(#|$)' .slopfree | sed 's/^/:(glob)/')
  ```

  Nothing listed: commit. Something listed: each file must be covered by an approved design. If
  one is not (a formatter touched it, a stray edit), unstage and revert it instead of committing.
  Otherwise name those files and the design section that approved them <commit convention>.
  For a whole branch, use `git diff --name-only <default branch>...` with the same pathspec.

Adding to or removing from `.slopfree` is itself a decision to discuss first.
````

## Linking existing rules

If the file already has rules that protect a zone, such as "never hand-edit migrations" or "read the auth spec before touching `jwt/`", keep them where they are. They say *how* to change the code, and the zones section says *when* a change may start. Add a short pointer from one to the other only if the connection isn't obvious.

## The design heading

Designs that touch a zone carry a heading such as "Slopfree files touched". Under it, each file gets a line on what changes in it, including files the design expected to change but in the end did not. The heading also says what the design does not touch. A design that touches none says so in one line. A change to `.slopfree` itself is listed there too, with its reason, because it needs the same approval.

```markdown
## Slopfree files touched

- `db/schema.ts`: adds `accounts.kind` and a partial unique index.
- `db/migrations/**`: the migration the generator produced; not hand-edited.
- `src/auth/tokens/refresh.ts`: in the end not changed; the new branch lives in `routes/oauth.ts`.
- `.slopfree`: adds `src/authz/**`, because it issues tokens that act as any signed-in user.

Does not touch `src/crypto/**` or `packages/embed/**`.
```

## Commit message line

When a commit touches a zone, name the files and the approving design section in the body. When it touches none but the reader might wonder, say so in one line:

```text
Slopfree zones touched: db/schema.ts, db/migrations/0016_*.sql (approved in spec/14 "Slopfree files touched").
Slopfree zones touched: none.
```
