# add-frontmatter.sh Documentation

## Overview

The `add-frontmatter.sh` script is a Bash utility designed to automatically add YAML frontmatter to markdown files. It intelligently analyzes markdown files and generates appropriate metadata based on filename patterns and content analysis.

## Location

```
shell/script/add-frontmatter.sh
```

## Usage

### Basic Syntax

```bash
./add-frontmatter.sh [directory] [file_pattern]
```

### Parameters

- **directory**: Target directory to search for markdown files (default: current directory)
- **file_pattern**: File pattern to match (default: `*.md`)

### Options

- `-h, --help`: Display help message and usage information

## Examples

```bash
# Process all .md files in current directory
./add-frontmatter.sh

# Process all .md files in docs directory
./add-frontmatter.sh ./docs

# Process specific pattern in docs directory
./add-frontmatter.sh ./docs "guide-*.md"
```

## Configuration

### Default Values

- **Author**: "Doppler Team"
- **Version**: "1.0"
- **Date**: Current date (YYYY-MM-DD format)

### Environment Variable Overrides

You can customize the default values using environment variables:

```bash
export FRONTMATTER_AUTHOR="Your Name"
export FRONTMATTER_VERSION="2.0"
export FRONTMATTER_DATE="2024-01-01"
./add-frontmatter.sh
```

## Generated Frontmatter Structure

The script generates YAML frontmatter with the following fields:

```yaml
---
title: "Document Title"
description: "Generated description"
category: "document-category"
type: "document-type"
tags: ["tag1", "tag2", "tag3"]
date: 2024-01-01
author: "Doppler Team"
version: "1.0"
---
```

## Intelligent Content Analysis

### Title Extraction

1. **Primary**: Extracts from first H1 heading (`# Title`)
2. **Fallback**: Uses filename with formatting (removes hyphens, capitalizes words)

### Description Generation

The script generates contextual descriptions based on filename patterns:

- `getting-started`, `quick-start` → "Quick start guide for new users"
- `installation`, `install` → "Installation and setup guide"
- `cli`, `command` → "Command-line interface guide and reference"
- `api`, `sdk` → "API and SDK integration guide"
- `security`, `access` → "Security features and access control guide"
- `troubleshooting`, `debug` → "Troubleshooting guide and common issues"
- `integration` → "Integration guide for third-party platforms"
- `advanced` → "Advanced features and configuration options"
- `cheat`, `reference` → "Quick reference guide"
- `guide` → "Comprehensive guide and best practices"
- `overview` → "Overview and introduction"
- `README` → "Project documentation and overview"

### Category Classification

Documents are automatically categorized:

- `getting-started`: Overview and introduction content
- `installation`: Setup and installation guides
- `cli-reference`: Command-line interface documentation
- `api-integration`: API and SDK documentation
- `security`: Security and access control
- `troubleshooting`: Problem-solving guides
- `integration`: Third-party integrations
- `advanced`: Advanced features
- `secrets-management`: Secret-related functionality
- `project-management`: Project organization
- `guides`: General guides
- `documentation`: General documentation
- `general`: Default category

### Document Types

- `tutorial`: Getting started and tutorial content
- `reference`: Reference materials and cheatsheets
- `api-reference`: API documentation
- `troubleshooting`: Problem-solving guides
- `index`: README files
- `guide`: General guides (default)

### Tag Generation

The script automatically generates relevant tags based on filename patterns:

- Base tag: `doppler` (always included)
- Content-specific tags based on filename analysis
- Multiple tags can be assigned to a single document

## Features

### Safety Features

- **Duplicate Check**: Skips files that already have frontmatter
- **Backup Strategy**: Uses temporary files to prevent data loss
- **Error Handling**: Robust error handling with colored output
- **Directory Validation**: Checks directory existence before processing

### Output Features

- **Colored Console Output**: 
  - Blue for informational messages
  - Green for success messages
  - Yellow for warnings
  - Red for errors
- **Progress Tracking**: Shows processed and skipped file counts
- **Detailed Logging**: Provides clear feedback for each operation

## Technical Implementation

### Core Functions

1. **extract_title()**: Extracts document title from H1 or filename
2. **generate_description()**: Creates contextual descriptions
3. **determine_category()**: Assigns document categories
4. **determine_type()**: Determines document type
5. **generate_tags()**: Creates relevant tag arrays
6. **has_frontmatter()**: Checks for existing frontmatter
7. **add_frontmatter()**: Main processing function

### File Processing Flow

1. Validate input directory
2. Find matching files using `find` command
3. Check each file for existing frontmatter
4. Extract metadata using analysis functions
5. Generate YAML frontmatter block
6. Create temporary file with frontmatter + original content
7. Replace original file atomically
8. Report processing results

## Error Handling

The script includes comprehensive error handling:

- Directory existence validation
- File accessibility checks
- Atomic file operations using temporary files
- Graceful handling of missing H1 headings
- Safe fallbacks for all metadata generation

## Dependencies

- **Bash**: Version 4.0+ recommended
- **Standard Unix Tools**: `grep`, `sed`, `find`, `head`, `tail`, `cat`, `mv`
- **No External Dependencies**: Uses only built-in Bash and standard Unix utilities

## Best Practices

1. **Backup Important Files**: While the script uses safe temporary file operations, consider backing up important documentation before bulk processing
2. **Test on Sample Files**: Run on a small subset first to verify generated metadata meets your requirements
3. **Environment Variables**: Use environment variables for consistent author/version information across runs
4. **Pattern Specificity**: Use specific file patterns to avoid processing unintended files

## Troubleshooting

### Common Issues

1. **Permission Errors**: Ensure execute permissions on script and write permissions on target files
2. **Pattern Matching**: Use quotes around file patterns containing wildcards
3. **Directory Paths**: Use absolute paths or ensure correct working directory

### Debug Mode

For debugging, you can modify the script to add `set -x` after the shebang line to enable verbose output.

## Integration

This script is designed to work well with:

- Documentation build systems
- Static site generators that use frontmatter
- Content management workflows
- Automated documentation pipelines

## Version History

- **v1.0**: Initial release with core functionality
- Support for environment variable overrides
- Intelligent content analysis and categorization
- Comprehensive error handling and user feedback