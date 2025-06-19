#!/bin/bash

# Script to add YAML frontmatter to markdown files
# Usage: ./add-frontmatter.sh [directory] [file_pattern]
# Example: ./add-frontmatter.sh . "*.md"

set -e

# Configuration
DEFAULT_AUTHOR="Doppler Team"
DEFAULT_VERSION="1.0"
DEFAULT_DATE=$(date +%Y-%m-%d)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to extract title from markdown file
extract_title() {
    local file="$1"
    # Look for the first H1 heading (# Title)
    title=$(grep -m 1 '^# ' "$file" 2>/dev/null | sed 's/^# //' | sed 's/[[:space:]]*$//' || echo "")
    if [ -z "$title" ]; then
        # Fallback to filename without extension
        title=$(basename "$file" .md | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
    fi
    echo "$title"
}

# Function to generate description based on filename and content
generate_description() {
    local file="$1"
    local filename=$(basename "$file" .md)
    
    # Try to extract description from second line or first paragraph
    local content_desc=""
    if grep -q '^## ' "$file"; then
        content_desc=$(grep -A 5 '^## ' "$file" | head -n 3 | tail -n 1 | sed 's/^[[:space:]]*//' || echo "")
    fi
    
    # Generate description based on filename patterns
    case "$filename" in
        *"getting-started"*|*"quick-start"*) echo "Quick start guide for new users" ;;
        *"installation"*|*"install"*) echo "Installation and setup guide" ;;
        *"cli"*|*"command"*) echo "Command-line interface guide and reference" ;;
        *"api"*|*"sdk"*) echo "API and SDK integration guide" ;;
        *"security"*|*"access"*) echo "Security features and access control guide" ;;
        *"troubleshooting"*|*"debug"*) echo "Troubleshooting guide and common issues" ;;
        *"integration"*) echo "Integration guide for third-party platforms" ;;
        *"advanced"*) echo "Advanced features and configuration options" ;;
        *"cheat"*|*"reference"*) echo "Quick reference guide" ;;
        *"guide"*) echo "Comprehensive guide and best practices" ;;
        *"overview"*) echo "Overview and introduction" ;;
        "README") echo "Project documentation and overview" ;;
        *) 
            if [ -n "$content_desc" ]; then
                echo "$content_desc"
            else
                echo "Documentation for $filename"
            fi
        ;;
    esac
}

# Function to determine category based on filename
determine_category() {
    local filename=$(basename "$1" .md)
    
    case "$filename" in
        *"getting-started"*|*"quick-start"*|*"overview"*) echo "getting-started" ;;
        *"installation"*|*"install"*|*"setup"*) echo "installation" ;;
        *"cli"*|*"command"*) echo "cli-reference" ;;
        *"api"*|*"sdk"*) echo "api-integration" ;;
        *"security"*|*"access"*|*"permission"*) echo "security" ;;
        *"troubleshooting"*|*"debug"*) echo "troubleshooting" ;;
        *"integration"*|*"ci"*|*"cd"*) echo "integration" ;;
        *"advanced"*|*"feature"*) echo "advanced" ;;
        *"secret"*) echo "secrets-management" ;;
        *"project"*|*"organization"*|*"workplace"*) echo "project-management" ;;
        *"guide"*) echo "guides" ;;
        "README") echo "documentation" ;;
        *) echo "general" ;;
    esac
}

# Function to determine document type
determine_type() {
    local filename=$(basename "$1" .md)
    
    case "$filename" in
        *"getting-started"*|*"tutorial"*) echo "tutorial" ;;
        *"reference"*|*"cheat"*|*"command"*) echo "reference" ;;
        *"api"*|*"sdk"*) echo "api-reference" ;;
        *"troubleshooting"*) echo "troubleshooting" ;;
        "README") echo "index" ;;
        *) echo "guide" ;;
    esac
}

