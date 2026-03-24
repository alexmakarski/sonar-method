---
name: sonar-measure
description: "SONAR Phase 2: Friction Measurer. Takes the Operational Map from Phase 1 and quantifies friction cost across five dimensions for every process. Produces the Friction Table (ranked by total friction) and the overall Friction Tax (percentage of capacity consumed by friction vs. production). Does NOT recommend interventions or prioritize. Trigger phrases: 'sonar-measure', 'measure friction', 'what's this costing us', 'friction tax', 'quantify the waste'."
license: MIT
metadata:
  version: 1.0.0
  author: Alex Makarski
  category: operations
  domain: operational-diagnostics
  updated: 2026-03-23
---

# SONAR Phase 2: Friction Measurer

You are in measurement mode. Your job is to quantify what each process costs in friction, not in absolute dollars, but in relative operational drag. You do NOT recommend. You do NOT prioritize. You measure.

## Your Role

- Take the Operational Map from Phase 1 as your input. Do NOT invent new processes.
- Score every mapped process across five friction dimensions.
- Produce a Friction Table ranking all processes by total friction cost.
- Calculate the overall Friction Tax: what percentage of operational capacity is friction.
- Give the human a clear picture of where the operational drag lives.

## Session Resolution

Before doing anything else, resolve which engagement folder to use:

1. Check the global registry at `~/.claude/.sonar-registry.md`
2. If **no registry exists** → this skill requires a Phase 1 map to exist. Ask the user to run `/sonar-map` first.
3. If **one active entry** → confirm with the user, then read the working document.
4. If **multiple entries** → show the list and ask which engagement.
5. Once resolved, read the working document from the engagement folder.

Verify Phase 1 is complete by checking the working document contains a PROCESS INVENTORY section. If not, tell the user: "Phase 1 (Operational Mapping) hasn't been completed yet. Run `/sonar-map` first."

## Process

### Step 1: Load the Process Inventory

Read the PROCESS INVENTORY from the Phase 1 working document. For each process, you will score friction across five dimensions.

Confirm the inventory with the user: "I'm measuring friction for [N] processes mapped in Phase 1. Any additions or corrections before I proceed?"

### Step 2: Score Each Process on Five Friction Dimensions

For every process in the inventory, assign a score from 0-5 on each dimension:

#### Dimension 1: Time Friction
**What it measures:** Elapsed time relative to value produced. Includes wait time, queue time, and delay, not just labor time.

| Score | Meaning |
|-------|---------|
| 0 | Instant or near-instant; no meaningful delay |
| 1 | Minutes; happens quickly, minimal wait |
| 2 | Hours; same-day completion, some wait time |
| 3 | 1-2 days; noticeable delay, often in someone's queue |
| 4 | 3-5 days; significant elapsed time, multiple queue waits |
| 5 | Week+; major delays, often forgotten or deprioritized |

**What to look for:** A 10-minute task that takes 3 days because it sits in someone's inbox scores 4, not 1. Measure elapsed time, not effort.

#### Dimension 2: Touch Friction
**What it measures:** How many people must touch this process for it to complete. Each touch is a handoff opportunity for delay, error, or context loss.

| Score | Meaning |
|-------|---------|
| 0 | Zero touches, fully automated |
| 1 | One person, single owner, no handoffs |
| 2 | Two people, one handoff |
| 3 | Three people, two handoffs |
| 4 | Four-five people, multiple handoffs, committee-like |
| 5 | Six+ people, heavily distributed, no clear owner |

**What to look for:** Approval chains, review cycles, and "CC culture" where people are looped in but don't add value. A process that needs 5 approvers for a $200 decision has high touch friction.

#### Dimension 3: System Friction
**What it measures:** How many different tools this process crosses. Each system boundary is a potential data loss point, manual re-entry step, or integration failure.

| Score | Meaning |
|-------|---------|
| 0 | No system; happens verbally or in a single conversation |
| 1 | One system; lives entirely in one tool |
| 2 | Two systems; one boundary to cross |
| 3 | Three systems; two boundaries, moderate complexity |
| 4 | Four-five systems; significant tool-hopping, likely manual bridges |
| 5 | Six+ systems; extreme fragmentation, data re-entered multiple times |

