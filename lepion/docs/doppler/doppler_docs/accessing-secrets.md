---
title: "Accessing Secrets in Doppler"
description: "Learn multiple methods for accessing secrets in Doppler, including environment injection, file mounting, API/SDK integration, and direct download with security considerations"
category: "secrets-management"
type: "guide"
tags: ["doppler", "secrets", "environment-variables", "api", "sdk", "security"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Accessing Secrets in Doppler

## Overview

Doppler provides multiple methods for accessing secrets, each optimized for different use cases. Choose the right method based on your security requirements and application architecture.

## Access Methods Comparison

| Method | Use Case | Security | Complexity |
|--------|----------|----------|------------|
| Environment Injection | Development, simple apps | Good | Low |
| File Mounting | Legacy apps, configs | Better | Low |
| API/SDK | Dynamic apps | Best | Medium |
| Direct Download | Debugging, migration | Caution | Low |

## 1. Environment Variable Injection

The simplest method - inject secrets directly as environment variables.

### Basic Usage
```bash
# Run application with injected secrets
doppler run -- npm start

# Specific project/config
doppler run --project api --config production -- python app.py

# Verify injection
doppler run -- env | grep API_KEY
```

### How Your App Accesses Them
```javascript
// Node.js
const apiKey = process.env.API_KEY;
const dbUrl = process.env.DATABASE_URL;

// Python
import os
api_key = os.environ.get('API_KEY')
db_url = os.environ.get('DATABASE_URL')

// Go
apiKey := os.Getenv("API_KEY")
dbUrl := os.Getenv("DATABASE_URL")
```

### Considerations
- Some system variables shouldn't be overridden
- Large secrets may hit environment size limits
- Visible in process listings on some systems

## 2. File Mounting

Mount secrets as temporary files in various formats.

### Environment File (.env)
```bash
# Mount as .env file
doppler run --mount .env -- npm start

# Custom location
doppler run --mount /tmp/.env -- python app.py

# Your app loads the .env file
# Node.js with dotenv
require('dotenv').config();
```

### JSON Format
```bash
# Mount as JSON
doppler run --mount secrets.json -- node app.js

# Access in your app
const secrets = require('./secrets.json');
const apiKey = secrets.API_KEY;
```

### YAML Format
```bash
# Mount as YAML
doppler run --mount config.yaml -- python app.py

# Python example
import yaml
with open('config.yaml', 'r') as f:
    config = yaml.safe_load(f)
    api_key = config['API_KEY']
```

### Custom Templates
```bash
# Create template file: config.tmpl
cat > config.tmpl << 'EOF'
{
  "database": {
    "host": "{{.DB_HOST}}",
    "port": {{.DB_PORT}},
    "name": "{{.DB_NAME}}"
  },
  "api": {
    "key": "{{.API_KEY}}",
    "url": "{{.API_URL}}"
  }
}
EOF

# Mount using template
doppler run --mount-template config.tmpl=config.json -- node app.js
```

### Security Features
- Files are ephemeral (deleted after process exits)
- Proper file permissions (readable only by user)
- Not written to disk on some systems

## 3. Direct Secret Retrieval

Get specific secret values when needed.

### Single Secret
```bash
# Get value for scripts
API_KEY=$(doppler secrets get API_KEY --plain)
echo "Using API key: ${API_KEY:0:4}..."

# Pipe to file
doppler secrets get CERTIFICATE --plain > cert.pem
```

### Multiple Secrets
```bash
# Get as JSON
doppler secrets get API_KEY DATABASE_URL --json

# Parse with jq
eval $(doppler secrets get API_KEY DB_URL --json | jq -r 'to_entries | .[] | "export \(.key)=\(.value)"')
```

### Download All Secrets
```bash
# As environment variables
doppler secrets download --no-file --format env

# As JSON
doppler secrets download --no-file --format json

# As YAML
doppler secrets download --no-file --format yaml

# Docker format
doppler secrets download --no-file --format docker
```

## 4. Filtering and Transformation

### Filter Secrets
```bash
# Get secrets matching pattern
doppler secrets download --no-file --format env | grep "^DATABASE_"

# With jq for JSON
doppler secrets download --no-file --format json | jq 'with_entries(select(.key | startswith("API_")))'
```

### Name Transformers
```bash
# Convert to lowercase (for some frameworks)
doppler secrets download --no-file --format env --name-transformer lowercase

# Available transformers:
# - lowercase: DATABASE_URL → database_url
# - camel: DATABASE_URL → databaseUrl  
# - pascal: DATABASE_URL → DatabaseUrl
# - snake: DATABASE-URL → database_url
```

## 5. API and SDK Access

For dynamic applications that need programmatic access.

### REST API
```bash
# Get all secrets
curl -X GET \
  "https://api.doppler.com/v3/configs/config/secrets" \
  -H "Authorization: Bearer ${DOPPLER_TOKEN}"

# Get specific secret
curl -X GET \
  "https://api.doppler.com/v3/configs/config/secret?name=API_KEY" \
  -H "Authorization: Bearer ${DOPPLER_TOKEN}"
```

### Node.js SDK
```javascript
const { DopplerClient } = require('@dopplerhq/node-sdk');

const client = new DopplerClient({ apiKey: process.env.DOPPLER_TOKEN });

// Fetch all secrets
const secrets = await client.secrets.list({ 
  project: 'api-service',
  config: 'production' 
});

// Get specific secret
const secret = await client.secrets.get({
  project: 'api-service',
  config: 'production',
  name: 'API_KEY'
});
```

### Python SDK
```python
from doppler_sdk import DopplerSDK

sdk = DopplerSDK(api_key=os.environ['DOPPLER_TOKEN'])

# Fetch all secrets
secrets = sdk.secrets.list(
    project='api-service',
    config='production'
)

# Get specific secret
secret = sdk.secrets.get(
    project='api-service',
    config='production',
    name='API_KEY'
)
```

## 6. Service Token Authentication

Use service tokens for production access.

### Create Service Token
```bash
# Read-only token
doppler service-tokens create prod-reader --access read-only

# Full access token
doppler service-tokens create ci-token --access read/write
```

### Use Service Token
```bash
# Set as environment variable
export DOPPLER_TOKEN="dp.st.production_xxxxx"

# Use with CLI
doppler run -- npm start

# Use with API
curl -H "Authorization: Bearer ${DOPPLER_TOKEN}" \
  https://api.doppler.com/v3/configs/config/secrets
```

## 7. Access Patterns by Use Case

### Local Development
```bash
# Interactive setup
doppler setup

# Daily workflow
doppler run -- npm run dev
```

### Docker Containers
```dockerfile
FROM node:16

# Install Doppler CLI
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | apt-key add - && \
    echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
    apt-get update && apt-get install -y doppler

# Run with Doppler
ENV DOPPLER_TOKEN=${DOPPLER_TOKEN}
CMD ["doppler", "run", "--", "npm", "start"]
```

### CI/CD Pipelines
```yaml
# GitHub Actions
- name: Run tests
  env:
    DOPPLER_TOKEN: ${{ secrets.DOPPLER_CI_TOKEN }}
  run: doppler run -- npm test

# GitLab CI
test:
  script:
    - export DOPPLER_TOKEN=$DOPPLER_CI_TOKEN
    - doppler run -- npm test
```

### Kubernetes
```yaml
# Using init container
initContainers:
- name: doppler
  image: dopplerhq/cli:latest
  command: ['sh', '-c', 'doppler secrets download --no-file --format env > /shared/secrets.env']
  env:
  - name: DOPPLER_TOKEN
    valueFrom:
      secretKeyRef:
        name: doppler-token
        key: token
  volumeMounts:
  - name: secrets
    mountPath: /shared
```

### Serverless Functions
```javascript
// AWS Lambda
const secrets = JSON.parse(process.env.DOPPLER_SECRETS);

exports.handler = async (event) => {
  const apiKey = secrets.API_KEY;
  // Use secrets...
};
```

## Security Best Practices

### 1. Use Appropriate Access Methods
- Development: Environment injection
- Production: Service tokens + mounting
- CI/CD: Read-only service tokens

### 2. Limit Token Scope
```bash
# Create environment-specific tokens
doppler service-tokens create prod-reader \
  --access read-only \
  --config production

doppler service-tokens create dev-full \
  --access read/write \
  --config development
```

### 3. Avoid Direct Downloads
- Prefer mounting over downloading to files
- If downloading, use `--no-file` flag
- Never commit downloaded secrets

### 4. Secure Token Storage
- Use secret management for tokens
- Rotate tokens regularly
- Monitor token usage

## Troubleshooting Access Issues

### Debug Commands
```bash
# Verify configuration
doppler configure

# Test secret access
doppler secrets get DOPPLER_PROJECT

# Check token permissions
doppler me
```

### Common Issues

1. **"No secrets found"**
   - Verify project/config selection
   - Check token permissions

2. **"Access denied"**
   - Ensure token has correct access level
   - Verify IP restrictions

3. **"File not found" with mounting**
   - Check mount path permissions
   - Ensure proper file format

4. **Large secret issues**
   - Use file mounting instead of env vars
   - Consider splitting large secrets