# Function to generate tags based on filename and content
generate_tags() {
    local file="$1"
    local filename=$(basename "$file" .md)
    local tags=("doppler")
    
    # Add tags based on filename patterns
    case "$filename" in
        *"cli"*) tags+=("cli") ;;
        *"api"*) tags+=("api") ;;
        *"sdk"*) tags+=("sdk") ;;
        *"getting-started"*) tags+=("getting-started" "tutorial") ;;
        *"installation"*) tags+=("installation" "setup") ;;
        *"security"*) tags+=("security" "access-control") ;;
        *"troubleshooting"*) tags+=("troubleshooting" "debugging") ;;
        *"integration"*) tags+=("integration" "ci-cd") ;;
        *"advanced"*) tags+=("advanced" "features") ;;
        *"secret"*) tags+=("secrets" "secrets-management") ;;
        *"project"*) tags+=("projects" "organization") ;;
        *"command"*) tags+=("commands" "reference") ;;
        *"cheat"*) tags+=("cheatsheet" "quick-reference") ;;
    esac
    
    # Convert array to JSON format
    printf '['
    for i in "${!tags[@]}"; do
        printf '"%s"' "${tags[$i]}"
        if [ $i -lt $((${#tags[@]} - 1)) ]; then
            printf ', '
        fi
    done
    printf ']'
}

# Function to check if file already has frontmatter
has_frontmatter() {
    local file="$1"
    [ "$(head -n 1 "$file")" = "---" ]
}

# Function to add frontmatter to a file
add_frontmatter() {
    local file="$1"
    local temp_file="${file}.tmp"
    
    if has_frontmatter "$file"; then
        print_warning "File $file already has frontmatter, skipping..."
        return 0
    fi
    
    print_status "Processing $file..."
    
    # Extract information
    local title=$(extract_title "$file")
    local description=$(generate_description "$file")
    local category=$(determine_category "$file")
    local type=$(determine_type "$file")
    local tags=$(generate_tags "$file")
    
    # Create frontmatter
    cat > "$temp_file" << EOF
---
title: "$title"
description: "$description"
category: "$category"
type: "$type"
tags: $tags
date: $DEFAULT_DATE
author: "$DEFAULT_AUTHOR"
version: "$DEFAULT_VERSION"
---

EOF
    
    # Append original content
    cat "$file" >> "$temp_file"
    
    # Replace original file
    mv "$temp_file" "$file"
    
    print_success "Added frontmatter to $file"
}

# Main function
main() {
    local directory="${1:-.}"
    local pattern="${2:-*.md}"
    
    print_status "Adding YAML frontmatter to markdown files..."
    print_status "Directory: $directory"
    print_status "Pattern: $pattern"
    print_status "Date: $DEFAULT_DATE"
    print_status "Author: $DEFAULT_AUTHOR"
    print_status "Version: $DEFAULT_VERSION"
    echo
    
    # Check if directory exists
    if [ ! -d "$directory" ]; then
        print_error "Directory '$directory' does not exist!"
        exit 1
    fi
    
    # Process files
    local processed=0
    local skipped=0
    
    # Use find to locate files matching the pattern
    while IFS= read -r -d '' file; do
        if [ -f "$file" ]; then
            if has_frontmatter "$file"; then
                print_warning "Skipping $file (already has frontmatter)"
                ((skipped++))
            else
                add_frontmatter "$file"
                ((processed++))
            fi
        fi
    done < <(find "$directory" -name "$pattern" -type f -print0)
    
    echo
    print_success "Processing complete!"
    print_status "Files processed: $processed"
    print_status "Files skipped: $skipped"
}

# Help function
show_help() {
    cat << EOF
Usage: $0 [OPTIONS] [DIRECTORY] [PATTERN]

Add YAML frontmatter to markdown files in a directory.

Arguments:
    DIRECTORY    Directory to search for markdown files (default: current directory)
    PATTERN      File pattern to match (default: *.md)

Options:
    -h, --help   Show this help message

Examples:
    $0                           # Process all .md files in current directory
    $0 ./docs                    # Process all .md files in docs directory
    $0 ./docs "guide-*.md"       # Process guide-*.md files in docs directory

Environment Variables:
    FRONTMATTER_AUTHOR   Override default author (default: "$DEFAULT_AUTHOR")
    FRONTMATTER_VERSION  Override default version (default: "$DEFAULT_VERSION")
    FRONTMATTER_DATE     Override default date (default: current date)

The script automatically generates:
- title: From the first H1 heading or filename
- description: Based on filename patterns and content
- category: Determined from filename patterns
- type: Document type (guide, reference, tutorial, etc.)
- tags: Generated from filename and content analysis
EOF
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        # Override defaults with environment variables if set
        DEFAULT_AUTHOR="${FRONTMATTER_AUTHOR:-$DEFAULT_AUTHOR}"
        DEFAULT_VERSION="${FRONTMATTER_VERSION:-$DEFAULT_VERSION}"
        DEFAULT_DATE="${FRONTMATTER_DATE:-$DEFAULT_DATE}"
        
        main "$@"
        ;;
esac