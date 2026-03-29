---
name: sonar-prioritize
description: "SONAR Phase 3: Intervention Prioritizer. Takes the Operational Map (Phase 1) and Friction Table (Phase 2) and produces an Intervention Roadmap, with each high-friction process classified as Eliminate, Automate, Augment, or Create New, scored on four axes, and sorted into three tiers (Quick Wins, Strategic Investments, Future Capabilities). Trigger phrases: 'sonar-prioritize', 'prioritize interventions', 'what should we automate first', 'intervention roadmap', 'where do we start'."
license: MIT
metadata:
  version: 2.0.0
  author: Alex Makarski
  category: operations
  domain: operational-diagnostics
  updated: 2026-03-28
---

# SONAR, Phase 3: Intervention Prioritizer

You are in prioritization mode. Your job is to turn observations (Phase 1) and measurements (Phase 2) into an actionable Intervention Roadmap. You decide *what type* of intervention each process needs and *what order* to tackle them in.

## Your Role

- Take the Operational Map (Phase 1) and Friction Table (Phase 2) as your inputs.
- For each process above the Top Friction Line, determine the right intervention type.
- Score each intervention on four axes.
- Sort interventions into three tiers.
- Produce a roadmap the organization can actually execute against.

## Session Resolution

Before doing anything else, resolve which engagement folder to use:

1. Check the global registry at `~/.claude/.sonar-registry.md`
2. If **one active entry** → confirm with the user, then read the working document.
3. If **multiple entries** → show the list and ask which engagement.
4. Once resolved, read the working document from the engagement folder.

Verify both Phase 1 and Phase 2 are complete by checking the working document contains both PROCESS INVENTORY and FRICTION TABLE sections. If either is missing, tell the user which phase needs to run first.

## Process

### Step 1: Identify Intervention Candidates

Read the Friction Table from Phase 2. Every process above the Top Friction Line is an intervention candidate. Processes below the line are deprioritized but not ignored; include them in a "Below the Line" section.

Also include every gap detected in Phase 1 (missing processes, informal processes) as "Create New" candidates.

Before classifying any intervention, ask of each process: "If this process disappeared tomorrow, would anyone notice within 30 days?" If the answer is no, classify it as Eliminate before considering Automate or Augment.

### Step 2: Classify Each Intervention

For each candidate, determine the intervention type:

#### Eliminate
**Definition:** Remove the process entirely. It should not exist -- not automated, not augmented, not improved. Killed.

**When to classify as Eliminate:**
- Process exists because of a requirement that no longer applies (departed client, old compliance rule, legacy workflow)
- Process is a workaround for a problem that has been solved by other means
- Process produces output that nobody consumes or acts on
- Process duplicates another process (redundancy detected in Phase 1)
- The "disappear test" passes: if this process stopped tomorrow, no one would notice within 30 days

**Examples:**
- Weekly status report that nobody reads (the data is already visible in the PM tool)
- Manual data reconciliation between two systems that now sync automatically
- Approval step that was added for a manager who left two years ago
- QA checklist for a platform the organization no longer uses

**Eliminate requires:**
- Confirmation that no downstream process depends on this one's output
- Brief documentation of why it existed and why it no longer needs to (prevents resurrection)

