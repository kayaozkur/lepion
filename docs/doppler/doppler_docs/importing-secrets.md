---
title: "Importing Secrets into Doppler"
description: "Complete guide to migrating existing secrets to Doppler using dashboard import, CLI upload, scripted imports, API integration, and sync imports"
category: "secrets-management"
type: "guide"
tags: ["doppler", "import", "migration", "secrets", "cli", "api", "dashboard"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Importing Secrets into Doppler

## Overview

Migrating existing secrets to Doppler can be accomplished through multiple methods, from simple file uploads to automated scripts for complex migrations. Choose the approach that best fits your current setup and scale.

## Import Methods Comparison

| Method | Best For | Effort | Scale |
|--------|----------|--------|-------|
| Dashboard Import | Small projects | Low | < 50 secrets |
| CLI Upload | .env files | Low | < 100 secrets |
| Scripted Import | Large migrations | Medium | Unlimited |
| API Integration | Complex systems | High | Unlimited |
| Sync Import | Supported services | Low | Varies |

## 1. Dashboard Import

The quickest method for small projects with few secrets.

### Steps
1. Create a new project in Doppler
2. Select the environment (e.g., `dev`, `staging`, `production`)
3. Click the dropdown arrow next to "Add Secret"
4. Select "Import Secrets"
5. Paste your secrets in the supported format
6. Click "Import"

### Supported Formats

#### .env Format
```bash
# Basic key-value pairs
API_KEY=sk_live_abc123
DATABASE_URL=postgresql://user:pass@host:5432/db
REDIS_URL=redis://localhost:6379

# Multi-line values (use quotes)
CERTIFICATE="-----BEGIN CERTIFICATE-----
MIIDXTCCAkWgAwIBAgIJAKl...
-----END CERTIFICATE-----"
```

#### JSON Format
```json
{
  "API_KEY": "sk_live_abc123",
  "DATABASE_URL": "postgresql://user:pass@host:5432/db",
  "REDIS_URL": "redis://localhost:6379",
  "FEATURE_FLAGS": {
    "new_ui": true,
    "beta_features": false
  }
}
```

#### YAML Format
```yaml
API_KEY: sk_live_abc123
DATABASE_URL: postgresql://user:pass@host:5432/db
REDIS_URL: redis://localhost:6379
FEATURE_FLAGS:
  new_ui: true
  beta_features: false
```

## 2. CLI File Upload

Import existing configuration files directly via CLI.

### Basic Upload
```bash
# Upload .env file
doppler secrets upload .env

# Upload to specific config
doppler secrets upload .env.production --config production

# Upload JSON file
doppler secrets upload secrets.json

# Upload YAML file
doppler secrets upload config.yaml
```

### Handling Different Environments
```bash
# Upload multiple environment files
for env in dev staging production; do
  doppler secrets upload .env.$env --config $env
done
```

### Preview Before Upload
```bash
# Dry run to see what would be imported
doppler secrets upload .env --dry-run

# Compare with existing secrets
doppler secrets download --no-file --format env > current.env
diff current.env .env
```

## 3. Scripted Migration

For large-scale migrations from other secret management systems.

### From AWS Secrets Manager

```bash
#!/bin/bash
# migrate-from-aws.sh

# Configuration
AWS_REGION="us-east-1"
DOPPLER_PROJECT="my-project"
DOPPLER_CONFIG="production"

# Fetch secrets from AWS
echo "Fetching secrets from AWS Secrets Manager..."
aws secretsmanager list-secrets --region $AWS_REGION --query 'SecretList[*].Name' --output text | while read -r secret_name; do
  # Get secret value
  secret_value=$(aws secretsmanager get-secret-value --region $AWS_REGION --secret-id "$secret_name" --query 'SecretString' --output text)
  
  # Convert secret name to uppercase with underscores
  doppler_key=$(echo "$secret_name" | tr '[:lower:]' '[:upper:]' | tr '-' '_' | tr '/' '_')
  
  # Set in Doppler
  echo "Importing $secret_name as $doppler_key"
  echo "$secret_value" | doppler secrets set "$doppler_key" --project "$DOPPLER_PROJECT" --config "$DOPPLER_CONFIG"
done

echo "Migration complete!"
```

### From HashiCorp Vault

```bash
#!/bin/bash
# migrate-from-vault.sh

# Configuration
VAULT_ADDR="https://vault.example.com"
VAULT_PATH="secret/myapp"
DOPPLER_PROJECT="my-project"

# Login to Vault
vault login -method=token

# Function to recursively fetch secrets
fetch_secrets() {
  local path=$1
  
  # List secrets at path
  vault kv list -format=json "$path" 2>/dev/null | jq -r '.[]' | while read -r item; do
    if [[ "$item" == */ ]]; then
      # Recursive call for directories
      fetch_secrets "${path}${item}"
    else
      # Fetch secret
      secret_json=$(vault kv get -format=json "${path}${item}")
      
      # Extract key-value pairs
      echo "$secret_json" | jq -r '.data.data | to_entries | .[]' | while IFS= read -r entry; do
        key=$(echo "$entry" | jq -r '.key' | tr '[:lower:]' '[:upper:]')
        value=$(echo "$entry" | jq -r '.value')
        
        # Set in Doppler
        echo "Importing $key"
        echo "$value" | doppler secrets set "$key" --project "$DOPPLER_PROJECT" --config production
      done
    fi
  done
}

# Start migration
fetch_secrets "$VAULT_PATH"
```

### From GitHub Secrets

```yaml
# .github/workflows/export-secrets.yml
name: Export GitHub Secrets to Doppler

on:
  workflow_dispatch:

jobs:
  export:
    runs-on: ubuntu-latest
    steps:
    - name: Install Doppler CLI
      run: |
        curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo apt-key add -
        echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list
        sudo apt-get update && sudo apt-get install doppler
    
    - name: Export Secrets
      env:
        DOPPLER_TOKEN: ${{ secrets.DOPPLER_IMPORT_TOKEN }}
      run: |
        # Create JSON from GitHub secrets
        cat > secrets.json << EOF
        {
          "GITHUB_API_KEY": "${{ secrets.API_KEY }}",
          "GITHUB_DATABASE_URL": "${{ secrets.DATABASE_URL }}",
          "GITHUB_REDIS_URL": "${{ secrets.REDIS_URL }}"
        }
        EOF
        
        # Upload to Doppler
        doppler secrets upload secrets.json
```

## 4. Bulk Import Patterns

### CSV Import Script
```python
#!/usr/bin/env python3
# import-from-csv.py

import csv
import subprocess
import sys

def import_secrets(csv_file, project, config):
    """Import secrets from CSV file to Doppler"""
    with open(csv_file, 'r') as file:
        reader = csv.DictReader(file)
        
        for row in reader:
            key = row['key'].upper().replace('-', '_')
            value = row['value']
            environment = row.get('environment', config)
            
            # Set secret in Doppler
            cmd = [
                'doppler', 'secrets', 'set',
                key,
                '--project', project,
                '--config', environment
            ]
            
            process = subprocess.Popen(
                cmd,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            stdout, stderr = process.communicate(input=value)
            
            if process.returncode == 0:
                print(f"✓ Imported {key} to {environment}")
            else:
                print(f"✗ Failed to import {key}: {stderr}")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python import-from-csv.py <csv_file> <project> <config>")
        sys.exit(1)
    
    import_secrets(sys.argv[1], sys.argv[2], sys.argv[3])
```

### Excel/Spreadsheet Import
```python
#!/usr/bin/env python3
# import-from-excel.py

import pandas as pd
import subprocess

def import_from_excel(excel_file, sheet_name, project):
    """Import secrets from Excel file to Doppler"""
    # Read Excel file
    df = pd.read_excel(excel_file, sheet_name=sheet_name)
    
    # Group by environment
    for env in df['environment'].unique():
        env_secrets = df[df['environment'] == env]
        
        # Create temporary JSON file
        secrets_dict = {}
        for _, row in env_secrets.iterrows():
            key = row['secret_name'].upper().replace('-', '_')
            secrets_dict[key] = row['secret_value']
        
        # Upload to Doppler
        import json
        with open(f'temp_{env}.json', 'w') as f:
            json.dump(secrets_dict, f)
        
        subprocess.run([
            'doppler', 'secrets', 'upload',
            f'temp_{env}.json',
            '--project', project,
            '--config', env
        ])
        
        # Cleanup
        import os
        os.remove(f'temp_{env}.json')
        
        print(f"Imported {len(secrets_dict)} secrets to {env}")

# Usage
import_from_excel('secrets.xlsx', 'Sheet1', 'my-project')
```

## 5. Migration Best Practices

### Pre-Migration Checklist

1. **Audit Current Secrets**
   ```bash
   # List all environment variables
   env | grep -E '^[A-Z_]+=' > current-secrets.env
   
   # Count secrets
   wc -l current-secrets.env
   ```

2. **Clean Up Secret Names**
   ```bash
   # Convert to Doppler naming convention
   sed -i 's/-/_/g' secrets.env
   sed -i 's/[a-z]/\U&/g' secrets.env
   ```

3. **Identify Secret Types**
   - Simple strings
   - Multi-line values (certificates, keys)
   - JSON objects
   - Base64 encoded values

### Migration Script Template

```bash
#!/bin/bash
# migrate-template.sh

set -e  # Exit on error

# Configuration
SOURCE_FILE="${1:-secrets.env}"
DOPPLER_PROJECT="${2:-my-project}"
DOPPLER_CONFIG="${3:-development}"

echo "Starting migration from $SOURCE_FILE to Doppler"
echo "Project: $DOPPLER_PROJECT, Config: $DOPPLER_CONFIG"

# Backup current Doppler secrets
echo "Backing up current secrets..."
doppler secrets download \
  --project "$DOPPLER_PROJECT" \
  --config "$DOPPLER_CONFIG" \
  --format json \
  --no-file > "backup-$(date +%Y%m%d-%H%M%S).json"

# Import new secrets
echo "Importing secrets..."
doppler secrets upload "$SOURCE_FILE" \
  --project "$DOPPLER_PROJECT" \
  --config "$DOPPLER_CONFIG"

# Verify
echo "Verification:"
doppler secrets \
  --project "$DOPPLER_PROJECT" \
  --config "$DOPPLER_CONFIG" | wc -l

echo "Migration complete!"
```

### Post-Migration Validation

```bash
# Compare secret counts
echo "Source secrets: $(grep -c '^[A-Z_]' source.env)"
echo "Doppler secrets: $(doppler secrets --json | jq '. | length')"

# Verify specific secrets
doppler run -- bash -c 'env | grep "^API_KEY="'

# Test application
doppler run -- npm test
```

## 6. Common Import Scenarios

### Migrating from Heroku
```bash
# Export from Heroku
heroku config -s -a myapp > heroku-config.env

# Import to Doppler
doppler secrets upload heroku-config.env --config production
```

### Migrating from Docker Compose
```bash
# Extract from docker-compose.yml
yq eval '.services.*.environment' docker-compose.yml | \
  grep -E '^\s*[A-Z_]+=' | \
  sed 's/^\s*//' > docker-secrets.env

# Import to Doppler
doppler secrets upload docker-secrets.env
```

### Migrating from Kubernetes
```bash
# Export from ConfigMap
kubectl get configmap myapp-config -o json | \
  jq -r '.data | to_entries | .[] | "\(.key)=\(.value)"' > k8s-config.env

# Export from Secret
kubectl get secret myapp-secret -o json | \
  jq -r '.data | to_entries | .[] | "\(.key)=\(.value | @base64d)"' > k8s-secrets.env

# Combine and import
cat k8s-config.env k8s-secrets.env | doppler secrets upload
```

## 7. Troubleshooting Import Issues

### Common Problems

1. **Invalid Secret Names**
   ```bash
   # Fix naming issues
   sed -i 's/[^A-Z0-9_]/_/g' secrets.env
   ```

2. **Encoding Issues**
   ```bash
   # Convert to UTF-8
   iconv -f ISO-8859-1 -t UTF-8 secrets.env > secrets-utf8.env
   ```

3. **Large Secrets**
   ```bash
   # Split large files
   split -l 50 large-secrets.env part-
   for file in part-*; do
     doppler secrets upload "$file"
   done
   ```

4. **Duplicate Keys**
   ```bash
   # Remove duplicates (keep last occurrence)
   tac secrets.env | awk '!seen[$1]++' | tac > unique-secrets.env
   ```

### Import Verification Script

```bash
#!/bin/bash
# verify-import.sh

# Check for missing secrets
comm -23 <(grep -oE '^[A-Z_]+=' source.env | cut -d= -f1 | sort) \
         <(doppler secrets --json | jq -r 'keys[]' | sort) > missing.txt

if [ -s missing.txt ]; then
  echo "Missing secrets:"
  cat missing.txt
else
  echo "All secrets imported successfully!"
fi
```