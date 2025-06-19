---
title: "Doppler API and SDK Integration Guide"
description: "Complete guide to integrating Doppler using REST API and SDKs for Python, JavaScript/Node.js with authentication, rate limits, and practical examples"
category: "integration"
type: "guide"
tags: ["doppler", "api", "sdk", "python", "javascript", "nodejs", "integration"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler API and SDK Integration Guide

## Table of Contents
1. [API Overview](#api-overview)
2. [Authentication](#authentication)
3. [Python SDK](#python-sdk)
4. [JavaScript/Node.js SDK](#javascriptnodejs-sdk)
5. [Universal Import](#universal-import)
6. [Practical Examples](#practical-examples)

## API Overview

### Base URL
```
https://api.doppler.com/v3
```

### Rate Limits

| Plan       | Reads/min | Secret Reads/min | Writes/min |
|------------|-----------|------------------|------------|
| Developer  | 240       | 120              | 60         |
| Team       | 480       | 240              | 120        |
| Enterprise | 480       | 480              | 240        |

Rate limit information is provided in response headers:
- `X-Rate-Limit-Limit`
- `X-Rate-Limit-Remaining`
- `X-Rate-Limit-Reset`

### Key API Endpoints

- **Secrets Management**: `/secrets`, `/secrets/update`, `/secrets/download`
- **Projects**: `/projects`, `/projects/create`, `/projects/update`
- **Environments**: `/environments`, `/environments/create`
- **Configs**: `/configs`, `/configs/create`, `/configs/update`
- **Service Tokens**: `/configs/config/tokens`, `/configs/config/tokens/create`
- **Integrations**: `/integrations`, `/integrations/create`
- **Webhooks**: `/webhooks`, `/webhooks/create`

## Authentication

### Token Types
1. **CLI Tokens** - For CLI usage
2. **Personal Tokens** - User-specific access
3. **Service Tokens** - Application/service access
4. **Service Account Tokens** - Automated systems
5. **Service Account Identity Tokens** - Identity-based access
6. **SCIM Tokens** - User provisioning
7. **Audit Tokens** - Audit log access

### Authentication Header
```http
Authorization: Bearer <TOKEN>
```

### Example cURL Request
```bash
curl -X GET "https://api.doppler.com/v3/projects" \
     -H "Authorization: Bearer dp.xx.yyy"
```

## Python SDK

### Installation
```bash
pip install --upgrade doppler-sdk
```

### Basic Setup
```python
from dopplersdk import DopplerSDK

# Initialize the SDK
doppler = DopplerSDK()
doppler.set_access_token("dp.xx.yyy")
```

### Common Operations

#### List Projects
```python
from pprint import pprint

# List all projects
projects = doppler.projects.list()
pprint(vars(projects))
```

#### Fetch Secrets
```python
# Get secrets from a specific config
secrets = doppler.secrets.list(
    project="my-project",
    config="production"
)
pprint(vars(secrets))
```

#### Update a Secret
```python
# Update a single secret
result = doppler.secrets.update(
    project="my-project",
    config="production",
    secrets={
        "DATABASE_URL": "postgresql://user:pass@host:5432/db"
    }
)
```

#### Create a Service Token
```python
# Create a service token for production config
token = doppler.service_tokens.create(
    project="my-project",
    config="production",
    name="production-api-token",
    access="read"
)
print(f"Token: {token.token}")
```

## JavaScript/Node.js SDK

### Installation
```bash
npm install @dopplerhq/node-sdk
```

### Basic Setup

#### ES Modules
```javascript
import DopplerSDK from '@dopplerhq/node-sdk';

const doppler = new DopplerSDK({ 
    accessToken: 'dp.xx.yyy' 
});
```

#### CommonJS
```javascript
const DopplerSDK = require('@dopplerhq/node-sdk').default;

const doppler = new DopplerSDK({ 
    accessToken: 'dp.xx.yyy' 
});
```

### Common Operations

#### List Projects
```javascript
async function listProjects() {
    try {
        const projects = await doppler.projects.list();
        console.log(projects);
    } catch (error) {
        console.error('Error listing projects:', error);
    }
}
```

#### Fetch Secrets
```javascript
async function getSecrets(project, config) {
    try {
        const secrets = await doppler.secrets.list({
            project: project,
            config: config
        });
        return secrets;
    } catch (error) {
        console.error('Error fetching secrets:', error);
    }
}
```

#### Update Secrets
```javascript
async function updateSecrets(project, config, secretsObject) {
    try {
        const result = await doppler.secrets.update({
            project: project,
            config: config,
            secrets: secretsObject
        });
        console.log('Secrets updated:', result);
    } catch (error) {
        console.error('Error updating secrets:', error);
    }
}

// Usage
await updateSecrets('my-project', 'production', {
    'API_KEY': 'new-api-key-value',
    'DATABASE_URL': 'postgresql://localhost:5432/mydb'
});
```

#### Environment-specific Operations
```javascript
async function manageEnvironments(projectName) {
    // List environments
    const environments = await doppler.environments.list({
        project: projectName
    });
    
    // Create a new environment
    const newEnv = await doppler.environments.create({
        project: projectName,
        name: 'staging',
        slug: 'stg'
    });
    
    return { environments, newEnv };
}
```

## Universal Import

### React Integration

#### Installation
```bash
npm install @dopplerhq/universal-import-react
```

#### Implementation
```jsx
import React from 'react';
import DopplerImportButton from "@dopplerhq/universal-import-react";

function SecretManager() {
    const secrets = [
        { name: "DATABASE_URL", value: process.env.DATABASE_URL },
        { name: "API_KEY", value: process.env.API_KEY },
        { name: "JWT_SECRET", value: process.env.JWT_SECRET }
    ];
    
    return (
        <div>
            <h2>Import Secrets to Doppler</h2>
            {secrets.map((secret) => (
                <div key={secret.name}>
                    <span>{secret.name}</span>
                    <DopplerImportButton
                        secretName={secret.name}
                        secretValue={secret.value}
                    />
                </div>
            ))}
        </div>
    );
}
```

### Core Library Usage

#### Installation
```bash
npm install @dopplerhq/universal-import-core
```

#### Custom Implementation
```javascript
import { encryptSecret, importToDoppler } from '@dopplerhq/universal-import-core';

async function customImport(secretName, secretValue) {
    try {
        // Encrypt the secret
        const encryptedData = await encryptSecret({
            name: secretName,
            value: secretValue
        });
        
        // Import to Doppler
        const result = await importToDoppler(encryptedData);
        console.log('Import successful:', result);
    } catch (error) {
        console.error('Import failed:', error);
    }
}
```

## Practical Examples

### 1. Complete Python Application Example
```python
from dopplersdk import DopplerSDK
import os
from datetime import datetime

class DopplerSecretManager:
    def __init__(self, token):
        self.doppler = DopplerSDK()
        self.doppler.set_access_token(token)
    
    def sync_local_env_to_doppler(self, project, config):
        """Sync local .env file to Doppler"""
        secrets = {}
        
        # Read local .env file
        with open('.env', 'r') as f:
            for line in f:
                if '=' in line and not line.startswith('#'):
                    key, value = line.strip().split('=', 1)
                    secrets[key] = value
        
        # Update secrets in Doppler
        result = self.doppler.secrets.update(
            project=project,
            config=config,
            secrets=secrets
        )
        
        print(f"Synced {len(secrets)} secrets to Doppler")
        return result
    
    def fetch_and_export(self, project, config, export_file='.env.doppler'):
        """Fetch secrets from Doppler and export to file"""
        secrets = self.doppler.secrets.list(
            project=project,
            config=config
        )
        
        with open(export_file, 'w') as f:
            f.write(f"# Exported from Doppler on {datetime.now()}\n")
            for key, value in secrets.secrets.items():
                f.write(f"{key}={value}\n")
        
        print(f"Exported secrets to {export_file}")
        return secrets

# Usage
manager = DopplerSecretManager("dp.xx.yyy")
manager.sync_local_env_to_doppler("my-app", "development")
manager.fetch_and_export("my-app", "production")
```

### 2. Node.js Express Integration
```javascript
import express from 'express';
import DopplerSDK from '@dopplerhq/node-sdk';

class DopplerConfig {
    constructor(token) {
        this.doppler = new DopplerSDK({ accessToken: token });
        this.secrets = {};
    }
    
    async loadSecrets(project, config) {
        try {
            const response = await this.doppler.secrets.list({
                project: project,
                config: config
            });
            
            this.secrets = response.secrets;
            
            // Set process.env variables
            Object.entries(this.secrets).forEach(([key, value]) => {
                process.env[key] = value;
            });
            
            console.log(`Loaded ${Object.keys(this.secrets).length} secrets`);
        } catch (error) {
            console.error('Failed to load secrets:', error);
            throw error;
        }
    }
    
    get(key) {
        return this.secrets[key] || process.env[key];
    }
}

// Express app setup
const app = express();
const dopplerConfig = new DopplerConfig(process.env.DOPPLER_TOKEN);

// Initialize secrets before starting server
async function startServer() {
    await dopplerConfig.loadSecrets('my-app', 'production');
    
    app.get('/health', (req, res) => {
        res.json({ 
            status: 'healthy',
            database: dopplerConfig.get('DATABASE_URL') ? 'connected' : 'not configured'
        });
    });
    
    const PORT = dopplerConfig.get('PORT') || 3000;
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
    });
}

startServer().catch(console.error);
```

### 3. CI/CD Integration Script
```bash
#!/bin/bash
# deploy.sh - Doppler-powered deployment script

# Install Doppler CLI
curl -Ls https://cli.doppler.com/install.sh | sh

# Authenticate using service token
export DOPPLER_TOKEN="${DOPPLER_SERVICE_TOKEN}"

# Fetch and export secrets
doppler secrets download \
    --no-file \
    --format env \
    --project "${PROJECT}" \
    --config "${ENV}" > .env

# Run deployment commands with secrets
source .env
docker build -t myapp:latest .
docker run -d --env-file .env myapp:latest
```

### 4. Webhook Integration Example
```javascript
// Webhook handler for secret updates
import crypto from 'crypto';

function verifyDopplerWebhook(payload, signature, secret) {
    const hmac = crypto.createHmac('sha256', secret);
    hmac.update(JSON.stringify(payload));
    const expectedSignature = hmac.digest('hex');
    
    return crypto.timingSafeEqual(
        Buffer.from(signature),
        Buffer.from(expectedSignature)
    );
}

app.post('/webhooks/doppler', express.json(), async (req, res) => {
    const signature = req.headers['x-doppler-signature'];
    const webhookSecret = process.env.DOPPLER_WEBHOOK_SECRET;
    
    if (!verifyDopplerWebhook(req.body, signature, webhookSecret)) {
        return res.status(401).send('Invalid signature');
    }
    
    // Handle different webhook events
    switch(req.body.type) {
        case 'config.secrets.updated':
            console.log('Secrets updated, reloading configuration...');
            await dopplerConfig.loadSecrets(
                req.body.data.project,
                req.body.data.config
            );
            break;
            
        case 'config.secrets.deleted':
            console.log('Secrets deleted:', req.body.data.secrets);
            break;
    }
    
    res.status(200).send('Webhook processed');
});
```

### 5. Multi-Environment Management
```python
class DopplerEnvironmentManager:
    def __init__(self, token):
        self.doppler = DopplerSDK()
        self.doppler.set_access_token(token)
    
    def promote_secrets(self, project, from_config, to_config):
        """Promote secrets from one environment to another"""
        # Fetch secrets from source
        source_secrets = self.doppler.secrets.list(
            project=project,
            config=from_config
        )
        
        # Update destination with source secrets
        result = self.doppler.secrets.update(
            project=project,
            config=to_config,
            secrets=source_secrets.secrets
        )
        
        print(f"Promoted {len(source_secrets.secrets)} secrets from {from_config} to {to_config}")
        return result
    
    def diff_environments(self, project, config1, config2):
        """Compare secrets between two environments"""
        secrets1 = self.doppler.secrets.list(project=project, config=config1)
        secrets2 = self.doppler.secrets.list(project=project, config=config2)
        
        keys1 = set(secrets1.secrets.keys())
        keys2 = set(secrets2.secrets.keys())
        
        return {
            'only_in_first': keys1 - keys2,
            'only_in_second': keys2 - keys1,
            'common': keys1 & keys2,
            'different_values': [
                key for key in keys1 & keys2 
                if secrets1.secrets[key] != secrets2.secrets[key]
            ]
        }

# Usage
manager = DopplerEnvironmentManager("dp.xx.yyy")
manager.promote_secrets("my-app", "staging", "production")
diff = manager.diff_environments("my-app", "development", "production")
print(f"Environment differences: {diff}")
```

## Best Practices

1. **Token Security**
   - Never hardcode tokens in source code
   - Use environment variables or secure vaults
   - Rotate tokens regularly
   - Use service tokens for applications

2. **Error Handling**
   - Implement retry logic for transient failures
   - Log API errors with context
   - Have fallback mechanisms for secret retrieval

3. **Performance**
   - Cache secrets locally when appropriate
   - Use webhooks for real-time updates
   - Batch secret updates when possible

4. **Organization**
   - Use consistent naming conventions
   - Group related secrets
   - Document secret purposes
   - Implement proper access controls

5. **Development Workflow**
   - Separate environments (dev, staging, prod)
   - Use branching for config changes
   - Implement approval workflows for production changes
   - Regular audits of secret usage