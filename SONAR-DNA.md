# SONAR DNA: Intellectual Lineage

SONAR didn't emerge from nothing. Each phase draws from established bodies of work in operations research, industrial engineering, and organizational theory — then recombines them into something none of those traditions could produce on their own.

This document maps where SONAR's ideas come from, where they diverge, and why the combination matters.

---

## Phase 1: Operational Mapping

### The Steam Era Floorplan

Before electrification, factories were designed around a single constraint: proximity to the steam engine. A massive central engine drove iron line shafts running the length of each floor. Leather belts transmitted power from shaft to machine. Every machine had to cluster near the power source. Reorganizing the floor meant physically relocating and reconnecting equipment.

When electricity arrived, the first adopters made a predictable mistake: they replaced the steam engine with an electric motor and left everything else the same. Same floorplan. Same belt system. Same clustered machines. Paul David documented the result — a 40-year "productivity paradox" where the new technology barely moved the needle.

The breakthrough came from manufacturers who asked a different question. Not "how can electricity do what steam did faster?" but "what becomes possible now that wasn't possible before?" The answer was unit-drive — individual motors on each machine. No more shafts. No more belts. Machines could go anywhere. Floors could be redesigned around workflow instead of power transmission. The result: 30-40% productivity gains over the bolt-on adopters. Same technology, completely different outcome.

**SONAR Phase 1 is a Steam Era Floorplan detector.** It maps whether an organization's operations are still designed around constraints that no longer exist — manual handoffs that persist because "that's how we've always done it," processes clustered around a single person because they used to be the only one who could do it, workflows shaped by tool limitations from three generations of software ago. The map reveals the invisible architecture that nobody questions because it was built to solve a problem that may no longer be the problem.

### Lineage

**Value Stream Mapping (Lean / Toyota Production System).** Taiichi Ohno and Shigeo Shingo developed value stream mapping to visualize the flow of materials and information through a production process. SONAR's process inventory — trigger, actors, systems, handoffs, output, frequency — is a direct descendant.

*Where SONAR diverges:* Value stream mapping was designed for manufacturing lines where the physical flow is visible. It relies heavily on direct observation of people moving through a space. SONAR maps knowledge work where the "flow" is invisible — it lives in task assignments, Slack threads, email chains, and calendar entries across disconnected systems. The observation source is digital systems, not a factory walkthrough.

**Process Mining (Wil van der Aalst, TU Eindhoven).** Process mining extracts actual process flows from event logs in enterprise systems — typically ERP, CRM, or workflow tools. It reconstructs what actually happens rather than what the process documentation says happens.

*Where SONAR diverges:* Process mining requires structured event logs from instrumented systems and typically works within a single enterprise platform. SONAR works across the fragmented ecosystem of a mid-market company — ClickUp tasks, Slack messages, Google Calendar blocks, Stripe transactions, email — where no single system has the complete picture. SONAR synthesizes process reality from the seams between systems, not from the logs within one.

**The Putting-Out System (Pre-Industrial Organization).** Before factories, manufacturing operated through the putting-out system — merchants coordinated production across dispersed households, each working independently. It worked until scale demanded tighter coordination than the system could provide. SONAR's gap detection — identifying processes that are informal, tribal, or orphaned — echoes the recognition that coordination models have structural ceilings.

*Where SONAR diverges:* The historical insight is context, not method. But it shapes SONAR's posture: the mapper isn't looking for broken processes. It's looking for coordination models that worked at one scale and are failing at the current one.

---

## Phase 2: Friction Measurement

### The Five Friction Dimensions and Their Ancestors

Each of SONAR's five friction dimensions has a distinct intellectual ancestor. None of those ancestors tried to combine all five into a single measurement framework.

**1. Time Friction → Lead Time and Cycle Time (Lean Manufacturing)**

Lean distinguishes between *cycle time* (how long the work takes) and *lead time* (how long the customer waits). The gap between them is waste. SONAR's Time Friction captures the same gap: a 10-minute task that takes 3 days because it's sitting in someone's queue. The friction isn't in the doing — it's in the waiting.

*Where SONAR diverges:* Lean measures time friction on a single production line. SONAR measures it across a web of interconnected knowledge-work processes where "waiting in a queue" looks like a Slack message nobody responded to for two days.

**2. Touch Friction → Handoff Analysis (Theory of Constraints, Goldratt)**

