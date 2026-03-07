---
name: advisory-piece
description: Use when the user asks to write a new methodology, advisory, or "how we approach X" documentation page for this repository. Applies when the request involves writing an opinionated, practitioner-facing guide on a device management, security, or IT operations topic — e.g. "write a page on patch management", "create a methodology doc for BitLocker", "add an advisory on MDM enrolment strategy".
version: 1.0.0
---

# Advisory Piece Skill

This skill produces methodology and advisory documentation in the established style of this repository.

## When This Skill Applies

- User asks to write or draft a new methodology, policy, or advisory doc
- User asks to add a page explaining how to approach a topic (updates, enrolment, compliance, offboarding, etc.)
- User asks to create a "philosophy" or "best practice" page

## Output Format

All pages are `.mdx` files using Mintlify components. Place them under the relevant `docs/<platform>/` or `docs/<product>/` subdirectory.

## Process

1. Identify the topic, platform, and audience from the user's request
2. Read the reference template at [references/template.mdx](references/template.mdx)
3. Read at least one existing advisory page to calibrate tone (e.g. `docs/macos/os-updates.mdx`)
4. Draft the page following the structure and voice guidelines below
5. Write the file to the correct location

## Structure (in order)

1. **Frontmatter** — `title`, `description`, `icon`
2. **Core philosophy** — Frame the central tension or tradeoff. Always end with a blockquote that distils the guiding principle in one or two sentences.
3. **Named approach sections** — 3–6 sections covering the main facets of the topic. Each has a clear heading and explains both *what to do* and *why* — including what goes wrong if you don't.
4. **Mechanics section** — How the relevant technology actually works (MDM commands, DDM, OS behaviour, etc.). Concrete and factual.
5. **Edge cases** — At least one section on the failure modes that skew metrics or cause operational problems (offline devices, ghost records, unsupervised devices, etc.).
6. **User communication** — If end users are involved, always include a comms section. Four required elements: what version/action is needed, the deadline in local timezone, the consequence of missing it, and where to get help. Remind the writer to keep it to one paragraph.
7. **Summary table** — Final section. Two-column table: Principle | Guidance. One row per major recommendation.

## Voice and Style

- **Direct and practitioner-facing.** Write for the person doing the work, not the person approving it. Skip preamble.
- **State consequences, not just recommendations.** "If you only use X, then Y will happen" is more useful than "use X and Z together."
- **No hedging.** Avoid "it may be worth considering" or "you might want to think about." Say what to do and why.
- **British/Australian English spelling.** organisation, behaviour, authorise, recognise, licence (noun).
- **Compliance framing where relevant.** Reference specific frameworks by name (ISO 27001 A.8.8, SOC 2, Essential Eight) without over-explaining them. The reader knows what they are.
- **Short.** If a section needs more than four short paragraphs, it should probably be split or cut.
- **Callouts sparingly.** Use `<Tip>` for practical shortcuts, `<Note>` for important caveats, `<Warning>` for things that will cause real harm if missed. Never use more than one callout per section.

## Tables

Use tables for:
- Rollout timelines (Phase | Timeframe | Action)
- Soak period recommendations by release type
- MDM command modes and their behaviours
- Summary of principles at the end

Keep table rows short. If a cell needs more than one sentence, break it into a separate section instead.

## Tone Checklist Before Writing

- Does the core philosophy section name a real tradeoff (not just "balance is good")?
- Does the blockquote say something that could only apply to this specific topic?
- Does each section explain what breaks if you ignore it?
- Is the user communication section present if end users are affected?
- Does the summary table cover every major recommendation in the doc?
- Is the spelling British/Australian throughout?
