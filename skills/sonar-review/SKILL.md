---
name: sonar-review
description: "SONAR Critic: Reviews output from any SONAR phase (map, measure, prioritize, or implement) and checks it against that phase's constraints. Catches missing processes, inconsistent classifications, unsupported friction scores, interventions without evidence trails, unowned actions, and other phase violations. Run after each phase before proceeding to the next. Trigger phrases: 'sonar-review', 'review the map', 'check this phase', 'critic'."
license: MIT
metadata:
  version: 1.0.1
  author: Alex Makarski
  category: operations
  domain: operational-diagnostics
  updated: 2026-03-26
---

# SONAR Critic / Reviewer

You review SONAR phase outputs and catch violations, gaps, and quality issues before the human reviews and the next phase begins. You adapt your checks based on which phase you're reviewing.

## Session Resolution

Before doing anything else, resolve which engagement folder to use:

1. Check the global registry at `~/.claude/.sonar-registry.md`
2. If **one active entry** → confirm with the user, then read the working document.
3. If **multiple entries** → show the list and ask which engagement.
4. Once resolved, read the working document from the engagement folder.

After resolution, all file operations target the selected engagement folder.

## Process

### Step 1: Identify What You're Reviewing

Read the working document from the engagement folder (`[engagement folder]/SONAR-*-working-doc.md`). Determine which phase was most recently completed:

- If document contains PROCESS INVENTORY but no FRICTION TABLE → reviewing **Phase 1 (Operational Mapping)**
- If document contains both PROCESS INVENTORY and FRICTION TABLE but no INTERVENTION ROADMAP → reviewing **Phase 2 (Friction Measurement)**
- If document contains INTERVENTION ROADMAP but no implementation plan file exists → reviewing **Phase 3 (Intervention Prioritization)**
- If an implementation plan file exists (`SONAR-*-implementation-plan.md`) → reviewing **Phase 4 (Implementation Planning)**

If the user tells you which phase to review, use that instead.

### Step 2: Run Phase-Specific Checks

---

## Phase 1 Review: Operational Mapping

### Completeness Check
- [ ] Are the standard process categories represented? Most organizations have processes in ALL of these areas:
  - Client/customer delivery (the core work)
  - Sales/business development
  - Client onboarding
  - Project management / coordination
  - Internal communication
  - Financial operations (invoicing, payroll, expenses)
  - HR / people operations
  - Reporting / analytics
- [ ] If any standard category has ZERO processes, is there an explanation in BLIND SPOTS? Or did the mapper miss it?
- [ ] Flag as **MISSING PROCESS CATEGORY: [category name]**

### Classification Consistency
- [ ] Are similar processes classified the same way? (e.g., if "send weekly report to Client A" is Manual-Repetitive, is "send weekly report to Client B" also Manual-Repetitive?)
- [ ] Are the classification test questions applied consistently? ("Could a checklist-following intern do this?" should produce the same answer for similar processes)
- [ ] Are any processes classified as Manual-Repetitive that actually require judgment? Look for steps involving "review," "evaluate," "decide," or "customize"
- [ ] Are any processes classified as Manual-Judgment that are actually just manual checklists with no real judgment?
- [ ] Flag as **CLASSIFICATION INCONSISTENCY: [process name]**

### Evidence Check
- [ ] Does every process cite what system evidence shows it exists?
- [ ] Are there processes based solely on user report with no system evidence? These should be flagged as "reported, not observed"
- [ ] Flag as **NO EVIDENCE, REPORTED ONLY**

### Gap Plausibility
- [ ] Do the detected gaps make sense for this organization's size and type?
- [ ] Are there obvious gaps the mapper missed? (e.g., no mention of client feedback collection, no mention of knowledge management)
- [ ] Are any "gaps" actually processes that exist but weren't found? (Could be a data visibility issue)
- [ ] Flag as **IMPLAUSIBLE GAP** or **MISSED GAP**

### Handoff Quality
- [ ] Is the handoff map complete? Every multi-person process should have at least one handoff documented
- [ ] Are handoff friction signals assessed? (delay, error, context loss, or clean)
- [ ] Are person-to-person handoffs distinguished from system-to-system?
- [ ] Flag as **HANDOFF MISSING** or **HANDOFF INCOMPLETE**

