---
title: "Getting Started with Doppler"
description: "Quick start guide for new Doppler users"
category: "getting-started"
type: "tutorial"
tags: ["doppler", "getting-started", "tutorial", "quick-start"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Getting Started with Doppler

## Prerequisites

Before getting started with Doppler, ensure you have:
- A Doppler account ([Sign up here](https://dashboard.doppler.com/register))
- Administrative access to your development environment
- Basic familiarity with command-line interfaces

## Quick Start Guide

### Step 1: Sign Up and Create Workspace

1. Visit [Doppler's dashboard](https://dashboard.doppler.com/register)
2. Create your account
3. Choose a name for your workspace

### Step 2: Create Your First Project

1. Click the "+" button to create a new project
2. Use hyphen-separated, lowercase names (e.g., `my-api-service`)
3. Add an optional description

Each project automatically includes three default environments:
- **Development**: For local development
- **Staging**: For pre-production testing
- **Production**: For live applications

### Step 3: Install the Doppler CLI

Choose your platform and follow the installation instructions:

#### macOS
```bash
# Install GnuPG (prerequisite)
brew install gnupg

# Install Doppler CLI
brew install dopplerhq/cli/doppler
```

#### Windows
```bash
# Using winget
winget install doppler.doppler
```

#### Linux (Debian/Ubuntu)
```bash
# Add Doppler's GPG key
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg

# Add repository
echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list

# Install
sudo apt-get update && sudo apt-get install doppler
```

### Step 4: Authenticate the CLI

```bash
doppler login
```

This opens a browser window for authentication. Once complete, your CLI is authenticated.

### Step 5: Configure Your Project

Navigate to your project directory and run:

```bash
doppler setup
```

This interactive command helps you:
1. Select your Doppler project
2. Choose the appropriate environment
3. Save the configuration for the directory

### Step 6: Add Your First Secrets

Add secrets via the dashboard or CLI:

```bash
# Interactive mode (recommended for sensitive values)
doppler secrets set API_KEY

# Direct setting
doppler secrets set DATABASE_URL="postgresql://user:pass@host:5432/db"

# Multiple secrets
doppler secrets set PORT="3000" NODE_ENV="development"
```

### Step 7: Run Your Application

Use Doppler to inject secrets into your application:

```bash
# Run with environment variables
doppler run -- npm start

# Or mount as a file
doppler run --mount .env -- npm start
```

## Best Practices for Getting Started

1. **Organize Projects Logically**: Create separate projects for different services
2. **Use Consistent Naming**: Follow a naming convention for secrets (e.g., `SERVICE_API_KEY`)
3. **Start with Development**: Set up your development environment first, then staging and production
4. **Leverage the CLI**: Use the CLI for local development and scripts
5. **Set Up Team Access Early**: Configure team permissions from the beginning

## Common First Tasks

### Import Existing Secrets
If you have existing `.env` files:
```bash
doppler secrets upload .env
```

### Set Up Team Access
1. Navigate to your project in the dashboard
2. Click "Members"
3. Add team members with appropriate roles

### Configure CI/CD
Generate a service token for your CI/CD pipeline:
1. Go to your project
2. Select the appropriate environment
3. Click "Service Tokens"
4. Generate a token with read-only access

## Next Steps

- Explore [Project Organization](./project-organization.md)
- Learn about [Access Control](./access-control.md)
- Set up [Integrations](../integrations/) with your infrastructure
- Configure [Automatic Secret Rotation](../secrets-management/rotation.md)