#!/bin/bash

# Prompt Enhancement Workflow Script - PRIME VERSION
# Features: Grammar correction, content expansion, XML structure + methodology/user-assistant interaction flow
# Usage: ./prompt-enhancer_prime.sh "Your original prompt here"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your original prompt here\""
    echo "Example: $0 \"Make my code better\""
    exit 1
fi

ORIGINAL_PROMPT="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="$HOME/Desktop/enhanced_prompt_prime_$TIMESTAMP.txt"

echo "🚀 Enhancing your prompt (PRIME)..."
echo "Original: $ORIGINAL_PROMPT"
echo ""

# Call Claude Code to enhance the prompt - PRIME VERSION
echo "Transform this prompt into a professional, comprehensive prompt with the following enhancements:

1. STRUCTURE: Use XML tags for clear organization (<context>, <requirements>, <methodology>, <output_format>)
2. GRAMMAR: Fix all grammatical errors and improve clarity
3. SPECIFICITY: Add specific details, requirements, and context
4. METHODOLOGY: Add a User-Assistant interaction flow with step-by-step approach
5. SUCCESS CRITERIA: Define what a successful completion looks like
6. CONSTRAINTS: Add any relevant limitations or requirements

Use this XML structure:
<context>Background and purpose</context>
<requirements>Detailed specifications</requirements>
<methodology>Step-by-step User-Assistant interaction approach</methodology>
<output_format>Expected response format</output_format>
<success_criteria>What constitutes success</success_criteria>

Output ONLY the enhanced prompt with no meta-commentary or explanations.

Original prompt: '$ORIGINAL_PROMPT'" | claude code > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Enhanced prompt saved to: $OUTPUT_FILE"
    echo ""
    echo "Preview of enhanced prompt:"
    echo "=========================="
    head -n 20 "$OUTPUT_FILE"
    echo "=========================="
else
    echo "❌ Error: Failed to enhance prompt"
    exit 1
fi