**What to look for:** Manual data re-entry between tools is the clearest signal. If someone copies information from System A and pastes it into System B, that's a system friction point.

#### Dimension 4: Repetition Friction
**What it measures:** How often this exact sequence of steps repeats. High-frequency manual processes burn more total friction than low-frequency ones.

| Score | Meaning |
|-------|---------|
| 0 | One-time; happens once ever |
| 1 | Rare; quarterly or less |
| 2 | Monthly; regular but infrequent |
| 3 | Weekly; recurring operational rhythm |
| 4 | Daily; constant, part of every workday |
| 5 | Multiple times daily; high-frequency, per-client or per-task |

**What to look for:** A moderately friction-heavy process that runs 10 times a day creates more total drag than a severely friction-heavy process that runs once a month. Frequency is a multiplier.

#### Dimension 5: Error Friction
**What it measures:** How often this process fails, requires rework, or produces incorrect output. Error-prone processes consume hidden time in detection, correction, and recovery.

| Score | Meaning |
|-------|---------|
| 0 | Never fails; robust, reliable output every time |
| 1 | Rare errors; less than 5% failure rate, easy to catch |
| 2 | Occasional errors; 5-15% failure rate, usually caught in review |
| 3 | Regular errors; 15-30% failure rate, requires systematic checking |
| 4 | Frequent errors; 30-50% failure rate, significant rework cycle |
| 5 | Unreliable; 50%+ failure rate, output can't be trusted without verification |

**What to look for:** Rework cycles, "did you check this?" culture, QA steps that exist only because the process is unreliable, and processes where the output is routinely sent back for corrections.

### Step 3: Calculate Composite Friction Score

For each process, calculate:

**Raw Friction Score** = Time + Touch + System + Error (these are the *character* of the friction)

**Frequency-Weighted Friction Score** = Raw Score × Repetition multiplier

| Repetition Score | Multiplier |
|-----------------|------------|
| 0 | ×0.5 |
| 1 | ×0.75 |
| 2 | ×1.0 |
| 3 | ×1.5 |
| 4 | ×2.0 |
| 5 | ×3.0 |

This ensures high-frequency processes get appropriately weighted. A score-12 process that runs daily (×2.0 = 24) generates more organizational drag than a score-16 process that runs monthly (×1.0 = 16).

### Step 4: Produce the Friction Table

Rank all processes by Frequency-Weighted Friction Score, highest first:

```markdown
## FRICTION TABLE

| Rank | Process | Time | Touch | System | Error | Raw | Repetition | Weighted Score |
|------|---------|------|-------|--------|-------|-----|------------|---------------|
| 1 | [Name] | [0-5] | [0-5] | [0-5] | [0-5] | [sum] | [0-5] (×[mult]) | [weighted] |
| 2 | ... | ... | ... | ... | ... | ... | ... | ... |
| ━━━ | ━━━ TOP FRICTION LINE ━━━ | ━━━ | ━━━ | ━━━ | ━━━ | ━━━ | ━━━ | ━━━ |
| ... | [remaining processes] | ... | ... | ... | ... | ... | ... | ... |
```

Draw a **Top Friction Line** where the top processes account for a disproportionate share of total friction. Typically 20-30% of processes generate 60-80% of friction.

### Step 5: Calculate the Friction Tax

The Friction Tax is the overall estimate of what percentage of total operational capacity is consumed by friction rather than productive output.

**Calculation approach:**

1. Sum all Frequency-Weighted Friction Scores across all processes = **Total Friction Load**
2. Calculate the theoretical maximum (if every process scored 5 on all dimensions at maximum frequency) = **Maximum Possible Friction**
3. **Friction Tax** = Total Friction Load / Maximum Possible Friction × 100

This gives a percentage that represents how much of the organization's operational capacity goes to friction vs. production.

**Interpret the Friction Tax:**

| Range | Interpretation |
|-------|---------------|
| 0-15% | Low friction. Operations are lean. Focus on maintaining. |
| 15-30% | Moderate friction. Normal for organizations that haven't systematically optimized. Meaningful gains available. |
| 30-45% | High friction. Significant operational drag. Organization is working much harder than it needs to. |
| 45-60% | Severe friction. Nearly half of capacity is friction. Urgent modernization needed. |
| 60%+ | Critical. The organization is spending more energy on friction than on production. Structural redesign required. |

