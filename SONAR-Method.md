# SONAR: Systematic Operational Navigation & Automation Readiness

## What It Is

SONAR is a multi-phase operational diagnostics method that maps how work actually flows through an organization, measures the friction cost of each process, and prioritizes where AI automation, human augmentation, or entirely new capabilities will recover the most margin. It replicates the diagnostic sequence of an operations consultant who has been given full access to the building: walk the floor first, measure what you see, then recommend where to intervene.

It is not a prompt. It is a *workflow architecture* built from role-locked phases that mirror a diagnostic progression. The mapper observing processes cannot recommend interventions. The measurer quantifying costs cannot prioritize them. The prioritizer ranking interventions cannot invent processes the mapper didn't find.

For the intellectual lineage behind each phase -- where the ideas come from, where they diverge from their ancestors, and why the combination matters -- see [SONAR-DNA.md](SONAR-DNA.md).

---

## The Core Workflow

```
Phase 1: Operational Mapping (sonar-map)
    ↓ (automatic)
Review 1: Critic checks Phase 1
    ↓ HUMAN GATE: approve, revise, or stop
Phase 2: Friction Measurement (sonar-measure)
    ↓ (automatic)
Review 2: Critic checks Phase 2
    ↓ HUMAN GATE: approve, revise, or stop
Phase 3: Intervention Prioritization (sonar-prioritize)
    ↓ (automatic)
Review 3: Critic checks Phase 3
    ↓ HUMAN GATE: approve or revise
Phase 4: Implementation Planning (sonar-implement)
    ↓ HUMAN GATE: approve or revise
COMPLETE
```

Each phase produces a persistent working document in the engagement folder. Each review runs automatically, so the human doesn't have to remember to request it. Each gate requires explicit human approval before the next phase starts. The run can be paused and resumed at any gate.

---

## The Epistemic Position

SONAR assumes **trusted access** to the systems being diagnosed. This is the fundamental difference from SEAL.

SEAL works from submitted evidence. It must verify everything because the data came from someone else and may be incomplete, biased, or wrong. SEAL's entire Phase 1 exists to establish ground truth from unreliable inputs.

SONAR works from direct observation. It reads the actual systems: project management tools, communication platforms, time tracking, financial data, calendars, CRM. The data is authoritative. SONAR doesn't need to verify that a Slack message was sent or that a ClickUp task took 6 hours. The system says so. The question isn't "is this true?" but "what does this pattern mean?"

This changes the entire method:

- **No source tiering.** System data is Tier 1 by default. No need to classify source reliability.
- **No claims-vs-evidence separation.** The data is the evidence. There are no third-party claims to verify.
- **No forensic skepticism.** The mapper trusts what the systems show. Its job is to observe patterns, not to doubt inputs.
- **Different failure mode.** SEAL's failure mode is accepting a false claim as fact. SONAR's failure mode is misinterpreting a true pattern, such as seeing automation opportunity where the real issue is a missing process, or measuring friction on a process that shouldn't exist at all.

---

## The Phases

### Phase 1: Operational Mapping (`/sonar-map`)

The mapper's job is to answer: **"How does work actually move through this organization?"**

Not how the org chart says it moves. Not how the SOPs describe it. How it *actually* moves, as evidenced by the systems people use every day.

The mapper produces an **Operational Map**, a complete inventory of how work flows, organized by:

**Process Inventory.** Every recurring process the organization runs, extracted from observed system activity. A "process" is any repeatable sequence of actions that produces an output: onboarding a client, producing a deliverable, running payroll, handling a support request, creating a report.

For each process, the map captures:
- **What triggers it** (new client, calendar date, request, system event)
- **Who touches it** (roles, not names, but noting when one person is the single point of failure)
- **What systems it crosses** (how many tools does this process move through?)
- **What handoffs occur** (where does work pass from one person or system to another?)
- **What the output is** (deliverable, decision, communication, data change)
- **Observed frequency** (daily, weekly, per-client, ad hoc)

**Flow Classification.** Each process gets classified into one of four types:

| Type | Description | Example |
|------|-------------|---------|
| **Manual-Repetitive** | Same steps, same sequence, every time. No judgment required. | Copying data between systems, sending templated emails, generating standard reports |
| **Manual-Judgment** | Requires human evaluation, creativity, or decision-making at key points. | Reviewing deliverables, strategic planning, client negotiations |
| **Semi-Automated** | Parts are automated but human intervention bridges the gaps. | CRM auto-assigns leads but a human qualifies them; invoices generate automatically but someone manually checks and sends |
| **Fully Automated** | Runs without human intervention from trigger to output. | Automated email sequences, scheduled backups, webhook-triggered notifications |

