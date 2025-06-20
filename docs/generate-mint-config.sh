#!/bin/bash

# generate-mint-config.sh
# Dynamically generates mint.json based on docs directory structure

set -e

# Configuration
DOCS_DIR="${1:-.}"
OUTPUT_FILE="${2:-mint.json}"
SITE_NAME="${3:-Documentation}"

# JSON-driven design tokens (Single Source of Truth)
DESIGN_TOKENS_FILE='/Users/kayaozkur/Desktop/lepion/brand_assets/style_guide/design-tokens.json'
PRIMARY_COLOR=$(jq -r '.colors.primary.orange["500"].value' "$DESIGN_TOKENS_FILE")
LIGHT_COLOR=$(jq -r '.colors.neutral.light.primary.value' "$DESIGN_TOKENS_FILE")
DARK_COLOR=$(jq -r '.colors.neutral.dark.primary.value' "$DESIGN_TOKENS_FILE")

# Validate JSON extraction
if [[ -z "$PRIMARY_COLOR" || -z "$LIGHT_COLOR" || -z "$DARK_COLOR" ]]; then
    echo "❌ Error: Failed to extract colors from design tokens"
    echo "Check: $DESIGN_TOKENS_FILE"
    exit 1
fi

echo "✅ Using brand colors from JSON: Primary=$PRIMARY_COLOR, Light=$LIGHT_COLOR, Dark=$DARK_COLOR"

echo "🔍 Scanning directory: $DOCS_DIR"
echo "📝 Output file: $OUTPUT_FILE"
echo "🏷️  Site name: $SITE_NAME"
echo ""

# Function to convert filename to title
filename_to_title() {
    local filename="$1"
    # Remove extension and convert dashes/underscores to spaces, capitalize words
    echo "$filename" | sed 's/\.[^.]*$//' | sed 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1'
}

# Function to get relative path without extension
get_page_path() {
    local file="$1"
    local base_dir="$2"
    local relative_path=$(realpath --relative-to="$base_dir" "$file" 2>/dev/null || echo "${file#$base_dir/}")
    echo "${relative_path%.*}"
}