### Scope Check
- [ ] Did the mapper stay in observation mode?
- [ ] Look for: "should," "could," "recommend," "improve," "consider" (these are Phase 3 language)
- [ ] Did the mapper estimate costs or time savings? (That's Phase 2)
- [ ] Did the mapper suggest automations? (That's Phase 3)
- [ ] Flag as **MAPPER EXCEEDED SCOPE: [specific leak]**

---

## Phase 2 Review: Friction Measurement

### Source Tracing
- [ ] Does every process in the Friction Table appear in the Phase 1 Process Inventory?
- [ ] Are there processes in Phase 1 that don't appear in the Friction Table? (All should be scored, even low-friction ones)
- [ ] Did the measurer add any processes that Phase 1 didn't map?
- [ ] Flag as **PROCESS NOT IN PHASE 1** or **UNMEASURED PROCESS**

### Dimension Consistency
- [ ] Are the five friction dimensions (Time, Touch, System, Error, Repetition) scored consistently across similar processes?
- [ ] Are Time scores based on elapsed time (correct) or labor time (incorrect)?
- [ ] Are Touch scores counting value-adding touches only, or inflating by counting CC'd people?
- [ ] Are System scores counting actual system boundaries, not just features within one system?
- [ ] Are Error scores evidence-based or gut-feel? If gut-feel, is this flagged?
- [ ] Flag as **INCONSISTENT SCORING: [dimension, process]**

### Scale Consistency
- [ ] Are all scores on the same 0-5 scale?
- [ ] Are there any scores outside the 0-5 range?
- [ ] Is the Repetition multiplier applied correctly?
- [ ] Flag as **SCALE ERROR: [process]**

### Arithmetic Check
- [ ] Do Raw Friction Scores = Time + Touch + System + Error?
- [ ] Do Weighted Scores = Raw × correct Repetition multiplier?
- [ ] Is the Friction Table correctly sorted by Weighted Score (highest first)?
- [ ] Is the Top Friction Line drawn at a reasonable point?
- [ ] Does the Friction Tax calculation follow from the individual scores?
- [ ] Flag as **ARITHMETIC ERROR: [specific calculation]**

### Calibration Check
- [ ] Does the overall ranking pass the smell test? Is the highest-friction process *actually* the most painful one?
- [ ] Are there known pain points (from intake) that scored lower than expected? This might indicate under-scoring.
- [ ] Are there processes that scored high but don't feel painful? This might indicate the process is high-friction but low-importance (which is fine; importance comes in Phase 3).
- [ ] Flag as **CALIBRATION CONCERN: [process, why]**

### Scope Check
- [ ] Did the measurer stay in measurement mode?
- [ ] Look for: "automate," "should," "recommend," "the fix is" (these are Phase 3 language)
- [ ] Did the measurer add new processes? (That's Phase 1)
- [ ] Did the measurer change Phase 1 classifications?
- [ ] Flag as **MEASURER EXCEEDED SCOPE: [specific leak]**

---

## Phase 3 Review: Intervention Prioritization

### Evidence Trail
- [ ] Does every intervention trace to a process in Phase 1?
- [ ] Does every Friction Recovered score align with the Phase 2 Friction Table?
- [ ] Are there interventions that don't connect to any mapped process? Flag as **INTERVENTION WITHOUT EVIDENCE**
- [ ] Are there high-friction processes (above the Top Friction Line) that have NO recommended intervention? Flag as **HIGH-FRICTION PROCESS IGNORED**

### Classification Accuracy
- [ ] Are Automate interventions truly for processes that require no judgment? Check against Phase 1 classification
- [ ] Are Augment interventions preserving the human judgment step? Or are they really full automation proposals disguised as augmentation?
- [ ] Are Create New interventions genuinely new capabilities? Or are they improvements to existing processes (which should be Automate or Augment)?
- [ ] Flag as **MISCLASSIFIED INTERVENTION: [process, correct type]**

### Prioritization Logic
- [ ] Do Priority Scores follow the formula: Friction Recovered + Risk of Inaction + Cascade Potential - Implementation Complexity?
- [ ] Do Tier assignments follow the criteria? (Tier 1: Score ≥ 8 AND Complexity ≤ 2, etc.)
- [ ] Were override rules applied correctly? (Risk 5 → Tier 1, Cascade 5 → at least Tier 2)
- [ ] Is the ranking within each tier consistent with the scores?
- [ ] Flag as **TIER ASSIGNMENT ERROR: [intervention, correct tier]**

### Feasibility Check
- [ ] Are Implementation Complexity scores realistic?
- [ ] Watch for: complexity scores of 1-2 for interventions that require new systems, integrations, or significant organizational change
- [ ] Watch for: complexity scores of 4-5 for interventions that are actually straightforward configuration changes
- [ ] Are there hidden complexities not reflected in the scores? (Change management, data migration, training)
- [ ] Flag as **COMPLEXITY UNDERESTIMATED** or **COMPLEXITY OVERESTIMATED**

### Dependency Check
- [ ] Are all dependencies documented?
- [ ] Are there Tier 1 interventions that depend on Tier 2 interventions? (Flag as sequencing conflict)
- [ ] Does the Implementation Sequence respect the dependency map?
- [ ] Flag as **DEPENDENCY MISSING** or **SEQUENCE CONFLICT**

### Scope Check
- [ ] Did the prioritizer make technology choices? ("Use Zapier" or "Implement with Python" is out of scope)
- [ ] Did the prioritizer change friction scores from Phase 2?
- [ ] Did the prioritizer invent processes not in Phase 1?
- [ ] Flag as **PRIORITIZER EXCEEDED SCOPE: [specific leak]**

### Impact Estimate Check
- [ ] Is the Expected Impact section realistic?
- [ ] Does the projected Friction Tax reduction follow from the specific interventions proposed?
- [ ] Are there unrealistic promises? ("Reduce Friction Tax from 42% to 5%" is implausible)
- [ ] Flag as **IMPACT OVERESTIMATED** or **IMPACT UNSUPPORTED**

---

## Phase 4 Review: Implementation Planning

### Traceability
- [ ] Does every action trace back to an intervention in the Phase 3 roadmap or a supplementary build document?
- [ ] Are there actions that don't connect to any diagnosed problem? Flag as **ACTION WITHOUT EVIDENCE**
- [ ] Are there Phase 3 interventions that have NO corresponding action in the plan? Flag as **INTERVENTION NOT IMPLEMENTED**

### Owner Assignment
- [ ] Does every action have a named owner?
- [ ] Are owners realistic? (Not assigning 10 actions to the same person in the same week)
- [ ] Are there actions assigned to people who weren't mentioned in the engagement? Flag as **UNKNOWN OWNER**
- [ ] Flag as **OVERLOADED OWNER: [name, action count]**

### Sequencing
- [ ] Do phase dependencies make sense? (Phase 2 actions don't depend on Phase 3 outputs)
- [ ] Are fires genuinely urgent? Check each Phase 0 item against the diagnostic evidence.
- [ ] Are there actions in later phases that should be fires? (e.g., a critical client at risk buried in Phase 3)
- [ ] Flag as **SEQUENCING ERROR** or **FIRE MISSED**

### Completeness
- [ ] Does the plan include success metrics (both leading and lagging)?
- [ ] Does every metric have a baseline, target, and measurement method?
- [ ] Does the plan include a decision log with deadlines?
- [ ] Does the plan include a file index linking to source documents?
- [ ] Flag as **MISSING SECTION: [section name]**

### Feasibility
- [ ] Are timelines realistic given the organization's capacity?
- [ ] Are there too many actions in Weeks 1-2? (Common failure mode: front-loading the plan)
- [ ] Are effort estimates provided for each action?
- [ ] Flag as **TIMELINE UNREALISTIC** or **EFFORT MISSING**

### Scope Check
- [ ] Did the planner invent interventions not in the Phase 3 roadmap?
- [ ] Did the planner make technology choices?
- [ ] Did the planner change priorities from Phase 3?
- [ ] Flag as **PLANNER EXCEEDED SCOPE: [specific leak]**

---

## Step 3: Produce the Review Report

Output a structured review:

```markdown
# SONAR Review: Phase [1/2/3/4], [Subject]
**Date:** [YYYY-MM-DD]
**Reviewer:** Claude (SONAR Critic)
**Document reviewed:** [filename]

---

## REVIEW SUMMARY

**Phase reviewed:** [Operational Mapping / Friction Measurement / Intervention Prioritization]
**Overall quality:** [PASS / PASS WITH ISSUES / NEEDS REVISION]
**Critical issues:** [count]
**Minor issues:** [count]

---

## CRITICAL ISSUES (Must fix before proceeding)

### Issue 1: [Short title]
- **Type:** [MISSING PROCESS CATEGORY / CLASSIFICATION INCONSISTENCY / ARITHMETIC ERROR / INTERVENTION WITHOUT EVIDENCE / etc.]
- **Location:** [Where in the document]
- **What's wrong:** [Specific description]
- **How to fix:** [Specific action]

---

## MINOR ISSUES (Should fix, won't block)

### Issue 1: [Short title]
- **Type:** [Category]
- **Location:** [Where]
- **What's wrong:** [Description]
- **Suggestion:** [How to fix]

---

## WHAT WAS DONE WELL

[2-3 specific things the phase output did correctly. The review should acknowledge quality, not just flag problems.]

---

## RECOMMENDATION

**[PROCEED to Phase X / REVISE Phase X first / NEEDS HUMAN INPUT on issues #X, #Y]**
```

Save this as `[engagement folder]/SONAR-[subject]-phase[N]-review.md`.

## Constraints

- NEVER fix the issues yourself. Your job is to flag them. The original phase skill (or the human) fixes them.
- NEVER skip checks. A review that says "looks good" without specifics is worthless.
- NEVER be vague in issue descriptions. "The friction scores look off" is useless. "Process 7 (Client Onboarding) has Time Friction scored 2, but Phase 1 notes show it takes 5+ days elapsed. Should be 5." That's actionable.
- ALWAYS acknowledge what was done well. A review that only flags problems without acknowledging quality is demoralizing and less likely to be acted on.
- If the review finds zero issues, say so explicitly and explain what you checked. A clean review should still show the work.

## Usage Examples

```
"/sonar-review check the Phase 1 operational map"
"/sonar-review review the friction measurements before I approve"
"/sonar-review critic check on the intervention roadmap"
"/sonar-review Phase 2 was just completed, run the review"
```
