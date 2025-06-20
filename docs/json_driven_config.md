# JSON-Driven Design System Implementation

## Overview
The `generate-mint-config.sh` script now uses a JSON-driven approach to ensure perfect consistency between brand assets and documentation colors.

## Single Source of Truth
**Design Tokens File**: `/Users/kayaozkur/Desktop/lepion/brand_assets/style_guide/design-tokens.json`

## Implementation Details

### Color Extraction
```bash
# JSON-driven design tokens (Single Source of Truth)
DESIGN_TOKENS_FILE='/Users/kayaozkur/Desktop/lepion/brand_assets/style_guide/design-tokens.json'
PRIMARY_COLOR=$(jq -r '.colors.primary.orange["500"].value' "$DESIGN_TOKENS_FILE")
LIGHT_COLOR=$(jq -r '.colors.neutral.light.primary.value' "$DESIGN_TOKENS_FILE")
DARK_COLOR=$(jq -r '.colors.neutral.dark.primary.value' "$DESIGN_TOKENS_FILE")
```

### Current Brand Colors
- **Primary**: `#f46530` (orange brand color)
- **Light**: `#ffffff` (white background)
- **Dark**: `#2a2e30` (dark background)

### Error Handling
The script validates color extraction and exits with error message if any colors fail to load from the JSON file.

### Benefits
- **Consistency**: All systems use identical colors from single JSON source
- **Maintainability**: Color changes only need to be made in one place
- **Automation**: Documentation colors update automatically when design tokens change
- **Validation**: Built-in error handling prevents invalid configurations

## Usage
Run the script normally - it will automatically extract colors from the design tokens:
```bash
./generate-mint-config.sh
```

Success output shows extracted colors:
```
✅ Using brand colors from JSON: Primary=#f46530, Light=#ffffff, Dark=#2a2e30
```