**Gap Detection.** The mapper also identifies what's *missing*:
- Processes that should exist but don't (no post-mortem after project completion, no systematic follow-up on proposals)
- Processes that are informal/tribal (happens because one person remembers to do it, not because a system triggers it)
- Processes that are redundant (two different workflows producing the same output)
- Processes that are orphaned (no clear owner, happens inconsistently)

**Handoff Mapping.** Every point where work passes from one person, team, or system to another is a potential friction point. The mapper specifically inventories:
- Person-to-person handoffs (and whether they're explicit or assumed)
- System-to-system handoffs (and whether they're automated or require manual bridging)
- Information handoffs (and whether context is preserved or lost in translation)

**The mapper is prohibited from:**
- Recommending interventions
- Estimating costs or time savings
- Prioritizing processes
- Suggesting what should be automated

Its job is to produce a complete, accurate map of operational reality. Nothing more.

---

### Phase 2: Friction Measurement (`/sonar-measure`)

The measurer's job is to answer: **"What is each process actually costing?"**

Not in absolute terms (that requires time-tracking data that may not exist), but in relative friction. The measurer takes the Operational Map from Phase 1 and assigns costs along five dimensions:

**The Five Friction Dimensions:**

1. **Time Friction.** How much elapsed time does this process consume relative to the value it produces? A 10-minute task that takes 3 days because it's waiting in someone's queue has high time friction even though the labor is low.

2. **Touch Friction.** How many people touch this process? Each touch is a handoff, and each handoff is a potential delay, error, or context loss. A process that requires 5 people to review what one person could decide has high touch friction.

3. **System Friction.** How many tools does this process cross? Each system boundary is a potential data loss point, a manual re-entry step, or an integration failure. A process that lives in one tool has lower system friction than one that crosses four.

4. **Repetition Friction.** How often is this exact sequence of steps repeated? High-frequency manual-repetitive processes burn more total friction than low-frequency ones, even if each individual occurrence is small.

5. **Error Friction.** How often does this process fail, require rework, or produce the wrong output? Error-prone processes consume hidden time in correction and recovery.

For each process in the Operational Map, the measurer produces a **Friction Score**, a composite of the five dimensions, weighted by observed frequency. The output is a **Friction Table**: every process ranked by total friction cost, with the dimension breakdown visible so you can see *why* each process is expensive.

**The Friction Tax.** The measurer also calculates an overall **Friction Tax**: the estimated percentage of total operational capacity consumed by friction rather than production. This is the number that makes margin pressure tangible: "37% of your operational capacity is friction, not output."

**The measurer is prohibited from:**
- Recommending specific interventions
- Changing the process inventory from Phase 1
- Adding processes the mapper didn't find
- Making strategic judgments about which processes matter more

Its job is to quantify what Phase 1 observed. Nothing more.

---

### Phase 3: Intervention Prioritization (`/sonar-prioritize`)

The prioritizer's job is to answer: **"Where should we intervene first, and how?"**

It takes the Operational Map (Phase 1) and Friction Table (Phase 2) and produces an **Intervention Roadmap**, a ranked list of specific changes, each classified by type and scored by impact and feasibility.

**The Intervention Taxonomy:**

Every recommended intervention falls into one of three categories:

| Category | Definition | Example |
|----------|-----------|---------|
| **Automate** | Replace a manual process with a system that runs without human intervention. | Auto-generate weekly client reports from project management data instead of having a PM write them manually |
| **Augment** | Keep the human in the process but give them AI/tooling that makes them faster, more accurate, or more capable. | AI drafts the client report; PM reviews and personalizes instead of writing from scratch |
| **Create New** | Build a capability that didn't exist before because it wasn't feasible without AI/automation. | Continuous project health monitoring that flags at-risk deliverables before anyone notices, since no human could watch all projects simultaneously |

**Prioritization Criteria:**

Each intervention is scored on four axes:

1. **Friction Recovered.** How much of the measured friction (Phase 2) does this intervention eliminate? Directly derived from the Friction Table.

2. **Implementation Complexity.** How hard is this to build and deploy? Considers technical difficulty, organizational change required, dependencies on other changes, and learning curve.

3. **Risk of Inaction.** What happens if you don't do this? Some high-friction processes are stable and can wait. Others are actively degrading (key person might leave, client patience is running out, competitors are pulling ahead).

4. **Cascade Potential.** Does this intervention unlock other interventions? Some changes are prerequisites for others. Some create momentum. A process that, once automated, makes three other automations trivial has high cascade potential.

**The Roadmap Structure:**

The Intervention Roadmap is organized in three tiers:

- **Tier 1: Quick Wins.** High friction recovered, low implementation complexity. Do these first. They build momentum and free capacity for harder changes.
- **Tier 2: Strategic Investments.** High friction recovered, high implementation complexity. These are the big moves that require planning, resources, and organizational buy-in.
- **Tier 3: Future Capabilities.** Create New interventions that aren't urgent but represent competitive advantages. Queue these after Tier 1 and 2 free up capacity.

Each intervention in the roadmap includes:
- The specific process it targets (traced back to Phase 1)
- The friction it addresses (traced back to Phase 2)
- The intervention type (Automate / Augment / Create New)
- A plain-language description of what changes
- Prerequisites (other interventions or conditions that must be in place first)
- Estimated complexity (Low / Medium / High)

**The prioritizer is prohibited from:**
- Inventing processes that Phase 1 didn't map
- Changing friction measurements from Phase 2
- Implementing or building anything
- Making technology choices (it recommends *what* to automate, not *how*)

Its job is to produce an actionable, prioritized roadmap. Nothing more.

---

### Phase 4: Implementation Planning (`/sonar-implement`)

The implementation planner's job is to answer: **"How do we execute this, in what order, and how do we know it's working?"**

Phase 3 produces a roadmap -- a ranked list of interventions with priorities and dependencies. But a roadmap is not a project plan. It doesn't tell you what to do Monday morning. It doesn't assign owners. It doesn't define what "done" looks like. It doesn't surface the decisions the sponsor needs to make before execution can start.

Phase 4 bridges that gap. It takes the Intervention Roadmap, plus any supplementary analysis done during the engagement (transcript analysis, revenue data, build documents), and produces a single execution document the organization works from.

**The Implementation Plan Structure:**

1. **Fires (Phase 0).** Anything that will cost revenue or relationships if not addressed this week. These sit outside the regular timeline.
2. **Foundation (Weeks 1-2).** Actions that establish infrastructure for everything else: presenting frameworks, seeding tracking systems, starting pilots, making quick structural changes.
3. **Embed (Weeks 3-4).** Expand pilots, start behavioral change, make deferred decisions.
4. **Defend (Weeks 5-8).** Activate defensive systems, automate what was manual, run first formal reviews.
5. **Grow (Weeks 9-12).** Shift from defense to offense: new pricing, new positioning, expanded capabilities.

Every action in the plan includes: what happens, who owns it, what effort it requires, what deliverable it produces, and which source document it draws from.

**Success Metrics:** The plan defines leading indicators (weekly behavioral measures that predict outcomes) and lagging indicators (monthly business outcomes). Each metric has a baseline, a 90-day target, and a measurement method.

**Decision Log:** Every decision the sponsor needs to make during execution, with deadlines and context.

**The implementation planner is prohibited from:**
- Inventing interventions not in the Phase 3 roadmap or supplementary builds
- Changing friction measurements or priority scores from earlier phases
- Making technology choices
- Setting deadlines without knowing capacity constraints

Its job is to produce a plan the organization can execute against. Nothing more.

---

## The Critic (`/sonar-review`)

Runs automatically after every phase. It adapts its checks to the phase it's reviewing:

**After Phase 1 (Mapping):**
- Completeness check: Are there obvious process categories missing? (Client delivery, internal ops, sales, finance, HR; most organizations have all of these)
- Classification consistency: Are similar processes classified the same way?
- Gap plausibility: Do the detected gaps make sense given the organization's size and type?
- Scope check: Did the mapper stay in observation mode, or did it leak into recommendations?

**After Phase 2 (Measurement):**
- Source tracing: Does every friction score trace back to a process in the Phase 1 map?
- Dimension consistency: Are the five friction dimensions applied consistently across all processes?
- Arithmetic check: Does the Friction Tax calculation follow from the individual scores?
- Scope check: Did the measurer stay in measurement mode, or did it leak into prioritization?

**After Phase 3 (Prioritization):**
- Evidence trail: Does every intervention trace back to a measured process?
- Classification accuracy: Are interventions correctly categorized as Automate / Augment / Create New?
- Prioritization logic: Do the tier assignments follow from the scoring criteria?
- Feasibility check: Are complexity estimates realistic, or is the prioritizer being optimistic?
- Scope check: Did the prioritizer make technology choices it shouldn't have?

The critic doesn't fix issues. It flags them with specific remediation instructions. The human decides whether to fix or override.

---

## The Orchestrator (`/sonar-run`)

Chains all phases automatically, runs the critic after each, and enforces human gates between phases. Can start from any phase if earlier work is done. Manages the engagement folder and state file.

The orchestrator begins with intake:
1. **Organization context.** What does this organization do? Size, industry, business model.
2. **System access.** What systems can SONAR observe? (Project management, communication, CRM, financial, time tracking, calendar)
3. **Margin pressure.** Where is the pain? What's driving the need to modernize? (This contextualizes the prioritization in Phase 3.)
4. **Scope boundaries.** Are there departments, teams, or process categories to exclude?

The orchestrator is a conductor, not a shortcut. Every phase runs fully, every review runs fully, every gate requires explicit sign-off.

---

## Session Management

SONAR supports parallel engagements through a two-layer tracking system:

- **Global registry** (`~/.claude/.sonar-registry.md`) lists all active engagements with their folder paths, current phase, and status.
- **Per-engagement state** (`.sonar-state.md` inside each engagement folder) stores subject, current phase, and timestamps. Enables cross-skill handover within an engagement.

---

## Why It Works Better Than "Just Ask AI What to Automate"

Asking an LLM "what should I automate?" produces generic advice: automate your email, use AI for content, streamline your onboarding. It's the equivalent of a doctor prescribing medicine without examining the patient.

SONAR's architecture prevents five specific failure modes:

### 1. Recommending Without Observing

Generic automation advice is based on what's *typically* automatable, not what's *actually* happening in your organization. SONAR forces a complete observation phase before any recommendations exist.

**SONAR fix:** Phase 1 maps what's real. Phase 3 can only recommend interventions on processes Phase 1 actually found.

### 2. Automating the Wrong Thing

The most visible process isn't always the most expensive. Organizations often automate what's annoying (email) while ignoring what's actually consuming margin (manual handoffs between systems that nobody notices because "that's just how it works").

**SONAR fix:** Phase 2 measures friction objectively across five dimensions. The Friction Table shows what's *actually* expensive, not what *feels* expensive.

### 3. Missing What Doesn't Exist Yet

Automation conversations focus on existing processes. But some of the highest-value AI applications are capabilities that weren't possible before: continuous monitoring, real-time synthesis, proactive alerting. You can't "automate" these because there's no manual process to replace.

**SONAR fix:** The intervention taxonomy explicitly includes "Create New" alongside "Automate" and "Augment." Phase 1's gap detection surfaces where processes *should* exist but don't.

### 4. No Prioritization Framework

Without measurement, all automation opportunities look equally appealing. Teams either cherry-pick the easiest ones (which may not matter) or tackle the most ambitious ones (which may not be feasible yet).

**SONAR fix:** Phase 3 scores every intervention on four axes and sorts them into tiers. Quick wins first, strategic investments second, future capabilities third.

### 5. No Evidence Trail

When someone asks "why did we automate X instead of Y?", there should be an answer beyond "it seemed like a good idea." Without a documented chain from observation to measurement to prioritization, automation decisions are just opinions.

**SONAR fix:** Every intervention in the roadmap traces back through the Friction Table to the Operational Map. The chain is: we observed this process → we measured this friction → we prioritized this intervention. Auditable.

---

## What Class of Problems SONAR Applies To

### Strong Fit

SONAR is designed for **organizations under margin pressure that know they need to modernize but don't know where to start.** The operational complexity is high enough that intuition alone can't identify the highest-leverage interventions.

Specific situations:

- **Agencies and professional services firms** where labor is the primary cost and utilization is the primary lever
- **Growing teams** where processes that worked at 5 people are breaking at 20
- **Post-acquisition integration** where two organizations' processes need to be rationalized
- **AI adoption planning** where leadership has mandated "use AI" but nobody knows where it'll actually help
- **Margin compression** where revenue is flat or growing slowly but costs keep rising
- **Founder-dependent operations** where the founder is the bottleneck because too many processes run through them

### Poor Fit

SONAR is the wrong tool when:

- **You already know what to automate.** If the intervention is obvious, just do it. SONAR's overhead isn't justified for a single clear automation target.
- **The organization is tiny and simple.** A 3-person team with 5 processes doesn't need a multi-phase diagnostic. Walk through it in a conversation.
- **The problem is strategic, not operational.** "Should we enter this market?" is a SEAL question (or a strategy question), not a SONAR question. SONAR assumes the business model is sound and the question is how to execute it more efficiently.
- **There are no systems to observe.** If everything runs on phone calls, sticky notes, and tribal knowledge, SONAR has nothing to read. You need to instrument before you can diagnose.
- **The problem is a single broken process.** If you know which process is broken, fix it directly. SONAR is for when you don't know where to look.

### The Decision Rule

Use SONAR when: **you know your operations need to modernize but you don't know where the highest leverage is.**

Use direct intervention when: **you already know what's broken and how to fix it.**

---

## The Complete System

| Skill | Role |
|-------|------|
| `/sonar-run` | Orchestrator: chains all phases, enforces gates |
| `/sonar-map` | Phase 1: Operational Mapping |
| `/sonar-measure` | Phase 2: Friction Measurement |
| `/sonar-prioritize` | Phase 3: Intervention Prioritization |
| `/sonar-implement` | Phase 4: Implementation Planning |
| `/sonar-review` | Critic: runs after every phase automatically |
