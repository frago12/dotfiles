---
name: doc-review
description: >
  Reviews a technical spec, README, guide, architecture design, or product
  requirements doc and rewrites the weak passages. Use only when the user
  explicitly invokes /doc-review. Do not invoke for any other writing,
  editing, or review request.
when-to-use: Only the explicit command /doc-review.
argument-hint: "[path or pasted document]"
user-invocable: true
disable-model-invocation: true
---

# Doc Review

The user invoked `/doc-review`. Review the document they named or pasted. If they named none, ask which document to review and stop.

The argument after `/doc-review` is a file path, several paths, or the document itself. Read every named file before commenting.

Rewrite the document so it hooks the reader, makes the stakes concrete, and ends with a takeaway they can act on. A scorecard without rewritten prose is not the deliverable.

## Rubric

Judge each dimension pass or fail against the text in front of you. For every fail, quote the passage and write the replacement.

1. **Hook.** The opening says why this document matters and leaves a problem unresolved. A generic title-statement opening fails. Open on the tension that prompted the doc.
2. **Stakes.** The cost of inaction is explicit: failure, debt, user friction, wasted hours, or a missed goal. A doc with no stakes fails.
3. **Specificity.** Vague claims fail. "Optimized performance", "robust architecture", and "improved developer workflow" are failures. Replace them with a concrete moment: a snippet, an error, a workflow step, or a real usage scenario.
4. **Pacing.** A critical section that is dense and airless fails. Setup or boilerplate that is over-explained fails. Unpack decisions, edge cases, and breaking changes. Move through prerequisites quickly.
5. **Insight.** The doc names a non-obvious choice or a standard approach that failed. If it never says why the obvious path lost, it fails.
6. **Tone.** The doc acknowledges the person who will maintain or follow it. An unfeeling manual fails. Stay technically precise. Warmth is specific to their pain.
7. **Takeaway.** The ending states the goal, the next step, or the impact. An abrupt stop fails. Close with a summary or a checklist tied to the mission of the doc.

## Process

1. Read the whole document.
2. Audit the intro against Hook and Stakes.
3. Replace abstract claims with concrete scenes from the doc or the surrounding repo.
4. Rebalance pacing: expand the hard parts, cut repeated setup.
5. Rewrite the ending so the reader knows what success is and what to do next.

## Deliverable

Return, in this order:

1. **Verdict.** One sentence on whether the doc currently hooks, clarifies, and lands.
2. **Findings.** Only the failed dimensions. For each: the dimension, a short quote, why it fails, and the rewritten passage.
3. **Revised document.** The full rewrite when the doc is short enough to replace. For a long doc, the rewritten sections in place, plus which sections were left alone.

Preserve facts, commands, and technical meaning. Change framing, order, specificity, and endings. Do not invent metrics, incidents, or constraints that are not in the source or the surrounding repo.
