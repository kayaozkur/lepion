#!/bin/bash

# Prompt Enhancement Workflow Script - BASE VERSION
# Features: Grammar correction and content expansion
# Usage: ./prompt-enhancer_base.sh "Your original prompt here"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your original prompt here\""
    echo "Example: $0 \"Make my code better\""
    exit 1
fi

ORIGINAL_PROMPT="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="$HOME/Desktop/enhanced_prompt_base_$TIMESTAMP.txt"

echo "🚀 Enhancing your prompt (BASE)..."
echo "Original: $ORIGINAL_PROMPT"
echo ""

# Call Claude Code to enhance the prompt - BASE VERSION
echo "Rewrite this prompt with perfect grammar, expand it to be more detailed and specific, and make it clear and actionable. Output only the improved prompt without any preamble, explanation, or meta-commentary. Here's the prompt: '$ORIGINAL_PROMPT'" | claude code > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Enhanced prompt saved to: $OUTPUT_FILE"
    echo ""
    echo "Preview of enhanced prompt:"
    echo "=========================="
    head -n 10 "$OUTPUT_FILE"
    echo "=========================="
else
    echo "❌ Error: Failed to enhance prompt"
    exit 1
fi