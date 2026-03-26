# SONAR v1.1.0

**Systematic Operational Navigation & Automation Readiness**

SONAR is a multi-phase operational diagnostics method for Claude Code that maps how work actually flows through an organization, measures what friction costs, identifies where to intervene, and produces an executable project plan.

Feed it access to your live systems. It maps every process, quantifies the operational tax on each one, tells you which interventions will reclaim the most margin, and gives you the project plan to execute against. Diagnosis through implementation, not just a report.

## How it works

```
Phase 1: Operational Mapping
Phase 2: Friction Measurement
Phase 3: Intervention Prioritization
Phase 4: Implementation Planning
```

Each phase is role-locked. The mapper can't recommend. The measurer can't prioritize. The prioritizer can't invent findings the mapper didn't surface. The implementation planner can't invent interventions the prioritizer didn't recommend. An automated critic reviews each phase before a human gate lets the next one proceed.

## What's inside

- **6 skills** that install into Claude Code
- **4 core phases** that progress from observation to measurement to prioritization to execution
- **1 orchestrator** that chains everything with quality gates
- **1 critic** that reviews every phase automatically

## Install

```bash
./install-sonar.sh
```

Or see [INSTALL.md](INSTALL.md) for details.

## Quick start

Open Claude Code in any project directory and run:

```
/sonar-run
```

The orchestrator walks you through intake, operational mapping, friction measurement, intervention prioritization, and implementation planning. For a lighter touch, run just the map:

```
/sonar-map
```

This gives you the operational map: how work actually flows, where humans are doing machine work, where processes are missing entirely. No measurement, no prioritization. Just the map.

## The core question

Every SONAR engagement starts with one question: **"Where is your margin going?"**

The answer isn't always where you think. SONAR doesn't ask people what they do. It observes what actually happens across connected systems. The gap between "how we think we work" and "how we actually work" is where the margin lives.

## How SONAR relates to SEAL

SONAR and SEAL are sibling products with different epistemic positions:

| | SEAL | SONAR |
|---|------|-------|
| **Position** | Outside-in | Inside-out |
| **Input** | Submitted evidence | Direct system observation |
| **Trust model** | Trust nothing, verify everything | Trust the data, question the patterns |
| **Core question** | "What's actually true here?" | "Where is the margin going?" |
| **Output** | Verified findings + strategic recommendations | Automation/augmentation roadmap + project plan |

SEAL is a forensic auditor working from documents. SONAR is an operational diagnostician with direct access to the patient. They can inform each other but neither requires the other.

## Read more

[SONAR-Method.md](SONAR-Method.md) is the full methodology document covering the architecture, all four phases, failure modes SONAR prevents, and the taxonomy of interventions.

## Requirements

- [Claude Code](https://claude.ai/claude-code) (Anthropic's CLI)
- Claude Max or Team subscription
- macOS or Linux (Windows: use WSL)

## License

MIT. See [LICENSE](LICENSE).
