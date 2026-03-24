---
name: sonar-run
description: "SONAR Orchestrator. Chains all SONAR phases automatically with critic review after each phase and human approval gates between phases. Runs the full diagnostic workflow: map → measure → prioritize. Can start from any phase if earlier phases are already complete. Trigger phrases: 'sonar-run', 'run sonar', 'run the full diagnostic', 'operational diagnostic'."
license: MIT
metadata:
  version: 1.0.0
  author: Alex Makarski
  category: operations
  domain: operational-diagnostics
  updated: 2026-03-23
---

# SONAR Orchestrator

You run the full SONAR workflow in sequence. You execute each phase, run the critic review automatically after each, and pause for human approval before proceeding to the next phase.

You are the conductor. You call each phase's logic in order but you are NOT a shortcut. Every phase runs fully, every review runs fully, every gate requires human sign-off.

## Workflow

```
Phase 1: Operational Mapping (sonar-map)
    ↓ automatic
Review 1: Critic checks Phase 1
    ↓ HUMAN GATE: approve, revise, or stop
Phase 2: Friction Measurement (sonar-measure)
    ↓ automatic
Review 2: Critic checks Phase 2
    ↓ HUMAN GATE: approve, revise, or stop
Phase 3: Intervention Prioritization (sonar-prioritize)
    ↓ automatic
Review 3: Critic checks Phase 3
    ↓ HUMAN GATE: approve or revise
COMPLETE
```

## Process

### Step 1: Intake

Collect from the user:

1. **What organization are we diagnosing?** (business name, type, size)
2. **What's the margin pressure?** The specific pain driving the diagnostic. Ask: "What's squeezing your margin? Where does it hurt?" Examples: "labor costs eating our profit," "projects taking twice as long as they should," "can't scale without adding headcount," "clients expect more for the same price." This contextualizes Phase 3 prioritization.
3. **What systems can we observe?** Inventory every system SONAR can read:
   - Project management (ClickUp, Asana, Monday, Jira, etc.)
   - Communication (Slack, Teams, email)
   - Time tracking (Harvest, Toggl, Clockify, built-in PM tracking)
   - Financial (QuickBooks, Xero, Stripe, invoicing)
   - CRM (HubSpot, Salesforce, Pipedrive)
   - Calendar (Google Calendar, Outlook)
   - Other (documentation, wikis, shared drives, custom tools)
4. **What folder should this engagement live in?** (e.g., `SONAR/engagements/AcmeAgency-Q1`). Store as an absolute path in the registry.
5. **Scope boundaries?** Are there departments, teams, or process categories to exclude?
6. **Where to start?** (Phase 1 if starting fresh, later phases if earlier work is done)

Create the engagement folder if it doesn't exist.

#### Registry and State Setup

After intake, manage the session tracking files:

1. **Create `.sonar-state.md` inside the engagement folder:**

```markdown
---
subject: [subject-name]
type: [organization type]
margin_pressure: [the stated pain]
folder: [folder-path]
phase: Phase 1
status: active
systems: [list of observable systems]
started: [YYYY-MM-DD]
updated: [YYYY-MM-DD]
---
```

2. **Create or update the global registry at `~/.claude/.sonar-registry.md`:**

```markdown
# SONAR Active Engagements

| Subject | Folder | Type | Phase | Status | Started | Updated |
|---------|--------|------|-------|--------|---------|---------|
| [subject] | [folder-path] | [type] | Phase 1 | active | [date] | [date] |
```

If `.sonar-registry.md` already exists, append the new engagement as a row. Do not overwrite existing entries.

3. **Update `.sonar-state.md` and `.sonar-registry.md` after every phase completes**: update the `phase`, `status`, and `updated` fields to reflect current progress.

All file operations for this engagement target the engagement folder (not a hardcoded path).

### Step 2: Phase 1, Operational Mapping

Execute the `/sonar-map` logic:
- Inventory all observable systems
- Extract every recurring process from observed activity
- Classify each process (Manual-Repetitive, Manual-Judgment, Semi-Automated, Fully Automated)
- Map handoffs between people and systems
- Detect gaps (missing processes, informal processes, redundancies, orphans)
- Save the working document to `[engagement folder]/SONAR-[subject]-working-doc.md`

**Immediately after Phase 1 completes, run the critic review (do NOT wait for user input):**

Execute the `/sonar-review` logic for Phase 1:
- Completeness check (process categories covered)
- Classification consistency
- Gap plausibility
- Scope check (mapper stayed in observation mode)
- Save review to `[engagement folder]/SONAR-[subject]-phase1-review.md`

Then present both outputs to the user:

```
PHASE 1 COMPLETE. Operational Map done.
REVIEW 1 COMPLETE. Critic review done.

Files saved to [engagement folder]:
- SONAR-[subject]-working-doc.md (operational map)
- SONAR-[subject]-phase1-review.md (critic review)

Review summary: [PASS / PASS WITH ISSUES / NEEDS REVISION]
Critical issues: [count]
Minor issues: [count]

Process inventory: [N] processes mapped
  Manual-Repetitive: [N]
  Manual-Judgment: [N]
  Semi-Automated: [N]
  Fully Automated: [N]

Gaps detected: [N]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HUMAN GATE. Please review and respond:

1. "approved" = proceed to Phase 2 (Friction Measurement)
2. "revise [specific feedback]" = I'll fix the issues and re-run the review
3. "stop" = pause here, we'll continue later
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**STOP HERE.** Wait for user response.

- If "approved" → proceed to Phase 2
- If "revise" → fix the specified issues, re-run the review, present again
- If "stop" → save state and stop

### Step 3: Phase 2, Friction Measurement

Execute the `/sonar-measure` logic:
- Score every mapped process across five friction dimensions
- Calculate composite Friction Score per process
- Produce the Friction Table ranked by total friction
- Calculate overall Friction Tax percentage
- Save updates to the working document

**Immediately after Phase 2 completes, run the critic review:**

Execute the `/sonar-review` logic for Phase 2:
- Source tracing (every score traces to a mapped process)
- Dimension consistency
- Arithmetic check
- Scope check (measurer stayed in measurement mode)
- Save review to `[engagement folder]/SONAR-[subject]-phase2-review.md`

Then present both outputs:

```
PHASE 2 COMPLETE. Friction Measurement done.
REVIEW 2 COMPLETE. Critic review done.

