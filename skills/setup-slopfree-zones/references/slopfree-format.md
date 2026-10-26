# `.slopfree` File Format

`.slopfree` lives at the repository root. Git reads it directly: the commit check turns each line into a `:(glob)` pathspec, so the file needs no tool of its own.

## Rules

- One pattern per line, relative to the repository root, with no leading `/` or `./`.
- Patterns are git glob pathspecs (`:(glob)` magic). `*` matches within one path segment. `**` matches across segments. `?` and `[...]` work as usual. `dir/**` matches everything under `dir`.
- No whitespace inside a pattern. The commit check splits on whitespace.
- No negation. Git's `:(exclude)` exists, but a zone with holes in it is hard to reason about. Narrow the pattern instead.
- A line that starts with `#` is a comment. Blank lines are ignored.
- At least one pattern. With none, the commit check passes no pathspec, and git lists every staged file.
- Every pattern matches at least one tracked file when it is written. `scripts/match-zones.sh` checks this.

## Layout

A header says what the file is and points to `AGENTS.md`. Then one group per category. Each group starts with a comment that names what goes wrong there, in the project's terms (see [choosing zones](choosing-zones.md#writing-the-reason)).

```gitignore
# Slopfree zones. A change to any path here needs a written design and a person's explicit
# approval before the first edit; see "Slopfree zones" in AGENTS.md.
#
# One git glob pathspec per line, relative to the repo root: `*` matches within a path
# segment, `**` across segments. AGENTS.md has the command that checks staged files against it.

# Data and migrations. Migrations run by themselves at boot against the production database,
# with no down migration; the connection module is how every request reaches the database.
db/schema*.ts
db/migrations/**
db/client*.ts

# Credentials and encryption. A mistake makes every stored token unreadable or leaks one.
src/crypto/**
src/auth/tokens/**
src/log.ts

# SDKs that run in pages and scripts we do not control.
packages/embed/**
```

## Checking it

```bash
scripts/match-zones.sh -C <project>          # every pattern in .slopfree, with matched files
git -C <project> ls-files -- ':(glob)src/auth/**'   # one pattern by hand
```
