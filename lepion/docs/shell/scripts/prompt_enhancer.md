# Prompt Enhancer Tool Suite Documentation

## Overview
A comprehensive collection of prompt enhancement tools that transform basic prompts into professional, structured, and actionable requests. Each version builds upon the previous one, adding specific functionality layers.

## Version Hierarchy & Features

### 🟢 BASE (`prompt-enhancer_base.sh`)
**Core Functionality**: Grammar correction and content expansion
- ✅ Grammar correction and language improvement
- ✅ Content expansion for clarity and detail
- ✅ Actionable prompt transformation
- ✅ Clean output without meta-commentary

**Use Case**: Simple prompt improvement for basic clarity and grammar

**Example Input**: `"Make my code better"`
**Example Output**: Clean, grammatically correct, expanded prompt with specific details

---

### 🔵 CORE (`prompt-enhancer_core.sh`)
**Inherits**: BASE features
**Additional Features**: XML structure organization
- ✅ All BASE functionality
- ✅ XML tag structure (`<context>`, `<requirements>`, `<output_format>`)
- ✅ Professional formatting and organization
- ✅ Structured semantic markup

**Use Case**: Professional documentation and structured prompt creation

**XML Structure**:
```xml
<context>Background and purpose</context>
<requirements>Detailed specifications</requirements>
<output_format>Expected response format</output_format>
```

---

### 🟡 PRIME (`prompt-enhancer_prime.sh`)
**Inherits**: CORE features
**Additional Features**: Methodology and user-assistant interaction flow
- ✅ All CORE functionality
- ✅ Step-by-step methodology sections
- ✅ User-Assistant interaction workflows
- ✅ Success criteria definition
- ✅ Constraint identification

**Use Case**: Complex task planning with clear execution methodology

**Enhanced XML Structure**:
```xml
<context>Background and purpose</context>
<requirements>Detailed specifications</requirements>
<methodology>Step-by-step User-Assistant interaction approach</methodology>
<output_format>Expected response format</output_format>
<success_criteria>What constitutes success</success_criteria>
```

---

### 🟠 ELITE (`prompt-enhancer_elite.sh`)
**Inherits**: PRIME features
**Additional Features**: Few-shot examples with input/output pairs
- ✅ All PRIME functionality
- ✅ 2-3 concrete few-shot examples
- ✅ Input/output demonstration pairs
- ✅ Task-specific example generation
- ✅ Enhanced learning through examples

**Use Case**: Training and demonstration scenarios requiring concrete examples

**Enhanced XML Structure**:
```xml
<context>Background and purpose</context>
<requirements>Detailed specifications</requirements>
<examples>2-3 concrete examples with input/output</examples>
<methodology>Step-by-step approach</methodology>
<output_format>Expected response format</output_format>
<success_criteria>What constitutes success</success_criteria>
```

---

### 🔴 APEX (`prompt-enhancer_apex.sh`)
**Inherits**: ELITE features
**Additional Features**: Contextually-aware dynamic placeholders
- ✅ All ELITE functionality
- ✅ **Dynamic Placeholder Generation**: Context-specific `{{variables}}` based on task type
- ✅ **Intelligent Variable Naming**: Task-relevant placeholders (not generic)
- ✅ **Adaptive Customization**: Variables that make sense for each specific prompt
- ✅ **Prefilled Response Templates**: Structure for expected outputs

**Use Case**: Advanced prompt engineering with maximum customization and adaptability

**Dynamic Placeholder Examples**:
- **Email validation**: `{{email_format}}`, `{{validation_strictness}}`, `{{error_handling_approach}}`
- **Calculator app**: `{{ui_framework}}`, `{{calculation_precision}}`, `{{supported_operations}}`  
- **Database optimization**: `{{database_type}}`, `{{query_complexity_level}}`, `{{connection_pool_size}}`
- **REST API**: `{{auth_method}}`, `{{data_format}}`, `{{rate_limiting}}`

## Usage Instructions

