---
title: "Doppler CLI Commands Reference"
description: "Complete reference guide for all Doppler CLI commands and usage"
category: "cli-reference"
type: "reference"
tags: ["doppler", "cli", "commands", "reference"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler CLI Commands Reference

## Core Commands Overview

The Doppler CLI provides comprehensive commands for managing secrets, projects, and configurations.

## Authentication

### Login
```bash
# Interactive browser login
doppler login

# Login with specific scope
doppler login --scope ~/dev/project

# Login with auth token
doppler login --token dp.st.xxxx
```

### Logout
```bash
# Logout from current scope
doppler logout

# Logout from all scopes
doppler logout --all
```

## Project Configuration

### Setup
```bash
# Interactive project setup
doppler setup

# Non-interactive setup
doppler setup --project api-service --config dev

# Setup with specific directory scope
doppler setup --scope /path/to/project
```

### Configure
```bash
# View current configuration
doppler configure

# Set project
doppler configure set project api-service

# Set config
doppler configure set config dev

# View specific scope configuration
doppler configure --scope $(pwd)

# Reset configuration
doppler configure reset
```

## Secrets Management

### Viewing Secrets

```bash
# List all secrets
doppler secrets

# Get specific secret value
doppler secrets get API_KEY

# Get secret in plain text
doppler secrets get DATABASE_URL --plain

# Get multiple secrets
doppler secrets get API_KEY DATABASE_URL --json

# Download secrets in different formats
doppler secrets download --no-file --format env
doppler secrets download --no-file --format json
doppler secrets download --no-file --format yaml
```

### Setting Secrets

```bash
# Interactive mode (recommended for sensitive values)
doppler secrets set API_KEY

# Direct setting
doppler secrets set PORT="3000"

# Multiple secrets
doppler secrets set NODE_ENV="production" DEBUG="false"

# From stdin
echo "my-secret-value" | doppler secrets set SECRET_KEY

# From file
cat certificate.pem | doppler secrets set TLS_CERT

# With visibility
doppler secrets set API_KEY --visibility masked
```

### Deleting Secrets

```bash
# Delete single secret
doppler secrets delete API_KEY

# Delete multiple secrets
doppler secrets delete API_KEY DATABASE_URL

# Delete with confirmation
doppler secrets delete API_KEY --yes
```

### Uploading Secrets

```bash
# Upload from .env file
doppler secrets upload .env

# Upload from JSON
doppler secrets upload secrets.json

# Upload from YAML
doppler secrets upload config.yaml
```

## Running Applications

### Basic Run
```bash
# Run with injected environment variables
doppler run -- npm start

# Run with specific project/config
doppler run -p api-service -c production -- python app.py
```

### Advanced Run Options
```bash
# Mount secrets as file
doppler run --mount .env -- npm start
doppler run --mount secrets.json -- python app.py

# Watch for changes and auto-restart
doppler run --watch -- npm start

# Run multiple commands
doppler run --command="npm run build && npm start"

# Custom fallback file
doppler run --fallback .env.backup -- npm start

# Forward signals
doppler run --forward-signals -- npm start
```

## Environment Management

### List Environments
```bash
# List all environments in current project
doppler environments

# List with specific project
doppler environments --project api-service
```

### Create Environment
```bash
# Create new environment
doppler environments create qa

# Create with specific settings
doppler environments create staging --defaults
```

## Service Tokens

### Create Token
```bash
# Create service token for current config
doppler service-tokens create ci-token

# Create with specific access
doppler service-tokens create prod-readonly --access read

# Create with expiration
doppler service-tokens create temp-token --expires-at "2024-12-31"
```

### List Tokens
```bash
# List all tokens
doppler service-tokens

# List with details
doppler service-tokens --json
```

### Revoke Token
```bash
# Revoke specific token
doppler service-tokens revoke dp.st.xxxx
```

## Activity Logs

```bash
# View recent activity
doppler activity

# View activity for specific config
doppler activity --config production

# Filter by user
doppler activity --user [email protected]

# Export as JSON
doppler activity --json
```

## Config Management

### List Configs
```bash
# List all configs
doppler configs

# List for specific environment
doppler configs --environment production
```

### Create Config
```bash
# Create branch config
doppler configs create feature-branch --environment dev
```

### Update Config
```bash
# Rename config
doppler configs update feature-branch --name new-feature

# Lock config
doppler configs lock production
```

## Workplace Management

### Switch Workplace
```bash
# List workplaces
doppler workplaces

# Switch workplace
doppler workplaces select

# Set default workplace
doppler configure set workplace my-workplace
```

## Utility Commands

### Version & Updates
```bash
# Check version
doppler --version

# Check for updates
doppler update check

# Update CLI
doppler update
```

### Shell Completion
```bash
# Generate completion script
doppler completion bash
doppler completion zsh
doppler completion fish
```

### Help
```bash
# General help
doppler --help

# Command-specific help
doppler secrets --help
doppler run --help
```

## Advanced Usage

### Using Flags

Global flags available for most commands:
- `--json`: Output in JSON format
- `--no-color`: Disable colored output
- `--no-check-version`: Skip version check
- `--no-timeout`: Disable timeout
- `--silent`: Suppress output

### Environment Variables

Doppler CLI respects these environment variables:
- `DOPPLER_TOKEN`: Service token for authentication
- `DOPPLER_PROJECT`: Default project
- `DOPPLER_CONFIG`: Default config
- `DOPPLER_ENVIRONMENT`: Default environment

### Configuration Files

Doppler stores configuration in:
- `~/.doppler/.doppler.yaml`: Global configuration
- `.doppler.yaml`: Project-specific configuration (if enabled)

## Common Workflows

### Local Development
```bash
# Initial setup
doppler login
doppler setup

# Daily usage
doppler run -- npm run dev
```

### CI/CD Pipeline
```bash
# Use service token
export DOPPLER_TOKEN="dp.st.xxxx"
doppler run -- npm test
doppler run -- npm run build
```

### Secret Rotation
```bash
# Update secret
doppler secrets set API_KEY

# Verify change
doppler activity

# Restart services
doppler run --watch -- npm start
```