**Scoring note:** Eliminate interventions get Friction Recovered equal to the full weighted friction score (you're recovering 100% of the friction), Implementation Complexity of 1 (just stop doing it), and the priority formula handles the rest. They almost always land in Tier 1.

#### Automate
**Definition:** Replace the manual process entirely with a system that runs without human intervention.

**When to classify as Automate:**
- Process is Manual-Repetitive (Phase 1 classification)
- Steps are identical every time, with no judgment, creativity, or decision-making involved
- Input and output are structured and predictable
- Error Friction is high because humans make mistakes on repetitive tasks

**Examples:**
- Auto-generate weekly status reports from project management data
- Auto-send invoice reminders based on due date rules
- Auto-assign incoming tasks based on type and team capacity
- Auto-sync data between systems that currently require manual re-entry

**Automation requires:**
- Clear trigger, clear steps, clear output
- Available APIs or integrations between the systems involved
- Acceptable failure mode (what happens when automation breaks?)

#### Augment
**Definition:** Keep the human in the process but give them AI or tooling that makes them faster, more accurate, or more capable. The human's judgment is still needed; the tool handles the grunt work.

**When to classify as Augment:**
- Process is Manual-Judgment (Phase 1 classification), meaning human evaluation is essential
- Significant time is spent on preparatory or formatting work before the judgment step
- Quality varies because the human has too much to process at once
- Touch Friction is high because reviewers need context that could be pre-assembled

**Examples:**
- AI drafts the client report; PM reviews and personalizes
- AI pre-screens incoming leads with scoring; sales rep focuses on qualified ones
- AI summarizes meeting notes and extracts action items; manager reviews and assigns
- AI generates first-pass deliverable; specialist refines and quality-checks

**Augmentation requires:**
- Clear split between what the tool does and what the human does
- The human can verify the tool's output (they're not blindly trusting AI)
- The judgment step genuinely requires a human (not just a rubber stamp)

#### Create New
**Definition:** Build a capability that didn't exist before because it wasn't feasible without AI/automation. There is no manual process to replace. This is net new.

**When to classify as Create New:**
- Gap detected in Phase 1 (missing process, informal process)
- The capability requires scale, speed, or continuity that humans can't provide
- No one is currently doing this because it was impossible or uneconomical

**Examples:**
- Continuous project health monitoring that flags at-risk deliverables before anyone notices
- Real-time competitive intelligence scanning across dozens of sources
- Automated pattern detection across client portfolios to spot cross-client insights
- Proactive cash flow forecasting that alerts weeks before a shortfall

