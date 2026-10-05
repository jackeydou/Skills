---
name: align-terminology
description: Align project terminology, abbreviations, and internal jargon; maintain a project glossary and its AGENTS.md reference. Use when organizing project vocabulary, revising concept definitions, or clarifying ambiguous project terms in user requests. Ordinary dictionary questions and unambiguous general technical terms do not trigger this skill.
---

# Align Project Terminology

Give each concept a consistent name, definition, and boundary. Record confirmed meanings and explicitly preserve open questions. Do not present guesses as project facts.

## Locate the glossary

- Read the applicable `AGENTS.md` files in the target project. Look for existing terminology documents, glossaries, and references to them. The target project is the one the user is discussing, which may differ from the repository containing this skill.
- Follow the user's chosen location. If the user has not specified one, use `GLOSSARY.md` at the target project's root. Project documentation conventions do not override this default. Tell the user which path you are using.
- Ask the user when the target project is unclear. If an existing glossary is elsewhere, reconcile it with the chosen path and update references rather than maintaining competing glossaries. Preserve a clear, usable existing format and fill in missing information.
- Before creating a glossary or changing its format, read the [terminology format specification](references/terminology-format.md). Keep the glossary in the project; keep the format specification and generic examples in this skill.

## Build the initial vocabulary

When the user requests alignment across the project, examine project overviews, product and architecture documents, interface definitions, data models, key code, and tests. Use `rg` to find candidate terms and their context. Skip dependencies, generated output, and unrelated content.

Cover domain concepts, internal jargon, abbreviations, synonyms, and names used with different meanings. Do not mechanically turn every code identifier into a glossary entry. Record what you examined and what remains uncovered. Work through large projects by scope; do not claim that a limited scan found every term.

Group candidates by concept. A term with an explicit definition and consistent project usage can be marked Confirmed, with a link to that definition. Mark terms supported only by scattered examples or model inference as Pending. When documentation and implementation disagree, record the intended meaning and observed usage separately rather than deciding which represents consensus.

Prioritize conflicts that affect current work or communication across modules. During a bulk inventory, save sourced Pending entries and group the clarification questions. Do not make every term a separate blocking confirmation.

## Clarify ambiguous terms in user requests

First determine whether the ambiguity changes your understanding of the requirement, object, or operation. Use an existing clear definition directly when it fits the context. Clarify project terms only when the ambiguity affects understanding.

1. Check canonical names, aliases, abbreviations, scopes, and Pending entries in the glossary, then search relevant project usage.
2. If the term may refer to an existing concept, give a short definition and the key distinction, then ask whether that is what the user means. For example: “By ‘space,’ do you mean the glossary's ‘workspace’ (a container for team resources), or a container for grouping pages?” If several candidates exist, list only the most relevant ones.
3. If it is a new concept, establish a one-sentence definition, its scope, its distinction from the nearest concept, and a concrete example relevant to the request. Ask about participants, inputs and outputs, or lifecycle only as needed. Do not require the user to fill in every field.
4. Restate your understanding as a definition the user can confirm. If the user has already supplied a clear, complete meaning, no additional confirmation is needed. Otherwise, wait for their answer. Silence is not confirmation. Do not perform work that depends on the unresolved meaning; continue independent work when possible.
5. After confirmation, save the result: add a new name for the same concept as an alias; create an entry for a new concept; update the definition and affected relationships when revising an existing concept, and record substantive changes. Keep same-name concepts in different scopes separate and label their scopes instead of forcing a merge.

Do not insert an unconfirmed interpretation into a Confirmed entry. If the user requests a draft, or you are building a bulk inventory, save it as Pending with a specific open question. Discussion of a possible approach does not mean the concept has been adopted.

## Save changes and connect AGENTS.md

Follow the format specification when saving. Maintain the index, entries, sources, and update dates. Preserve stable concept IDs: renaming does not change an ID, and deprecation keeps the old name and replacement concept so existing links continue to work. Change only the material involved in the current task. Do not automatically rename code in bulk or rewrite unrelated documents.

When first creating the glossary, add or update a short reference in the `AGENTS.md` that covers its intended use. Project-wide glossaries usually belong in the root `AGENTS.md`; subproject glossaries belong in the applicable subproject file. If no applicable file exists, create one at the appropriate scope and preserve any existing instructions supplied by the user.

Use a Markdown path relative to the directory containing `AGENTS.md`. Include the glossary link and these behaviors:

- Consult relevant glossary definitions when interpreting project requirements and prefer Confirmed canonical names.
- For ambiguous terms that affect understanding, compare existing concepts and clarify with the user; maintain the glossary after confirmation.
- Do not treat Pending entries as agreed definitions.

Use the reference example in the format specification if helpful, but substitute the real path. Later, change `AGENTS.md` only when the reference is missing, the path moves, or the behavior needs revision. Avoid duplicate references. When moving the glossary, update project links pointing to its old location.

## Completion checks

Check that new entries do not duplicate concepts, alias conflicts have explicit scopes, Confirmed definitions have supporting evidence, and Pending questions are specific. Verify that index anchors, source links, and the `AGENTS.md` reference resolve to actual targets. Ensure template placeholders have not entered real entries.

Report the glossary path, concepts added or changed, remaining clarification questions, and the location of the `AGENTS.md` reference. Report only the scope actually completed.
