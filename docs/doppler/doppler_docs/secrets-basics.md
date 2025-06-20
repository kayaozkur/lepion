---
title: "Doppler Secrets Management Basics"
description: "Understand the fundamentals of secrets in Doppler including types, naming conventions, creation, editing, and basic management operations"
category: "secrets-management"
type: "guide"
tags: ["doppler", "secrets", "basics", "naming", "management", "fundamentals"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Secrets Management Basics

## What are Secrets?

Secrets in Doppler are sensitive configuration values that your applications need to function, such as:
- API keys and tokens
- Database credentials
- Encryption keys
- Feature flags
- Third-party service credentials
- Environment-specific configurations

## Secret Naming Conventions

### Requirements
- **Must contain**: Only uppercase letters, numbers, and underscores
- **Cannot start with**: Numbers
- **Valid examples**: `API_KEY`, `DATABASE_URL`, `REDIS_PORT_6379`
- **Invalid examples**: `api-key`, `1_SECRET`, `database.url`

### Best Practices
```bash
# Good naming patterns
DATABASE_URL            # Clear purpose
STRIPE_API_KEY         # Service prefix
S3_BUCKET_NAME_PROD    # Environment suffix
FEATURE_FLAG_NEW_UI    # Feature prefix

# Avoid
KEY                    # Too generic
MYSECRET              # Not descriptive
TEST123               # Unclear purpose
```

## Secret Types and Values

### Supported Value Types

Doppler supports multiple value types with validation:

| Type | Description | Example |
|------|-------------|---------|
| String | Default text value | `"api.example.com"` |
| Integer | Whole numbers | `3000` |
| Boolean | True/false values | `true` |
| JSON | Structured data | `{"key": "value"}` |
| Email | Validated email | `"[email protected]"` |
| URL | Validated URL | `"https://api.com"` |
| UUID | Unique identifier | `"550e8400-e29b-..."` |
| Date | ISO date format | `"2024-01-15"` |

### Setting Value Types
```bash
# Set with specific type
doppler secrets set PORT="3000" --type integer
doppler secrets set ENABLE_FEATURE="true" --type boolean
doppler secrets set CONFIG='{"timeout": 30}' --type json
```

## Managing Secrets

### Creating Secrets

#### Via CLI
```bash
# Interactive mode (recommended for sensitive values)
doppler secrets set API_KEY
# Enter value at prompt, won't appear in shell history

# Direct setting
doppler secrets set DATABASE_URL="postgresql://localhost:5432/myapp"

# Multiple secrets
doppler secrets set \
  NODE_ENV="production" \
  LOG_LEVEL="info" \
  PORT="3000"

# From file content
cat certificate.pem | doppler secrets set TLS_CERTIFICATE
```

#### Via Dashboard
1. Navigate to your project and environment
2. Click "Add Secret"
3. Enter name and value
4. Configure visibility and type
5. Save

### Reading Secrets

```bash
# List all secrets
doppler secrets

# Get specific secret
doppler secrets get API_KEY

# Get raw value
doppler secrets get DATABASE_URL --plain

# Get multiple secrets as JSON
doppler secrets get API_KEY DATABASE_URL --json

# Download all secrets
doppler secrets download --no-file --format env
```

### Updating Secrets

```bash
# Update existing secret
doppler secrets set API_KEY="new-value"

# Update with confirmation
doppler secrets set DATABASE_URL --no-interactive
```

### Deleting Secrets

```bash
# Delete single secret
doppler secrets delete OLD_API_KEY

# Delete multiple
doppler secrets delete TEMP_KEY TEST_VALUE

# Skip confirmation
doppler secrets delete DEPRECATED_KEY --yes
```

## Secret Visibility Levels

### 1. Unmasked
- Always visible in dashboard
- No restrictions on viewing
- Best for non-sensitive config

### 2. Masked (Default)
- Hidden by default with ****
- Click to reveal in dashboard
- Good balance of security and usability

### 3. Restricted
- Never visible in dashboard after saving
- Only accessible via service tokens
- Maximum security for sensitive values

```bash
# Set visibility when creating
doppler secrets set API_KEY --visibility restricted
doppler secrets set APP_NAME --visibility unmasked
```

## Secret Referencing

Reference other secrets within values using `${SECRET_NAME}` syntax.

### Same Config References
```bash
# Set base values
doppler secrets set \
  API_HOST="api.example.com" \
  API_VERSION="v2"

# Reference them
doppler secrets set \
  API_BASE_URL="https://${API_HOST}/${API_VERSION}"

# Result: API_BASE_URL = "https://api.example.com/v2"
```

### Cross-Config References
```bash
# Reference from root config
doppler secrets set \
  DATABASE_URL="${root.DATABASE_HOST}:${root.DATABASE_PORT}"

# Reference from specific config
doppler secrets set \
  API_KEY="${production.MASTER_API_KEY}"
```

### Cross-Project References
```bash
# Reference from another project
doppler secrets set \
  SHARED_SECRET="${shared-services.production.AUTH_SECRET}"
```

## Multi-line Secrets

Store certificates, private keys, and configuration files:

```bash
# Interactive mode for multi-line
doppler secrets set PRIVATE_KEY
# Paste content, press Enter, then type . on new line

# From file
cat private-key.pem | doppler secrets set PRIVATE_KEY

# Preserve formatting
doppler secrets set CONFIG_FILE < config.yaml
```

## Reserved Secrets

Doppler automatically provides these special secrets:

| Secret | Description |
|--------|-------------|
| `DOPPLER_PROJECT` | Current project identifier |
| `DOPPLER_ENVIRONMENT` | Current environment |
| `DOPPLER_CONFIG` | Current config name |

## Secret Metadata

Each secret maintains metadata:
- **Created**: Timestamp of creation
- **Modified**: Last update timestamp
- **Version**: Number of changes
- **Modified By**: User who last changed it

View in dashboard or via:
```bash
doppler activity --config production
```

## Best Practices

### 1. Naming Strategy
- Use consistent prefixes for services
- Group related secrets
- Include environment hints when needed

### 2. Value Management
- Never commit secrets to version control
- Use appropriate visibility levels
- Rotate credentials regularly

### 3. Organization
```bash
# Service prefixes
STRIPE_API_KEY
STRIPE_WEBHOOK_SECRET
STRIPE_PUBLISHABLE_KEY

# Feature flags
FEATURE_NEW_DASHBOARD
FEATURE_BETA_API
FEATURE_EXPERIMENTAL_CACHE

# Environment configs
DATABASE_URL
DATABASE_POOL_SIZE
DATABASE_TIMEOUT
```

### 4. Security
- Use restricted visibility for sensitive data
- Implement secret rotation reminders
- Audit secret access regularly
- Use service tokens for automation

## Common Patterns

### Configuration Hierarchy
```bash
# Base configuration
APP_NAME="MyApp"
LOG_LEVEL="info"

# Environment overrides
LOG_LEVEL="debug"  # In dev config
LOG_LEVEL="error"  # In prod config
```

### Feature Toggles
```bash
# Boolean flags
FEATURE_SOCIAL_LOGIN="true"
FEATURE_DARK_MODE="false"

# Percentage rollouts
FEATURE_NEW_UI_PERCENTAGE="25"
```

### External Service Configuration
```bash
# Complete service setup
REDIS_HOST="redis.example.com"
REDIS_PORT="6379"
REDIS_PASSWORD="xxx"
REDIS_URL="redis://:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}"
```