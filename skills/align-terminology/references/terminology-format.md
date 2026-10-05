# Terminology Format Specification

Use this format to create a glossary or add missing definitions and confirmation states to an existing one. Use Markdown. Unless the user specifies a different location, save the glossary as `GLOSSARY.md` at the target project's root. By default, keep one glossary per project. Large glossaries may be split by domain with `GLOSSARY.md` (or the user-selected document) as the index linking them together. Do not create a separate entry for every alias.

## Document structure

Start with the applicable project or module, last updated date, reviewed scope, and areas not yet reviewed. Include a term index and concept entries. Add a short change record when meanings change substantively.

The index supports lookup; maintain definitions only in the entries:

| Canonical name | Aliases / abbreviations | Scope | Status | Entry |
| --- | --- | --- | --- | --- |
| Name | Aliases, or “None” | Project or domain | Confirmed / Pending / Deprecated | Link to stable ID |

## Concept entries

Give each concept an explicit anchor, `<a id="concept-id"></a>`, and link to it as `#concept-id` from the index. Use short IDs containing lowercase English letters, digits, and hyphens. Add a domain prefix to distinguish same-name concepts across domains. Once used, an ID does not change when the concept is renamed.

| Field | Guidance |
| --- | --- |
| Canonical name | Preferred name in current communication; include an English name when it helps locate code |
| Aliases / abbreviations | User phrasing, internal jargon, and abbreviations; write “None” if absent |
| Status | Use only “Confirmed,” “Pending,” or “Deprecated” |
| Scope | Specify the project, business domain, module, or role; do not apply a local definition to the entire project |
| Definition | One or two sentences explaining what it is and what it does; avoid defining a term through itself |
| Boundaries and distinctions | Explain exclusions and differences from easily confused concepts; keep brief if no nearby concept exists |
| Example | A concrete scenario; add a counterexample when the ambiguity concerns boundaries |
| Evidence | Link to a project definition or usage, or record the date and substance of user confirmation |
| Updated | `YYYY-MM-DD`, using the user's date from the current session |

Add fields such as Related concepts, Open questions, or Replacement only when relevant information exists. Do not invent relationships, English names, or confirming people to fill fields.

Status meanings:

- **Confirmed**: Explicitly confirmed by the user, or already explicitly and consistently defined in the project. Code examples or inference alone are insufficient. Conflicting sources require Pending status until resolved.
- **Pending**: No agreed meaning yet. Record candidate meanings, evidence, and the specific question to resolve. Later work must not treat the entry as a settled definition.
- **Deprecated**: The user or project has explicitly stopped using the concept. Preserve its old name, ID, and sources. Identify the replacement, or explain why none exists.

An alias is another name for the same concept. It does not express similarity, containment, or implementation relationships. If the same spelling means different concepts in different domains, keep separate entries and show their scopes in the index. Confirming one meaning does not confirm the other.

Make evidence links relative to the glossary's directory. Prefer links to the defining document or symbol over line numbers that may drift. Record user confirmation as “User confirmed on YYYY-MM-DD: …”; do not fabricate conversation links. Record only the information needed to understand the concept.

## Copyable structure

This is a template for the generated glossary. Replace every value in braces with actual information. Mark unknown information as Pending. Do not treat template examples as real project terms.

```markdown
# Project Terminology

- Scope: {project or module}
- Last updated: {YYYY-MM-DD}
- Reviewed: {documents or modules actually examined}
- Not yet reviewed: {remaining scope; use “None” if the agreed scope is complete}

## Term index

| Canonical name | Aliases / abbreviations | Scope | Status | Entry |
| --- | --- | --- | --- | --- |
| {canonical name} | {aliases} | {scope} | {status} | [Definition](#{concept-id}) |

## Concept entries

<a id="{concept-id}"></a>

### {canonical name}

- Aliases / abbreviations: {aliases or “None”}
- Status: {Confirmed / Pending / Deprecated}
- Scope: {scope}
- Definition: {one-sentence definition}
- Boundaries and distinctions: {boundaries or distinction from nearby concepts}
- Example: {concrete scenario}
- Evidence: {real source link or substance of user confirmation}
- Updated: {YYYY-MM-DD}
```

For Pending entries, add `- Open questions: …`. For Deprecated entries, add `- Replacement: [Name](#stable-id)` when applicable. Record only renaming, merging, splitting, definition changes, and deprecation using “Date / Concept / Change and reason.” Wording corrections do not need a change record. When merging concepts, preserve old ID anchors pointing to the retained entry. When splitting a concept, keep its old entry as a routing point linking to the new entries.

## AGENTS.md reference example

For a root `AGENTS.md` referencing the default project-root `GLOSSARY.md`:

```markdown
## Project terminology

See [Project Terminology](GLOSSARY.md) for definitions. Consult relevant entries when interpreting project requirements and prefer Confirmed canonical names.
For ambiguous terms that affect understanding, check existing concepts and clarify with the user; update the glossary after confirmation. Pending entries are not agreed definitions.
```

This is a relative-path example. If `AGENTS.md` is in a subdirectory, the glossary is elsewhere, or a reference section already exists, adjust the path and merge into the existing section rather than adding duplicate references.
