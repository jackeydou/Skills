---
name: explain-it-to-me
description: Help users understand and learn a project, codebase, or concept through plain explanations, diagrams or images, worked examples, and curated web articles and videos. Use for teaching requests, project walkthroughs, and explanations of how or why something works. Simple fact lookups do not need this workflow.
---

# Explain It To Me

Build an explanation the user can use to reason about the subject. Combine clear writing, useful visuals, detailed examples, and verified learning resources. Match the depth to the user's question and background.

## Establish the learning target

Use the conversation to identify the subject, what the user wants to understand, and what they already know. Ask a short question only if missing context would materially change the explanation. Otherwise, state a reasonable assumption and begin. Use the user's language unless they request another language.

For a large subject, give a map of the whole and teach the part most relevant to the user's goal. Introduce prerequisites where they become necessary. Do not require an intake questionnaire or cover every subsystem before answering.

## Ground the explanation

For a project, read its applicable instructions, overview, and relevant source files. Trace one concrete behavior from its entry point through the main components to its output. Use tests and configuration to resolve questions that the overview cannot answer. Link important claims to actual files and symbols. State which part you examined; distinguish documented intent, observed implementation, and inference. Do not invent architecture from file names or imply that an unread project has been fully reviewed.

For a knowledge topic, use authoritative sources for mechanisms and definitions. Check current documentation for details that depend on versions. Separate established facts, useful simplifications, and unsettled claims. Explain the limit of each analogy or simplified model.

Project explanations are read-only unless the user also requests changes. Label hypothetical code and toy data so the user can distinguish them from the real project.

## Write about 80% of the way toward ASD-STE100

Treat “80%” as a practical clarity target, not a measured score or a claim of standards compliance. Adopt the useful principles of Simplified Technical English without forcing a controlled dictionary onto every explanation. The [official ASD-STE100 FAQ](https://www.asd-ste100.org/STE_faq.html) describes principles that can also help other writing contexts.

- Lead with what the thing does and why the user should care.
- Give each sentence one main job. Give each paragraph one topic. Keep the actor, action, and object clear.
- Prefer common words, active voice, and direct verbs. Explain necessary technical terms at first use. Keep one name for each concept; avoid synonyms merely for variety.
- As an editing guide for English, aim for about 20 words per instruction and 25 words per explanatory sentence. Split dense clauses, but keep the words needed for a complete meaning. These are guides here, not hard limits.
- State conditions before actions when the condition changes what to do. Name the referent when “it,” “this,” or “they” would be ambiguous.
- Prefer concrete quantities and observable outcomes to vague words such as “efficient” or “robust.” Preserve exceptions, units, and uncertainty when simplifying.
- Keep exact code identifiers, API names, equations, and quotations. Define them rather than rewriting them into misleading plain words.
- For other languages, apply the same clarity principles using natural local phrasing. Do not impose English word counts or describe the result as STE-compliant.

For example, replace “Cache invalidation facilitates consistency across the system” with “The cache stores a copy of the data. When the source data changes, remove or update that copy. Otherwise, readers can receive old data.” This adds the mechanism and the consequence, not just easier vocabulary.

## Make the mechanism visible

Include diagrams or images that answer a specific learning question. Start with a small overview; add a second view when the sequence, state changes, or internal structure needs it. Keep labels consistent with the explanation and examples. Explain how to read the visual and what the user should notice.

Choose the form by the relationship:

| Learning question | Useful visual |
| --- | --- |
| What are the parts and boundaries? | Component diagram |
| What happens first, and who does it? | Flowchart or sequence diagram |
| How does the object change? | State diagram or before/after view |
| How do values affect the result? | Plot or interactive visual |
| What does this look like in space or in the real world? | Annotated illustration or image |

Use Mermaid for small diagrams when supported. Use an available visualization tool when interaction helps the user explore cause and effect. Use image generation when an illustration adds understanding. Use plotting tools for quantitative figures. Do not make an image decorative or use generated imagery as evidence of a real interface or scientific result. Check labels, arrows, units, and consistency before presenting it.

If a preferred tool is unavailable, use a readable text diagram or another supported format. For a small follow-up, reuse the existing visual or show only the affected part. Do not repeat a large diagram that adds no new understanding.

## Teach with worked examples

Use a small, complete example before a realistic one when the distinction helps. Develop the example step by step: starting state and inputs, each important operation, intermediate values, final output, and why that output follows. Explain code in terms of behavior, not only syntax. Provide expected results; state whether code was executed or only reasoned through.

Then vary one condition to show a boundary, failure, or common misconception. Keep names and values consistent across the prose, visual, and example. Explain where toy assumptions stop matching the real project.

For example, to explain a cache, follow the same key through a miss, a hit, and a source-data change. Show the source value, cached value, returned value, and whether the source was read each time. This reveals both the benefit and the stale-data risk. A metaphor alone does not replace this trace.

## Curate web articles and videos

For a substantive lesson, search the web for relevant blog posts or articles and explanatory videos. Include both formats when useful sources are available. Respect a user's request to skip browsing or keep the answer brief. For a narrow follow-up, reuse verified resources unless new ones are needed.

Select a small learning path rather than a search dump; about 3–6 resources is often enough. Favor original authors, project maintainers, official talks, and educators who explain the mechanism well. Use authoritative primary sources to substantiate technical claims. Rank resources by fit to the user's question and level, not only popularity or recency. Identify version differences in older resources when they matter. Do not send private project content in search queries; search public concepts instead.

Open and read each article before summarizing it. For videos, inspect available transcripts, captions, chapters, or descriptions. Say when a summary relies only on a description or partial transcript; do not imply that you watched unavailable content. Only include timestamps or durations you verified. Search snippets alone are not enough for a detailed summary. If evidence or access is limited, mark the limitation or replace the resource.

For each resource, give:

- A direct link, title, author or channel, and format.
- Its core explanation in a few specific sentences, grounded in the content you inspected.
- The user's learning benefit: which question it answers, suitable level, and prerequisites if needed.
- A useful reading or viewing order, with verified date, version, or timestamp when relevant.

Avoid duplicate resources that teach the same point in the same way. If no suitable video or article is accessible, report the gap briefly rather than inventing a link or padding the list. The lesson itself should still be understandable without opening external links.

## Deliver and check understanding

A substantial explanation usually moves from the main idea to a visual map, the mechanism, worked examples, important limits, and the learning-resource list. Adapt the structure to the subject instead of forcing identical headings on every response.

End with a small prediction, modification, or teach-back exercise when it helps the user learn. Offer a hint or explain the answer after giving the user room to think. Do not turn a requested explanation into a compulsory quiz. Use follow-up confusion to change the explanation or example rather than repeating the same wording.

Before sending, check that the explanation has a clear mechanism, the visual matches the examples, concrete results follow from stated inputs, source links support the claims, and resource summaries reflect inspected content. Keep factual detail even when simplifying the language.