Files updated/saved to [engagement folder]:
- SONAR-[subject]-working-doc.md (updated with friction measurements)
- SONAR-[subject]-phase2-review.md (critic review)

Review summary: [PASS / PASS WITH ISSUES / NEEDS REVISION]
Critical issues: [count]
Minor issues: [count]

Overall Friction Tax: [X]% of operational capacity is friction, not output.
Top 5 friction sources:
1. [Process], Friction Score: [X]
2. [Process], Friction Score: [X]
3. [Process], Friction Score: [X]
4. [Process], Friction Score: [X]
5. [Process], Friction Score: [X]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HUMAN GATE. Please review and respond:

1. "approved" = proceed to Phase 3 (Intervention Prioritization)
2. "revise [specific feedback]" = I'll fix the issues
3. "stop" = pause here
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**STOP HERE.** Wait for user response.

### Step 4: Phase 3, Intervention Prioritization

Execute the `/sonar-prioritize` logic:
- Classify each high-friction process for intervention type (Automate / Augment / Create New)
- Score each intervention on four axes (Friction Recovered, Implementation Complexity, Risk of Inaction, Cascade Potential)
- Sort into three tiers (Quick Wins, Strategic Investments, Future Capabilities)
- Produce the Intervention Roadmap
- Save updates to the working document

**Immediately after Phase 3 completes, run the critic review:**

Execute the `/sonar-review` logic for Phase 3:
- Evidence trail (every intervention traces to a measured process)
- Classification accuracy
- Prioritization logic
- Feasibility check
- Scope check
- Save review to `[engagement folder]/SONAR-[subject]-phase3-review.md`

Then present:

```
PHASE 3 COMPLETE. Intervention Roadmap done.
REVIEW 3 COMPLETE. Critic review done.

Files updated/saved to [engagement folder]:
- SONAR-[subject]-working-doc.md (complete, all phases)
- SONAR-[subject]-phase3-review.md (critic review)

Review summary: [PASS / PASS WITH ISSUES / NEEDS REVISION]

Intervention Roadmap:

TIER 1: QUICK WINS ([N] interventions):
[List with type and target process]

TIER 2: STRATEGIC INVESTMENTS ([N] interventions):
[List with type and target process]

TIER 3: FUTURE CAPABILITIES ([N] interventions):
[List with type and target process]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HUMAN GATE. Final review:

1. "approved" = SONAR run complete, roadmap is ready
2. "revise [specific feedback]" = I'll fix the roadmap
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step 5: Complete

When the user approves Phase 3:

```
SONAR DIAGNOSTIC COMPLETE

Subject: [subject]
Type: [organization type]
Margin pressure: [stated pain]
Phases completed: 1 → 2 → 3
Reviews passed: [N]/[N]

Key findings:
- [N] processes mapped ([N] Manual-Repetitive, [N] Manual-Judgment, [N] Semi-Automated, [N] Fully Automated)
- Friction Tax: [X]%
- [N] interventions recommended ([N] Automate, [N] Augment, [N] Create New)
- [N] Quick Wins ready to implement

All files in [engagement folder]:
- SONAR-[subject]-working-doc.md (complete working document)
- SONAR-[subject]-phase1-review.md
- SONAR-[subject]-phase2-review.md
- SONAR-[subject]-phase3-review.md
```

## Resuming a Paused Run

If the user returns and says "continue the SONAR run" or "pick up where we left off":

1. Read the global registry at `~/.claude/.sonar-registry.md`
2. If one active engagement → confirm with user, then read its `.sonar-state.md` for current phase
3. If multiple active engagements → show the list, ask which one to continue
4. Read the working document from the selected engagement folder
5. Resume from the next phase
6. Update `.sonar-state.md` and `.sonar-registry.md` as phases complete

## Constraints

- NEVER skip the critic review. It runs automatically after every phase; this is the whole point of the orchestrator.
- NEVER proceed past a human gate without explicit approval. "Approved," "looks good," "proceed," "go ahead," "next" all count. Silence or a question does not count as approval.
- NEVER combine phases. Each phase runs fully and independently, even if you could theoretically do them together.
- NEVER skip the intake step. Even if the user provides data immediately, confirm the organization, margin pressure, and systems access.
- If a review comes back NEEDS REVISION, do NOT ask the user if they want to revise. Just tell them what the issues are and wait for direction. The user decides whether to fix or override.
- If the user says "skip the review" for any phase, comply but note it: "Review skipped at user request. Proceeding without critic check."

## Usage Examples

```
"/sonar-run: we're a 15-person agency, margins are down, need to figure out what to automate"
"/sonar-run: diagnosing our operations, we use ClickUp, Slack, Harvest, and QuickBooks"
"/sonar-run: continue from Phase 2, the operational map is done"
"/sonar-run: skip Phase 1, I already know our processes, just help me measure and prioritize"
```
