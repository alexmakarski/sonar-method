#!/bin/bash
# SONAR Installer
# Copies all SONAR skills into your Claude Code skills directory.
# Run from the folder containing this script.

set -e

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/skills"

# Check source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: No 'skills/' folder found next to this script."
    echo "Expected: $SOURCE_DIR"
    echo "Make sure you're running this from the SONAR distribution folder."
    exit 1
fi

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Count what we're installing
SKILL_COUNT=$(find "$SOURCE_DIR" -maxdepth 1 -type d | tail -n +2 | wc -l | tr -d ' ')

echo ""
echo "SONAR Installer"
echo "==============="
echo ""
echo "Systematic Operational Navigation & Automation Readiness"
echo ""
echo "Source:      $SOURCE_DIR"
echo "Destination: $SKILLS_DIR"
echo "Skills:      $SKILL_COUNT"
echo ""

# Check for existing installs
EXISTING=0
for skill_dir in "$SOURCE_DIR"/sonar-*; do
    skill_name=$(basename "$skill_dir")
    if [ -d "$SKILLS_DIR/$skill_name" ]; then
        EXISTING=$((EXISTING + 1))
    fi
done

if [ "$EXISTING" -gt 0 ]; then
    echo "WARNING: $EXISTING existing SONAR skill(s) found. They will be overwritten."
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# Copy skills
echo "Installing..."
for skill_dir in "$SOURCE_DIR"/sonar-*; do
    skill_name=$(basename "$skill_dir")
    echo "  $skill_name"
    rm -rf "$SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$SKILLS_DIR/$skill_name"
done

echo ""
echo "Done. $SKILL_COUNT SONAR skills installed to $SKILLS_DIR"
echo ""
echo "To verify, open Claude Code and type: /sonar-run"
echo ""
