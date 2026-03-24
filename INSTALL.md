# Installing SONAR

## Prerequisites

1. **Claude Code** (Anthropic's CLI) installed and working
2. An active Claude Max or Team subscription
3. macOS or Linux (Windows: use WSL)

## Quick Install (30 seconds)

1. Download this entire SONAR folder to your computer
2. Open Terminal
3. Run:

```bash
cd /path/to/SONAR
./install-sonar.sh
```

That's it. The script copies all 5 SONAR skills into `~/.claude/skills/`.

## Manual Install

If the script doesn't work, copy each folder from `skills/` into `~/.claude/skills/`:

```bash
cp -r skills/sonar-* ~/.claude/skills/
```

## Verify It Works

Open Claude Code in any project and type:

```
/sonar-run
```

You should see the SONAR orchestrator ask for intake information. If you see "skill not found," the skills weren't copied to the right location.

## What Gets Installed

| Skill | What It Does |
|-------|-------------|
| `sonar-run` | Orchestrator: chains all phases, enforces quality gates |
| `sonar-map` | Phase 1. Maps how work actually flows through the organization |
| `sonar-measure` | Phase 2. Measures friction cost across five dimensions |
| `sonar-prioritize` | Phase 3. Ranks interventions by impact and feasibility |
| `sonar-review` | Critic. Runs after every phase automatically |

## How to Use

### Full engagement (all phases):
```
/sonar-run
```
Follow the prompts. The orchestrator will walk you through intake, operational mapping, friction measurement, and intervention prioritization, with quality reviews and approval gates between each phase.

### Quick operational scan (Phase 1 only):
```
/sonar-map
```
This gives you the Operational Map: every process inventoried, classified, and gap-checked. No measurement, no prioritization. Hand the map to your team and have the conversation.

### Individual phases:
Any skill can be run standalone. Use `/sonar-measure` on an existing map, or `/sonar-prioritize` on existing measurements.

## Updating

When a new version is released, just run `./install-sonar.sh` again. It will overwrite the existing skills.

## Troubleshooting

**"Command not found" when running the installer:**
```bash
bash install-sonar.sh
```

**Skills don't appear in Claude Code:**
Check that the files landed in the right place:
```bash
ls ~/.claude/skills/sonar-*
```
You should see 5 directories.

**Claude Code says "skill not found":**
Restart Claude Code after installing. Some versions cache the skill list on startup.
