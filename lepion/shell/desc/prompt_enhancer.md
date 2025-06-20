# Prompt Enhancer Scripts

**Purpose**: A suite of progressive prompt enhancement tools that transform basic prompts into comprehensive, structured instructions

**Location**: `shell/script/prompt/`

**Usage**: `./prompt-enhancer_[level].sh "Your original prompt here"`

## Script Levels

### **BASE** (`prompt-enhancer_base.sh`)
- **Features**: Grammar correction and content expansion
- **Output**: Simple enhanced prompt with improved clarity
- **Best for**: Quick prompt improvements

### **CORE** (`prompt-enhancer_core.sh`)
- **Features**: BASE + XML structure organization
- **Structure**: `<context>`, `<requirements>`, `<output_format>`
- **Best for**: Structured, professional prompts

### **PRIME** (`prompt-enhancer_prime.sh`)
- **Features**: CORE + methodology and success criteria
- **Added**: User-Assistant interaction flow, step-by-step approach
- **Structure**: Adds `<methodology>`, `<success_criteria>`
- **Best for**: Complex tasks requiring clear workflows

### **ELITE** (`prompt-enhancer_elite.sh`)
- **Features**: PRIME + few-shot examples
- **Added**: 2-3 concrete input/output examples
- **Structure**: Adds `<examples>` section
- **Best for**: Tasks needing demonstration examples

### **APEX** (`prompt-enhancer_apex.sh`)
- **Features**: ELITE + dynamic placeholders and templates
- **Added**: Contextually relevant `{{placeholder}}` variables, prefilled responses
- **Advanced**: Task-specific placeholders (not generic ones)
- **Best for**: Maximum customization and professional prompt engineering

## Common Features

- **Output**: Saves enhanced prompts to `~/Desktop/enhanced_prompt_[level]_[timestamp].txt`
- **Preview**: Shows first 10-25 lines of enhanced prompt
- **Integration**: Uses Claude Code for AI-powered enhancement
- **Error Handling**: Validates input and provides clear feedback

## Enhancement Progression

Each level builds upon the previous, creating increasingly sophisticated prompts:
- **Grammar & Clarity** → **Structure** → **Methodology** → **Examples** → **Dynamic Variables**