---
name: setup-slopfree-zones
description: Set up or revise a project's slopfree zones, the paths where a wrong change loses data, breaks or leaks credentials, or breaks code the project does not control. Survey the project, recommend paths, get the user's confirmation, then write `.slopfree` and the "Slopfree zones" section of `AGENTS.md`. That section says how agents work there: design first, get a person's approval, change only what was approved, and check staged files before every commit. Use when the user asks to protect risky paths from agent edits, mark files as needing approval, or add or remove a slopfree zone. Ordinary code review and permission settings do not trigger this skill.
---

# Set Up Slopfree Zones

A slopfree zone is a path where a careless change can't be taken back cheaply: it loses data, makes stored secrets unreadable or leaks them, or breaks a caller the project does not control. The setup has two parts. `.slopfree` at the project root lists the zones as git glob pathspecs. The "Slopfree zones" section of `AGENTS.md` gives the order of work there (design, approval, change only what was approved) and the checks that enforce it.

Recommend zones; never decide them. The user confirms the list before anything is written.

## Find the target and what exists

- Find the target project. It is the one the user is discussing, which may not be the repository that holds this skill. If it is unclear, ask. It must be a git repository, because the checks use git pathspecs.
- Read every agent-instruction file that applies: `AGENTS.md`, `CLAUDE.md` and any files they import or link. Write to the file agents already read. If both exist and neither imports the other, ask which one to use.
- Read any existing `.slopfree` and "Slopfree zones" section. If they exist, this is a revision (see [Revise existing zones](#revise-existing-zones)), not a fresh setup.
- Find where the project writes designs: `spec/`, `docs/design/`, `rfcs/`, ADRs, or a convention stated in `AGENTS.md`. Step 1 of the workflow points there. If there is none, ask the user. Offer a design-doc directory or the PR/MR description as the options. Do not invent a directory silently.
- Note the default branch (`git symbolic-ref refs/remotes/origin/HEAD`, or ask) for the whole-branch check.

## Survey for candidates

Read the project overview, architecture docs, the data layer, auth and secret handling, the packages that ship to other people, deploy config, and `AGENTS.md` rules that already say "never" or "do not". Use `rg` and `git ls-files` instead of guessing from directory names. Skip dependencies and generated output, except generated output that must never be regenerated (migrations).

Use the categories and the inclusion test in [choosing zones](references/choosing-zones.md). Each candidate needs:

- a git glob pattern, as narrow as possible (`packages/db/src/schema*.ts`, not `packages/db/**`);
- one concrete failure, in the project's own terms: what breaks, for whom, and why it is hard to undo;
- evidence: the file or doc that shows it (a migration runner at boot, an `encrypt` call, a package published to npm);
- a recommendation: **recommended** or **optional**, plus the paths you considered and left out, with the reason for each.

Check every candidate pattern with [`scripts/match-zones.sh`](scripts/match-zones.sh) before you show it. It prints the tracked files each pattern matches and flags a pattern that matches nothing:

```bash
printf '%s\n' 'packages/db/src/schema*.ts' 'apps/api/src/auth/**' | scripts/match-zones.sh -C <project> -
```

Keep the list short. Zones that cover half the repository get ignored. If most of a package qualifies, ask whether the whole package is the zone.

## Confirm with the user

Show the candidates grouped by category: pattern, matched-file count, the failure, and recommended or optional. Then ask the user to confirm, drop or edit items, or add paths of their own. Also confirm the design location and the instruction file you will write to.

- **If the agent can show an interactive view** (an inline widget, an HTML artifact, a canvas or similar), use a checklist: one row per candidate, recommended rows checked by default, an "add a path" field, the matched files expandable per row, and a submit control that sends the final selection back as a chat message. If the view can't send a message, it shows the selection as text that the user pastes back.
- **Otherwise**, use a numbered Markdown table. Ask the user to reply with the numbers to keep, or "all recommended", plus any additions.

Only the user's reply in chat confirms the list. A view's default state, or no reply, does not. Write nothing until it arrives. Run every path the user adds through `match-zones.sh`, and say so if it matches nothing.

## Write `.slopfree` and `AGENTS.md`

1. Write `.slopfree` in the [file format](references/slopfree-format.md): a header comment, then one group per category. Each group starts with a comment saying what goes wrong there. Use only the confirmed patterns.
2. Add the section from the [AGENTS.md section template](references/agents-section.md) to the chosen instruction file. Fill in the zones summary, the design location, the default branch and the project's commit-message convention. Write the section in the language of the rest of the file. Place it near the project's other "before you touch code" rules. Do not rewrite unrelated sections. If another rule already covers one zone (for example "never hand-edit migrations"), keep that rule and link the two.
3. Run `scripts/match-zones.sh -C <project>` on the written file. It must exit 0. Then run the commit check from the section once in the project. With nothing staged it prints nothing.
4. If the project has a design-doc convention, tell the user that from now on each design should include a "Slopfree files touched" heading. Do not backfill old designs unless asked.

Do not install git hooks, CI jobs or editor permission rules unless the user asks. The checks run as agent instructions, so the setup keeps working in any client.

## Revise existing zones

Adding a zone, removing one or widening a pattern is a slopfree decision in its own right. Treat it that way:

- Show the change as a diff against the current `.slopfree`, with the same evidence and failure for each line, and the matched-file count before and after.
- If the project writes designs, the change belongs in the design that prompted it, under its "Slopfree files touched" heading (`.slopfree` itself is listed there). Otherwise, describe it in chat.
- Wait for the user's explicit approval, then change exactly that. Update the zones summary in `AGENTS.md` when the categories change.
- Leave `.slopfree` alone when a design needs a slopfree file but not a change to the zones. That is the normal workflow, not a revision.

## Completion checks

- Every pattern in `.slopfree` matches at least one tracked file. None contains whitespace. The file has at least one pattern, because with none the commit check lists every staged file.
- The `AGENTS.md` section links `.slopfree`. Its summary matches the categories in the file. Its design location and default branch are real.
- No other content in the instruction file changed.

Report the zones written (pattern and file count), the candidates the user dropped, the instruction file and section changed, and anything still open, such as a design location to settle.
