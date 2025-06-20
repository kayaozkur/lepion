# add-frontmatter.sh

**Purpose**: Automatically adds YAML frontmatter to markdown files

**Location**: `shell/script/add-frontmatter.sh`

**Usage**: `./add-frontmatter.sh [directory] [file_pattern]`

**Key Features**:
- Intelligently extracts titles from H1 headings or filenames
- Generates contextual descriptions based on filename patterns
- Categorizes documents automatically (CLI, API, security, etc.)
- Creates relevant tags for better organization
- Skips files that already have frontmatter
- Supports environment variable overrides

**Default Configuration**:
- Author: "Doppler Team"
- Version: "1.0"
- Date: Current date

**Output**: Adds structured YAML frontmatter with title, description, category, type, tags, date, author, and version fields to markdown files.