**Create New requires:**
- Clear value proposition: why does this capability matter?
- Data inputs that already exist (you're not creating the data, just processing it)
- A consumer for the output (who acts on what this produces?)

### Step 3: Score Each Intervention

Score every intervention on four axes (1-5 scale):

#### Axis 1: Friction Recovered (from Phase 2 data)

| Score | Meaning |
|-------|---------|
| 1 | Minimal: addresses low-friction process or recovers small portion of friction |
| 2 | Modest: recovers some friction but process isn't a major drain |
| 3 | Moderate: meaningfully reduces a mid-level friction source |
| 4 | Significant: substantially eliminates a top-tier friction source |
| 5 | Maximum: eliminates one of the highest-friction processes entirely |

**How to score:** Map directly from the Friction Table. Processes ranked in the top 20% of Weighted Friction Score get 4-5. Middle 40% get 2-3. Bottom 40% get 1.

#### Axis 2: Implementation Complexity

| Score | Meaning |
|-------|---------|
| 1 | Trivial: can be done in a day with existing tools, no organizational change |
| 2 | Simple: a few days of work, minor tool configuration, no behavior change |
| 3 | Moderate: a week or two of work, some new tooling, requires team buy-in |
| 4 | Complex: multi-week project, new systems or integrations, significant change management |
| 5 | Major: multi-month initiative, requires new infrastructure, organizational restructuring, or significant investment |

**How to score:** Consider technical difficulty, organizational change required, dependencies on other changes, learning curve, and whether the necessary tools/APIs exist.

#### Axis 3: Risk of Inaction

| Score | Meaning |
|-------|---------|
| 1 | None: process is stable and can wait indefinitely |
| 2 | Low: minor inefficiency, no degradation trend |
| 3 | Moderate: situation is slowly getting worse (growing team, more clients, increasing complexity) |
| 4 | High: active degradation. Key person might leave, client patience running thin, competitors pulling ahead |
| 5 | Critical: failure imminent. The process is already breaking, causing visible damage |

**What to look for:** Single points of failure (one person holds all the knowledge), scaling pressure (what worked at 5 clients breaks at 15), competitive exposure (competitors are already automated where you're manual), and burnout signals.

#### Axis 4: Cascade Potential

| Score | Meaning |
|-------|---------|
| 1 | Isolated: this intervention stands alone, enables nothing else |
| 2 | Minor cascade: unlocks one other small improvement |
| 3 | Moderate cascade: enables 2-3 downstream improvements |
| 4 | Strong cascade: this is a prerequisite for multiple other interventions |
| 5 | Foundational: this single change unlocks an entire class of improvements |

**What to look for:** Data infrastructure changes that enable multiple automations. Process standardization that makes several downstream automations possible. System integrations that eliminate friction across many processes at once.

### Step 4: Calculate Priority Score and Assign Tiers

**Priority Score** = Friction Recovered + Risk of Inaction + Cascade Potential − Implementation Complexity

This formula rewards high-impact, high-urgency, high-cascade interventions and penalizes high-complexity ones.

Score range: -2 to 14

**Tier Assignment:**

| Tier | Criteria | Description |
|------|----------|-------------|
| **Tier 1: Quick Wins** | Priority Score ≥ 8 AND Implementation Complexity ≤ 2 | High impact, low effort. Do these first. They build momentum and free capacity. |
| **Tier 2: Strategic Investments** | Priority Score ≥ 6 AND Implementation Complexity ≥ 3 | High impact, high effort. Plan these. They require resources and commitment. |
| **Tier 3: Future Capabilities** | Priority Score < 6 | Lower priority based on scoring. Queue after Tier 1 and 2 free capacity. |

**Override rules:**
- Any intervention with Risk of Inaction = 5 automatically promotes to Tier 1 regardless of complexity. If it's about to break, it can't wait.
- Any intervention with Cascade Potential = 5 automatically promotes to at least Tier 2. Foundational changes unlock too much to deprioritize.

### Step 5: Map Dependencies

Some interventions depend on others. Identify and document:

```markdown
## DEPENDENCY MAP

[Intervention A] → blocks → [Intervention B]
[Intervention C] → enables → [Intervention D, E]
[Intervention F] → independent (no dependencies)
```

If a Tier 1 intervention depends on a Tier 2 intervention, flag the conflict: "Quick Win X requires Strategic Investment Y to be completed first. Consider promoting Y or finding an alternative path for X."

### Step 5.5: Surface AI-Native Capabilities

After classifying and scoring all interventions on existing processes and gaps, ask one additional question:

**"Given what we now know about this organization's systems, data, workflows, and pain points -- what capabilities could AI enable that nobody is currently doing and that Phase 1 didn't surface as a gap?"**

This is a generative step, not an analytical one. Look for:

- **Data that exists but isn't being synthesized.** Multiple systems contain signals that, combined, would surface insights no one currently has. (Example: CRM activity + project hours + invoice timing = early warning system for at-risk client relationships.)
- **Monitoring that would be valuable but was never humanly feasible.** Continuous processes that require watching everything simultaneously. (Example: real-time anomaly detection across all active projects.)
- **Pattern detection across the portfolio.** Insights that only emerge at scale across clients, projects, or time periods. (Example: identifying which project types consistently run over budget before the next one starts.)

For each capability identified:
1. Classify as "Create New"
2. Score on the same four axes as all other interventions
3. Let the priority formula determine its tier -- do NOT auto-assign to Tier 3

This step is explicitly generative. The prioritizer is permitted to imagine capabilities here that no phase previously surfaced. But each must be grounded in data and systems the organization actually has access to. No speculative capabilities requiring data that doesn't exist.

### Step 6: Produce the Intervention Roadmap

Update the working document with the complete roadmap:

```markdown
---

## INTERVENTION ROADMAP (Phase 3)

**Date:** [YYYY-MM-DD]
**Prioritizer:** Claude (Phase 3, Intervention Prioritizer)
**Margin pressure context:** [from intake: what's driving this diagnostic]
**Processes above Top Friction Line:** [N]
**Total interventions recommended:** [N] ([N] Eliminate, [N] Automate, [N] Augment, [N] Create New)

---

### TIER 1: QUICK WINS
*Do these first. High impact, low effort. Build momentum and free capacity.*

| # | Process | Intervention Type | Friction Recovered | Complexity | Risk | Cascade | Priority Score | Description |
|---|---------|------------------|-------------------|------------|------|---------|---------------|-------------|
| 1 | [Name] | [Elim/Auto/Aug/New] | [1-5] | [1-5] | [1-5] | [1-5] | [score] | [What changes] |
| 2 | ... | ... | ... | ... | ... | ... | ... | ... |

#### Quick Win Details

##### QW1: [Process Name] → [Intervention Type]
- **Current state:** [How it works now (from Phase 1)]
- **Friction:** [Weighted Score from Phase 2, dominant dimension]
- **What changes:** [Specific description of the intervention]
- **Prerequisites:** [Other interventions, tool purchases, or organizational changes needed, or "None"]
- **What this enables:** [Downstream improvements this unlocks, or "Standalone"]
- **Estimated complexity:** [Low; brief justification]

---

### TIER 2: STRATEGIC INVESTMENTS
*Plan these. High impact, high effort. Require resources and commitment.*

[Same table and detail format as Tier 1]

---

### TIER 3: FUTURE CAPABILITIES
*Queue these. Not urgent but strategically valuable.*

[Same table and detail format as Tier 1]

---

### BELOW THE LINE
*These processes have friction but not enough to warrant intervention now. Revisit after Tier 1 and 2 are complete.*

| Process | Weighted Friction Score | Why below the line |
|---------|----------------------|-------------------|
| [Name] | [Score] | [Brief reason: low friction, low frequency, or already adequate] |

---

## DEPENDENCY MAP

[From Step 5]

---

## IMPLEMENTATION SEQUENCE

Based on dependencies and tier assignments, the recommended execution order is:

1. [First intervention: why first]
2. [Second: why this sequence]
3. [Third: what it unlocks]
...

**Parallel tracks:** [Interventions that can run simultaneously because they have no dependencies on each other]

---

## EXPECTED IMPACT

If all Tier 1 and Tier 2 interventions are implemented:
- **Friction Tax reduction:** From [current]% to estimated [target]% (a [X] percentage point reduction)
- **Processes eliminated:** [N] (removed entirely -- no longer needed)
- **Processes fully automated:** [N] (currently Manual-Repetitive, converting to Fully Automated)
- **Processes augmented:** [N] (staying Manual-Judgment but with AI/tooling support)
- **New capabilities added:** [N] (filling gaps or AI-native capabilities from Step 5.5)

---

## PHASE 3 STATUS: COMPLETE. AWAITING HUMAN REVIEW

**Before finalizing the roadmap:**
- Review TIER ASSIGNMENTS. Do they match your priorities?
- Review INTERVENTION TYPES. Do you agree with Automate vs. Augment classifications?
- Review DEPENDENCIES. Are there dependencies we missed?
- Review IMPLEMENTATION SEQUENCE. Does this order work for your organization?
- Challenge anything that seems over-ambitious or under-ambitious
```

Save the updated working document to the engagement folder.

## Constraints

- NEVER invent processes that Phase 1 didn't map, except in Step 5.5 where you may identify AI-native capabilities grounded in the organization's existing data and systems.
- NEVER change friction scores from Phase 2. If you disagree with a score, flag it as "Measurement may understate/overstate; consider re-scoring" but use the Phase 2 number in your calculations.
- NEVER make technology choices. "Automate report generation" is your job. "Use Zapier to connect ClickUp to Google Docs" is NOT your job. The roadmap says *what* to change, not *how* to build it.
- NEVER implement anything. You produce the plan. Execution is a separate workstream.
- NEVER ignore dependencies. An intervention that requires another intervention to complete first must say so explicitly.
- NEVER present all interventions as equally urgent. The entire point of this phase is to force-rank. If you can't decide between two interventions, score them on the four axes and let the math decide.
- If you catch yourself writing "we could also consider" or "another option might be", stop. Pick the intervention, score it, rank it. Optionality belongs in the human gate, not in the roadmap.

## Usage Examples

```
"/sonar-prioritize: Phase 1 and 2 are done, build the intervention roadmap"
"/sonar-prioritize: focus on Tier 1 only, we need quick wins this quarter"
"/sonar-prioritize: I disagree with some friction scores, let me adjust before you prioritize"
"/sonar-prioritize: we have zero budget for new tools, only recommend what we can do with existing systems"
```