Eliyahu Goldratt's Theory of Constraints identifies bottlenecks — the single point that limits system throughput. SONAR's Touch Friction is a cousin: every person who touches a process is a potential bottleneck, delay, context-loss, or decision point. A process that requires five approvals for what one person could decide has high touch friction regardless of how fast each individual approval is.

*Where SONAR diverges:* TOC looks for *the* constraint — singular. Touch Friction measures the cumulative drag of *all* handoffs in a process, even when no single handoff is the bottleneck. Sometimes the problem isn't one chokepoint; it's death by a thousand touches.

**3. System Friction → Transaction Cost Economics (Ronald Coase)**

Coase's 1937 insight was that firms exist because market transactions have costs — finding suppliers, negotiating contracts, enforcing agreements. Inside a firm, these coordination costs are lower but never zero. SONAR's System Friction measures the modern version: every time a process crosses from one software system to another, there's a transaction cost — manual re-entry, context loss, format conversion, integration failure, or a person serving as a human API between two tools that don't talk to each other.

*Where SONAR diverges:* Coase was theorizing about firm boundaries. SONAR operationalizes the insight: it counts system boundaries within a single organization and measures what each crossing actually costs. The firm's internal transaction costs are now visible in the tool stack.

**4. Repetition Friction → Frequency-Weighted Waste (Six Sigma)**

Six Sigma's DMAIC methodology measures defect frequency to prioritize improvement efforts. A defect that occurs once is different from one that occurs a thousand times. SONAR applies the same logic to friction: a manual-repetitive process that runs weekly burns more total capacity than one that runs quarterly, even if each individual occurrence is identical.

*Where SONAR diverges:* Six Sigma was built for manufacturing defects with statistical distributions. SONAR applies frequency-weighting to knowledge-work friction, where the "defects" are invisible time sinks that nobody tracks because each individual occurrence seems trivial.

**5. Error Friction → Cost of Poor Quality (Joseph Juran)**

Juran's Cost of Poor Quality (COPQ) framework separates failure costs into internal (rework, scrap, retesting) and external (returns, complaints, warranty claims). SONAR's Error Friction captures the same insight for operational processes: how often does this process fail, produce wrong output, or require rework? The hidden cost isn't just the error — it's the recovery.

*Where SONAR diverges:* COPQ was designed for product quality in manufacturing. SONAR measures operational error rates — a proposal that goes out with wrong numbers, an onboarding that misses a step, a report that has to be regenerated because someone pulled from the wrong data source.

### The Friction Tax: What's Original

No existing framework combines all five dimensions into a single composite metric. Lean measures time. TOC finds bottlenecks. Coase theorizes about transaction costs. Six Sigma counts defects. Juran prices poor quality.

SONAR's **Friction Tax** — the estimated percentage of total operational capacity consumed by friction rather than production — is the synthesis. It makes an abstract problem tangible: "37% of your operational capacity is friction, not output." That number doesn't come from any single ancestor. It comes from measuring all five dimensions simultaneously and weighting by observed frequency.

---

## Phase 3: Intervention Prioritization

### The Intervention Taxonomy: Automate / Augment / Create New

**Automate and Augment → Thomas Davenport's Process Innovation**

Davenport (1993) distinguished between *automating* (replacing human effort with technology) and *informating* (using technology to make human effort more effective). Shoshana Zuboff's earlier work at Harvard made a similar distinction. SONAR's Automate and Augment categories are direct descendants.

*Where SONAR diverges:* Davenport and Zuboff were writing about enterprise IT in the 1990s. Their "informate" category assumed humans remained central — technology just gave them better information. SONAR's "Augment" is broader: AI can draft the deliverable, not just surface data about it.

**Create New → No Direct Ancestor**

This is the most distinctive element in SONAR's taxonomy. Every historical framework for operational improvement assumes you're making existing processes better. SONAR explicitly includes a third category: capabilities that didn't exist before because they weren't feasible without AI.

Continuous project health monitoring. Real-time synthesis across communication channels. Proactive anomaly detection in client accounts. These aren't "automating" a manual process — there was no manual process to automate. No human could watch all projects simultaneously. The capability is new.

The closest intellectual neighbor is Clayton Christensen's *jobs to be done* theory — looking at what the customer is trying to accomplish rather than what the current product does. But Christensen was analyzing markets, not operations. SONAR applies the same logic internally: what job does the organization need done that nobody is doing because it was never humanly possible?

### The Prioritization Scoring

**RICE Scoring (Intercom)**

Sean McAllister at Intercom developed RICE — Reach, Impact, Confidence, Effort — to prioritize product features. SONAR's four scoring axes (Friction Recovered, Implementation Complexity, Risk of Inaction, Cascade Potential) borrow the structure: multi-axis scoring that forces explicit trade-offs instead of gut feel.

