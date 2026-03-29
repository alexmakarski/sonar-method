#!/bin/bash
# SONAR Installer
# Copies all SONAR skills and agents into your Claude Code directories.
# Run from the folder containing this script.

set -e

SKILLS_DIR="$HOME/.claude/skills"
AGENTS_DIR="$HOME/.claude/agents"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_SKILLS="$SCRIPT_DIR/skills"
SOURCE_AGENTS="$SCRIPT_DIR/agents"

# Check source exists
if [ ! -d "$SOURCE_SKILLS" ]; then
    echo "ERROR: No 'skills/' folder found next to this script."
    echo "Expected: $SOURCE_SKILLS"
    echo "Make sure you're running this from the SONAR distribution folder."
    exit 1
fi

# Create directories if they don't exist
mkdir -p "$SKILLS_DIR"
mkdir -p "$AGENTS_DIR"

# Count what we're installing
SKILL_COUNT=$(find "$SOURCE_SKILLS" -maxdepth 1 -type d | tail -n +2 | wc -l | tr -d ' ')
AGENT_COUNT=0
if [ -d "$SOURCE_AGENTS" ]; then
    AGENT_COUNT=$(find "$SOURCE_AGENTS" -maxdepth 1 -type d | tail -n +2 | wc -l | tr -d ' ')
fi

echo ""
echo "SONAR Installer"
echo "==============="
echo ""
echo "Systematic Operational Navigation & Automation Readiness"
echo ""
echo "Source:      $SCRIPT_DIR"
echo "Skills dir:  $SKILLS_DIR"
echo "Agents dir:  $AGENTS_DIR"
echo "Skills:      $SKILL_COUNT"
echo "Agents:      $AGENT_COUNT"
echo ""

# Check for existing installs
EXISTING=0
for skill_dir in "$SOURCE_SKILLS"/sonar-*; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    if [ -d "$SKILLS_DIR/$skill_name" ]; then
        EXISTING=$((EXISTING + 1))
    fi
done
if [ -d "$SOURCE_AGENTS" ]; then
    for agent_dir in "$SOURCE_AGENTS"/sonar-*; do
        [ -d "$agent_dir" ] || continue
        agent_name=$(basename "$agent_dir")
        if [ -d "$AGENTS_DIR/$agent_name" ]; then
            EXISTING=$((EXISTING + 1))
        fi
    done
fi

if [ "$EXISTING" -gt 0 ]; then
    echo "WARNING: $EXISTING existing SONAR skill(s)/agent(s) found. They will be overwritten."
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# Copy skills
echo "Installing skills..."
for skill_dir in "$SOURCE_SKILLS"/sonar-*; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    echo "  $skill_name"
    rm -rf "$SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$SKILLS_DIR/$skill_name"
done

# Copy agents
if [ -d "$SOURCE_AGENTS" ] && [ "$AGENT_COUNT" -gt 0 ]; then
    echo ""
    echo "Installing agents..."
    for agent_dir in "$SOURCE_AGENTS"/sonar-*; do
        [ -d "$agent_dir" ] || continue
        agent_name=$(basename "$agent_dir")
        echo "  $agent_name"
        rm -rf "$AGENTS_DIR/$agent_name"
        cp -r "$agent_dir" "$AGENTS_DIR/$agent_name"
    done
fi

# Clean up old sonar-review skill if it exists (now an agent)
if [ -d "$SKILLS_DIR/sonar-review" ]; then
    echo ""
    echo "Removing old sonar-review skill (replaced by agent)..."
    rm -rf "$SKILLS_DIR/sonar-review"
fi

TOTAL=$((SKILL_COUNT + AGENT_COUNT))
echo ""
echo "Done. $SKILL_COUNT skills + $AGENT_COUNT agents installed."
echo ""
echo "To verify, open Claude Code and type: /sonar-run"
echo ""