### Basic Usage
```bash
# Choose your version based on needs
./prompt-enhancer_base.sh "Your prompt here"     # Simple enhancement
./prompt-enhancer_core.sh "Your prompt here"     # + XML structure
./prompt-enhancer_prime.sh "Your prompt here"    # + Methodology
./prompt-enhancer_elite.sh "Your prompt here"    # + Examples
./prompt-enhancer_apex.sh "Your prompt here"     # + Dynamic placeholders
```

### Output Files
All versions save enhanced prompts with descriptive timestamps:
- `enhanced_prompt_base_YYYYMMDD_HHMMSS.txt`
- `enhanced_prompt_core_YYYYMMDD_HHMMSS.txt`
- `enhanced_prompt_prime_YYYYMMDD_HHMMSS.txt`
- `enhanced_prompt_elite_YYYYMMDD_HHMMSS.txt`
- `enhanced_prompt_YYYYMMDD_HHMMSS.txt` (apex)

## Feature Evolution Summary

| Feature | BASE | CORE | PRIME | ELITE | APEX |
|---------|------|------|-------|-------|------|
| Grammar Correction | ✅ | ✅ | ✅ | ✅ | ✅ |
| Content Expansion | ✅ | ✅ | ✅ | ✅ | ✅ |
| XML Structure | ❌ | ✅ | ✅ | ✅ | ✅ |
| Methodology Flow | ❌ | ❌ | ✅ | ✅ | ✅ |
| Success Criteria | ❌ | ❌ | ✅ | ✅ | ✅ |
| Few-Shot Examples | ❌ | ❌ | ❌ | ✅ | ✅ |
| Dynamic Placeholders | ❌ | ❌ | ❌ | ❌ | ✅ |
| Contextual Intelligence | ❌ | ❌ | ❌ | ❌ | ✅ |

## Naming Convention
- **Suffix Pattern**: `prompt-enhancer_[tier].sh`
- **Tier Progression**: `base` → `core` → `prime` → `elite` → `apex`
- **Output Pattern**: `enhanced_prompt_[tier]_[timestamp].txt`

## Implementation Details

### Architecture
- **Shell-based**: Uses bash for cross-platform compatibility
- **Claude Code Integration**: Pipes enhancement requests to Claude Code CLI
- **File-based Output**: Saves all enhanced prompts to Desktop with timestamps
- **Error Handling**: Includes basic error checking and user feedback

### Dependencies
- **Claude Code CLI**: Must be installed and accessible in PATH
- **Bash**: Standard shell environment
- **File System Access**: Write permissions to Desktop directory

## Advanced Usage Scenarios

### Development Workflow Integration
```bash
# Enhance commit messages
./prompt-enhancer_base.sh "fix bug"
# Result: "Fix critical authentication bug in user login validation system..."

# Enhance API documentation
./prompt-enhancer_elite.sh "document REST API"
# Result: Comprehensive API documentation prompt with examples and structure
```

### Team Collaboration
```bash
# Enhance requirement gathering
./prompt-enhancer_prime.sh "gather user requirements" 
# Result: Structured methodology for user requirement collection

# Enhance code review requests  
./prompt-enhancer_apex.sh "review my code"
# Result: Professional code review prompt with {{review_focus}}, {{code_quality_standards}} placeholders
```

## Future Enhancement Opportunities

### Potential Next Versions
- **QUANTUM**: Multi-modal prompt enhancement (images, code, documents)
- **FUSION**: Integration with external APIs and databases
- **NEXUS**: Team collaboration and version control integration

### Considered Features Not Yet Implemented
- **Template Library**: Pre-built prompt templates for common tasks
- **Interactive Mode**: Step-by-step prompt building wizard
- **Batch Processing**: Process multiple prompts simultaneously
- **Integration Hooks**: Direct integration with IDEs and development tools
- **Analytics**: Usage tracking and improvement suggestions

---

*Generated with Claude Code prompt enhancement workflow suite*