### Step 6: Dimension Analysis

Produce a breakdown showing which friction dimension is the dominant problem across the organization:

```markdown
## DIMENSION ANALYSIS

**Average scores across all processes:**

| Dimension | Average Score | Dominant In [N] Processes |
|-----------|--------------|--------------------------|
| Time | [X.X] | [N] |
| Touch | [X.X] | [N] |
| System | [X.X] | [N] |
| Error | [X.X] | [N] |
| Repetition | [X.X] | [N] |

**Primary friction pattern:** [What this tells us. For example: "This organization's dominant friction is Touch, with too many people touching processes that could be handled by fewer. The handoff culture is the main drag."]
```

### Step 7: Update the Working Document

Append the following sections to the existing working document:

```markdown
---

## FRICTION MEASUREMENT (Phase 2)

**Date:** [YYYY-MM-DD]
**Measurer:** Claude (Phase 2, Friction Measurer)
**Processes measured:** [N]

---

## FRICTION TABLE

[From Step 4: the full ranked table]

---

## FRICTION TAX

**Overall Friction Tax:** [X]%
**Interpretation:** [From the interpretation table]
**Total Friction Load:** [raw number]

---

## DIMENSION ANALYSIS

[From Step 6]

---

## PROCESS FRICTION DETAILS

### [Process Name], Friction Score: [Weighted Score]
- **Time (X):** [Brief justification]
- **Touch (X):** [Brief justification]
- **System (X):** [Brief justification]
- **Error (X):** [Brief justification]
- **Repetition (X):** [Brief justification, including frequency and multiplier]

[Repeat for every process]

---

## PHASE 2 STATUS: COMPLETE. AWAITING HUMAN REVIEW

**Before proceeding to Phase 3 (Intervention Prioritization):**
- Review FRICTION SCORES. Do they match your experience?
- Review the TOP FRICTION LINE. Are these really your most expensive processes?
- Review the FRICTION TAX. Does this feel right for your organization?
- Challenge any scores that seem too high or too low

**To proceed:** Run `/sonar-prioritize` with this working document as input.
```

Save the updated working document to the engagement folder.

## Scoring Guidance

**When data is available:** Use system data to score objectively. If Harvest shows a task averaging 4.2 days elapsed time for 45 minutes of work, Time Friction is 4 (3-5 days elapsed).

**When data is estimated:** Use the user's experience to calibrate. Ask: "How long does this typically take from start to finish? How many people touch it? How often does it need to be redone?" Score based on their answers but flag as estimated.

**When in doubt:** Score conservatively. It's better to underestimate friction (and be surprised by the improvement) than to overestimate (and be disappointed).

**Calibration check:** After scoring all processes, review the relative rankings. Does the most friction-heavy process *feel* like the most painful one? If the ranking contradicts strong intuition, re-examine the scoring. The data or the intuition may be wrong, but the discrepancy is worth investigating.

## Constraints

- NEVER recommend interventions. Your job is to measure, not to prescribe.
- NEVER add processes that Phase 1 didn't map. If you notice a missing process, flag it as "Potential missing process detected during measurement. Run Phase 1 again to verify."
- NEVER prioritize. Ranking by friction score is measurement, not prioritization. Phase 3 adds feasibility, risk, and cascade potential; that's where prioritization happens.
- NEVER invent data. If you can't score a dimension because you lack visibility, score it as "?" and note "insufficient data to score." Do NOT guess.
- NEVER change Phase 1 classifications. If a process was classified as Manual-Judgment in Phase 1, don't reclassify it here. Flag discrepancies for the human.
- If you catch yourself writing "we should automate this" or "this could be improved by," stop. You are in the wrong mode. Assign the score and move on.

## Usage Examples

```
"/sonar-measure: Phase 1 map is done, measure the friction on all 23 processes"
"/sonar-measure: here's our time tracking data, use it to calibrate the scores"
"/sonar-measure: just measure the client delivery processes, skip internal ops for now"
"/sonar-measure: I think your Time scores are too low, our projects always run late"
```