# Start generating mint.json
cat > "$OUTPUT_FILE" << EOF
{
  "\$schema": "https://mintlify.com/schema.json",
  "name": "$SITE_NAME",
  "logo": {
    "dark": "/logo/dark.svg",
    "light": "/logo/light.svg"
  },
  "favicon": "/favicon.svg",
  "colors": {
    "primary": "$PRIMARY_COLOR",
    "light": "$LIGHT_COLOR",
    "dark": "$DARK_COLOR",
    "anchors": {
      "from": "$PRIMARY_COLOR",
      "to": "$LIGHT_COLOR"
    }
  },
  "topbarLinks": [
    {
      "name": "Support",
      "url": "mailto:support@example.com"
    }
  ],
  "topbarCtaButton": {
    "name": "Dashboard",
    "url": "https://dashboard.example.com"
  },
EOF

# Check if there are any top-level directories for tabs
HAS_DIRS=false
if find "$DOCS_DIR" -mindepth 1 -maxdepth 1 -type d -not -path "*/.*" | grep -q .; then
    HAS_DIRS=true
    echo '  "tabs": [' >> "$OUTPUT_FILE"
    
    find "$DOCS_DIR" -mindepth 1 -maxdepth 1 -type d -not -path "*/.*" | sort | while read -r dir; do
        local dirname=$(basename "$dir")
        local tab_name=$(filename_to_title "$dirname")
        echo "    {" >> "$OUTPUT_FILE"
        echo "      \"name\": \"$tab_name\"," >> "$OUTPUT_FILE"
        echo "      \"url\": \"$dirname\"" >> "$OUTPUT_FILE"
        echo "    }," >> "$OUTPUT_FILE"
    done
    
    # Remove trailing comma from last tab
    sed -i.bak '$ s/,$//' "$OUTPUT_FILE" && rm "${OUTPUT_FILE}.bak"
    echo '  ],' >> "$OUTPUT_FILE"
fi

# Add anchors
cat >> "$OUTPUT_FILE" << 'EOF'
  "anchors": [
    {
      "name": "Documentation",
      "icon": "book-open-cover",
      "url": "https://mintlify.com/docs"
    },
    {
      "name": "Community",
      "icon": "slack",
      "url": "https://mintlify.com/community"
    }
  ],
EOF

# Generate navigation
echo '  "navigation": [' >> "$OUTPUT_FILE"

# Check for introduction/getting started files in root
intro_pages=""
for intro_file in "introduction" "quickstart" "development" "getting-started" "overview" "readme"; do
    for ext in "md" "mdx"; do
        if [ -f "$DOCS_DIR/$intro_file.$ext" ]; then
            intro_pages="$intro_pages        \"$intro_file\",\n"
            break
        fi
    done
done

if [ -n "$intro_pages" ]; then
    echo '    {' >> "$OUTPUT_FILE"
    echo '      "group": "Get Started",' >> "$OUTPUT_FILE"
    echo '      "pages": [' >> "$OUTPUT_FILE"
    echo -e "${intro_pages%,\\n}" >> "$OUTPUT_FILE"
    echo '      ]' >> "$OUTPUT_FILE"
    echo '    },' >> "$OUTPUT_FILE"
fi

# Generate navigation for each top-level directory
find "$DOCS_DIR" -mindepth 1 -maxdepth 1 -type d -not -path "*/.*" | sort | while read -r dir; do
    local dirname=$(basename "$dir")
    local group_title=$(filename_to_title "$dirname")
    
    # Check if directory has any markdown files
    if ! find "$dir" -name "*.md" -o -name "*.mdx" | grep -q .; then
        continue
    fi
    
    echo "    {" >> "$OUTPUT_FILE"
    echo "      \"group\": \"$group_title\"," >> "$OUTPUT_FILE"
    echo "      \"pages\": [" >> "$OUTPUT_FILE"
    
    # Find all markdown files in this directory and subdirectories
    find "$dir" -name "*.md" -o -name "*.mdx" | sort | while read -r file; do
        local page_path=$(get_page_path "$file" "$DOCS_DIR")
        echo "        \"$page_path\"," >> "$OUTPUT_FILE"
    done
    
    # Remove trailing comma from last page
    sed -i.bak '$ s/,$//' "$OUTPUT_FILE" && rm "${OUTPUT_FILE}.bak"
    
    echo "      ]" >> "$OUTPUT_FILE"
    echo "    }," >> "$OUTPUT_FILE"
done

# Handle root-level markdown files (excluding intro files already handled)
root_files=""
find "$DOCS_DIR" -maxdepth 1 -name "*.md" -o -maxdepth 1 -name "*.mdx" | while read -r file; do
    local basename=$(basename "$file" | sed 's/\.[^.]*$//')
    
    # Skip if it's an intro file we already handled
    case "$basename" in
        introduction|quickstart|development|getting-started|overview|readme) continue ;;
    esac
    
    root_files="$root_files        \"$basename\",\n"
done

if [ -n "$root_files" ]; then
    echo '    {' >> "$OUTPUT_FILE"
    echo '      "group": "Documentation",' >> "$OUTPUT_FILE"
    echo '      "pages": [' >> "$OUTPUT_FILE"
    echo -e "${root_files%,\\n}" >> "$OUTPUT_FILE"
    echo '      ]' >> "$OUTPUT_FILE"
    echo '    },' >> "$OUTPUT_FILE"
fi

# Remove trailing comma from last navigation group
sed -i.bak '$ s/,$//' "$OUTPUT_FILE" && rm "${OUTPUT_FILE}.bak"

# Close navigation and add footer
cat >> "$OUTPUT_FILE" << 'EOF'
  ],
  "footerSocials": {
    "x": "https://x.com/yourhandle",
    "github": "https://github.com/yourusername",
    "linkedin": "https://www.linkedin.com/company/yourcompany"
  }
}
EOF

# Summary
total_md_files=$(find "$DOCS_DIR" -name "*.md" -o -name "*.mdx" | wc -l | tr -d ' ')
total_dirs=$(find "$DOCS_DIR" -mindepth 1 -maxdepth 1 -type d -not -path "*/.*" | wc -l | tr -d ' ')

echo "✅ Generated $OUTPUT_FILE successfully!"
echo "📁 Scanned directory: $DOCS_DIR"
echo "📄 Found $total_md_files markdown files"
echo "📂 Found $total_dirs top-level directories"
echo ""
echo "🚀 To preview your docs:"
echo "   npx mintlify dev"