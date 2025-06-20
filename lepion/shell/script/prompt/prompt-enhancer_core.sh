#!/bin/bash

# Prompt Enhancement Workflow Script - CORE VERSION
# Features: Grammar correction, content expansion + XML structure
# Usage: ./prompt-enhancer_core.sh "Your original prompt here"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your original prompt here\""
    echo "Example: $0 \"Make my code better\""
    exit 1
fi

ORIGINAL_PROMPT="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="$HOME/Desktop/enhanced_prompt_core_$TIMESTAMP.txt"

echo "🚀 Enhancing your prompt (CORE)..."
echo "Original: $ORIGINAL_PROMPT"
echo ""

# Call Claude Code to enhance the prompt - CORE VERSION
echo "Transform this prompt into a professional, comprehensive prompt with the following enhancements:

1. STRUCTURE: Use XML tags for clear organization (<context>, <requirements>, <output_format>)
2. GRAMMAR: Fix all grammatical errors and improve clarity
3. SPECIFICITY: Add specific details, requirements, and context

Use this XML structure:
<context>Background and purpose</context>
<requirements>Detailed specifications</requirements>
<output_format>Expected response format</output_format>

Output ONLY the enhanced prompt with no meta-commentary or explanations.

Original prompt: '$ORIGINAL_PROMPT'" | claude code > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Enhanced prompt saved to: $OUTPUT_FILE"
    echo ""
    echo "Preview of enhanced prompt:"
    echo "=========================="
    head -n 15 "$OUTPUT_FILE"
    echo "=========================="
else
    echo "❌ Error: Failed to enhance prompt"
    exit 1
fi