*Where SONAR diverges:* RICE was built for product roadmaps. SONAR's axes are calibrated for operational interventions:
- **Friction Recovered** replaces "Reach" — it's not about how many users are affected, but how much measurable friction disappears.
- **Risk of Inaction** has no RICE equivalent — it captures the cost of doing nothing, which is critical for operational decisions where "leave it alone" is always an option.
- **Cascade Potential** has no RICE equivalent — it captures whether an intervention unlocks other interventions, creating a sequence that matters.

**Tiered Roadmap → Wardley Mapping (Simon Wardley)**

Wardley Maps classify components by evolution stage (Genesis → Custom → Product → Commodity) to decide where to invest. SONAR's three tiers — Quick Wins, Strategic Investments, Future Capabilities — apply similar staging logic but to interventions rather than components. Quick Wins are commodity-like (proven, low-risk, just do them). Future Capabilities are genesis-like (novel, uncertain, high potential).

*Where SONAR diverges:* Wardley Maps are strategic analysis tools for market positioning. SONAR's tiers are execution sequencing — what to do this month, this quarter, and this year.

---

## The Architectural Constraint: What Makes SONAR More Than Its Parts

The individual frameworks above are all publicly available. Anyone can read Lean, TOC, Coase, Juran, Davenport, and Wardley. What they can't do is use them together, because each tradition has its own vocabulary, its own unit of analysis, and its own blind spots.

SONAR's architectural contribution is the **phase lock**:

- The mapper can observe but cannot recommend. This prevents the Value Stream Mapping failure mode where the person drawing the map already has a solution in mind and unconsciously warps the map to justify it.
- The measurer can quantify but cannot prioritize. This prevents the Six Sigma failure mode where measurement becomes an end in itself, or where the measurer optimizes for what's measurable rather than what matters.
- The prioritizer can rank but cannot invent processes the mapper didn't find. This prevents the consulting failure mode where recommendations are based on what the consultant knows how to do rather than what the organization actually needs.

Each phase constrains the next. The chain from observation → measurement → prioritization is auditable. Every recommendation traces back through a friction score to an observed process. No opinions. No "best practices." No generic advice.

This is what the steam-era factory owners eventually learned: the technology isn't the hard part. The hard part is seeing the floorplan you're standing on and recognizing it was designed for constraints that no longer exist. SONAR makes the invisible floorplan visible — then measures what it costs — then shows you where to redraw it.

---

## Summary of Lineage

| SONAR Element | Primary Ancestor | Secondary Influences | What's Original |
|---|---|---|---|
| Process Inventory | Value Stream Mapping (Ohno, Shingo) | Process Mining (van der Aalst) | Cross-system synthesis from fragmented tool stacks |
| Flow Classification | Lean waste categories | — | Four-type taxonomy calibrated for AI-era interventions |
| Gap Detection | Putting-out system coordination failure | Christensen's JTBD | Identifying missing capabilities, not just broken processes |
| Time Friction | Lead Time / Cycle Time (Lean) | — | Applied to invisible knowledge-work queues |
| Touch Friction | Theory of Constraints (Goldratt) | — | Cumulative handoff drag, not single bottleneck |
| System Friction | Transaction Cost Economics (Coase) | — | Operationalized as tool-boundary crossing costs |
| Repetition Friction | Frequency-weighted waste (Six Sigma) | — | Applied to untracked knowledge-work patterns |
| Error Friction | Cost of Poor Quality (Juran) | — | Operational error rates, not product defect rates |
| Friction Tax | *No single ancestor* | All five dimensions | Composite metric: % of capacity consumed by friction |
| Automate / Augment | Process Innovation (Davenport), Informate (Zuboff) | — | Updated for AI capability, not just IT |
| Create New | *No direct ancestor* | Jobs to Be Done (Christensen) | Entirely new: capabilities that weren't previously feasible |
| Prioritization Scoring | RICE (Intercom) | — | Rebuilt around operational friction + cascade potential |
| Tiered Roadmap | Wardley Mapping evolution stages | — | Execution sequencing, not market positioning |
| Phase Lock Architecture | *No direct ancestor* | Scientific method (observe → measure → conclude) | Constraint system preventing premature recommendation |
| Steam Era Floorplan | Electrification productivity paradox (Paul David) | Bolt-on vs Redesign pattern | Central diagnostic metaphor for invisible operational debt |
