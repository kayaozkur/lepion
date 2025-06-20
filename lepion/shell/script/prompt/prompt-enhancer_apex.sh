#!/bin/bash

# Prompt Enhancement Workflow Script
# Usage: ./prompt-enhancer.sh "Your original prompt here"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your original prompt here\""
    echo "Example: $0 \"Make my code better\""
    exit 1
fi

ORIGINAL_PROMPT="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="$HOME/Desktop/enhanced_prompt_$TIMESTAMP.txt"

echo "🚀 Enhancing your prompt..."
echo "Original: $ORIGINAL_PROMPT"
echo ""

# Call Claude Code to enhance the prompt
echo "Transform this prompt into a professional, comprehensive prompt with the following enhancements:

1. STRUCTURE: Use XML tags for clear organization (<context>, <requirements>, <examples>, <methodology>, <output_format>)
2. GRAMMAR: Fix all grammatical errors and improve clarity
3. SPECIFICITY: Add specific details, requirements, and context
4. DYNAMIC VALUES: Analyze the original prompt and create contextually relevant {{placeholder}} variables that are specific to this task (not generic placeholders)
5. FEW-SHOT EXAMPLES: Generate 2-3 concrete examples with input/output pairs based on the specific task
6. METHODOLOGY: Add a User-Assistant interaction flow if applicable
7. PREFILLED RESPONSES: Include example responses or templates where helpful
8. SUCCESS CRITERIA: Define what a successful completion looks like
9. CONSTRAINTS: Add any relevant limitations or requirements

IMPORTANT: Create unique, contextually relevant placeholders for each prompt based on what would actually vary in that specific task. For example:
- Email validation: {{email_format}}, {{validation_strictness}}, {{error_handling_approach}}
- Calculator app: {{ui_framework}}, {{calculation_precision}}, {{supported_operations}}
- API development: {{authentication_method}}, {{data_format}}, {{rate_limiting}}

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
    head -n 10 "$OUTPUT_FILE"
    echo "=========================="
else
    echo "❌ Error: Failed to enhance prompt"
    exit 1
fi