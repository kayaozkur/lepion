#!/bin/bash

# Prompt Enhancement Workflow Script - ELITE VERSION
# Features: Grammar correction, content expansion, XML structure, methodology + few-shot examples
# Usage: ./prompt-enhancer_elite.sh "Your original prompt here"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your original prompt here\""
    echo "Example: $0 \"Make my code better\""
    exit 1
fi

ORIGINAL_PROMPT="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="$HOME/Desktop/enhanced_prompt_elite_$TIMESTAMP.txt"

echo "🚀 Enhancing your prompt (ELITE)..."
echo "Original: $ORIGINAL_PROMPT"
echo ""

# Call Claude Code to enhance the prompt - ELITE VERSION
echo "Transform this prompt into a professional, comprehensive prompt with the following enhancements:

1. STRUCTURE: Use XML tags for clear organization (<context>, <requirements>, <examples>, <methodology>, <output_format>)
2. GRAMMAR: Fix all grammatical errors and improve clarity
3. SPECIFICITY: Add specific details, requirements, and context
4. FEW-SHOT EXAMPLES: Generate 2-3 concrete examples with input/output pairs based on the specific task
5. METHODOLOGY: Add a User-Assistant interaction flow with step-by-step approach
6. SUCCESS CRITERIA: Define what a successful completion looks like
7. CONSTRAINTS: Add any relevant limitations or requirements

Use this XML structure:
<context>Background and purpose</context>
<requirements>Detailed specifications</requirements>
<examples>2-3 concrete examples with input/output</examples>
<methodology>Step-by-step approach</methodology>
<output_format>Expected response format</output_format>
<success_criteria>What constitutes success</success_criteria>

Output ONLY the enhanced prompt with no meta-commentary or explanations.

Original prompt: '$ORIGINAL_PROMPT'" | claude code > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Enhanced prompt saved to: $OUTPUT_FILE"
    echo ""
    echo "Preview of enhanced prompt:"
    echo "=========================="
    head -n 25 "$OUTPUT_FILE"
    echo "=========================="
else
    echo "❌ Error: Failed to enhance prompt"
    exit 1
fi