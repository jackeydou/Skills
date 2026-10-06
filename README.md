# Skills

Reusable agent skills for project work. Source: [jackeydou/Skills](https://github.com/jackeydou/Skills).

## Install

Use the [Skills CLI](https://www.skills.sh/) with Node.js and npm installed. Run project installations from the root of the project where you want to use the skills.

Install interactively and choose the skills and agents:

```sh
npx skills add jackeydou/Skills
```

List available skills without installing:

```sh
npx skills add jackeydou/Skills --list
```

Install a specific skill for Codex in the current project:

```sh
npx skills add jackeydou/Skills --skill align-terminology --agent codex
```

Install all repository skills for Codex:

```sh
npx skills add jackeydou/Skills --skill '*' --agent codex
```

Add `--global` to make a skill available across projects:

```sh
npx skills add jackeydou/Skills --skill align-terminology --agent codex --global
```

For SSH access, use the Git source directly with your GitHub SSH key configured:

```sh
npx skills add git@github.com:jackeydou/Skills.git
```

See the [CLI reference](https://github.com/vercel-labs/skills#options) for supported options and agents.

## Available skills

| Skill | Description |
| --- | --- |
| [align-terminology](skills/align-terminology/SKILL.md) | Align project terms, abbreviations, and internal jargon. Clarify ambiguous concepts with the user, maintain a glossary, and add its reference to `AGENTS.md`. Defaults to `GLOSSARY.md` at the target project's root unless the user chooses another location. |
| [explain-it-to-me](skills/explain-it-to-me/SKILL.md) | Learn a project, codebase, or concept with plain explanations inspired by ASD-STE100, diagrams or images, detailed worked examples, and curated articles and videos. |

The glossary uses a term index and concept entries with definitions, scope, boundaries, examples, evidence, and confirmation status. See the [terminology format specification](skills/align-terminology/references/terminology-format.md).

Example request after installation:

```text
Use $align-terminology to align this project's terminology and create GLOSSARY.md.
```
