---
title: "Doppler CLI Complete Guide"
description: "Comprehensive guide to installing, configuring, and using the Doppler CLI across different platforms with authentication, project setup, and command usage"
category: "cli"
type: "guide"
tags: ["doppler", "cli", "installation", "setup", "authentication", "cross-platform"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler CLI Complete Guide

## Overview

Doppler CLI is an open-source tool that injects secrets into applications consistently across development and production environments. It works with any language, framework, platform, and cloud provider by injecting secrets as environment variables.

## 1. CLI Installation for Different Platforms

### macOS
```bash
# Install GnuPG (prerequisite)
brew install gnupg

# Install Doppler CLI
brew install dopplerhq/cli/doppler
```

### Windows
**Option 1: Using winget**
```powershell
winget install doppler.doppler
```

**Option 2: Using Scoop**
```powershell
scoop bucket add doppler https://github.com/DopplerHQ/scoop-doppler.git
scoop install doppler
```

### Linux

**Debian/Ubuntu (22.04+)**
```bash
# Install prerequisites
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# Add Doppler repository
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list

# Install Doppler
sudo apt-get update && sudo apt-get install doppler
```

**Alpine Linux**
```bash
# Add Doppler repository key
wget -q -t3 'https://packages.doppler.com/public/cli/rsa.8004D9FF50437357.key' -O /etc/apk/keys/[email protected]

# Add repository
echo 'https://packages.doppler.com/public/cli/alpine/any-version/main' | tee -a /etc/apk/repositories

# Install Doppler
apk add doppler
```

**RedHat/CentOS/Amazon Linux**
```bash
# Import GPG key
sudo rpm --import 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key'

# Add repository and install
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/config.rpm.txt' | sudo tee /etc/yum.repos.d/doppler-cli.repo
sudo yum install doppler
```

### Docker
```dockerfile
# In your Dockerfile
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
    apt-get update && apt-get install doppler
```

## 2. Essential CLI Commands with Examples

### Authentication
```bash
# Login for local development
doppler login

# Setup project and config for current directory
doppler setup
```

### Running Commands with Secrets
```bash
# Run a single command with secrets injected
doppler run -- node app.js

# Run with specific project and config
doppler run --project api --config production -- npm start

# Run with mounted secrets file
doppler run --mount .env -- python app.py
```

### Managing Secrets
```bash
# View all secrets in dashboard format
doppler secrets

# Get a specific secret value
doppler secrets get API_KEY --plain

# Get multiple secrets
doppler secrets get API_KEY DATABASE_URL --plain

# Download secrets in different formats
doppler secrets download --format json
doppler secrets download --format yaml
doppler secrets download --format env
doppler secrets download --format docker
```

### Setting Secrets
```bash
# Set a single secret interactively (recommended for sensitive values)
doppler secrets set API_KEY

# Set multiple secrets at once
doppler secrets set PORT="8080" API_URL="https://api.example.com"

# Set secret from file
cat certificate.pem | doppler secrets set TLS_CERT

# Bulk upload from file
doppler secrets upload .env
doppler secrets upload config.json
```

### Project Management
```bash
# List all projects
doppler projects

# Create a new project
doppler projects create backend-api

# List configs for a project
doppler configs --project backend-api
```

## 3. TUI (Terminal UI) Features

The Doppler TUI provides an interactive interface for managing secrets directly in the terminal.

### Launching TUI
```bash
doppler tui
```

### Keyboard Shortcuts

**Navigation:**
- `1` - Focus on Configs panel
- `2` - Focus on Projects panel
- `3` - Focus on Secrets panel
- `/` - Focus on Filter input
- `q` - Exit TUI

**Secrets Editing:**
- `j`/`k` - Move cursor up/down
- `h`/`l` - Toggle between secret name and value
- `e` - Enter edit mode for selected secret
- `a` - Add a new secret
- `d` - Delete current secret
- `s` - Open save prompt
- `y` - Copy current selection to clipboard

**Features:**
- Vim-like editing mode
- Real-time filtering of secrets
- Quick editing without leaving the terminal
- Visual interface for secret management

## 4. Methods for Accessing and Setting Secrets

### Accessing Secrets

**1. Environment Variable Injection (Most Common)**
```bash
# Inject secrets as environment variables
doppler run -- node app.js

# Access in your code:
# Node.js: process.env.API_KEY
# Python: os.environ['API_KEY']
# Ruby: ENV['API_KEY']
```

**2. Mounting Secrets Files**
```bash
# Mount as .env file (auto-cleaned after process exits)
doppler run --mount .env -- npm start

# Mount as JSON file
doppler run --mount secrets.json --mount-format json -- python app.py

# Custom template mounting
doppler run --mount config.txt --mount-template 'api_key={{.API_KEY}}' -- ./app
```

**3. Direct Access**
```bash
# Get single secret
doppler secrets get DATABASE_URL --plain

# Get as JSON
doppler secrets get --json

# Filter secrets
doppler secrets download --no-file --format env | grep AWS
doppler secrets download --no-file --format json | jq '.AWS_ACCESS_KEY'
```

**4. Shell Export**
```bash
# Create child shell with secrets
doppler run -- sh -c 'bash'

# Export to current shell (use with caution)
export $(doppler secrets download --no-file --format env)
```

### Setting Secrets

**1. Interactive Mode (Recommended for Sensitive Data)**
```bash
# Prompts for value without exposing in shell history
doppler secrets set API_KEY

# Set with specific visibility
doppler secrets set API_KEY --visibility restricted
```

**2. Direct Setting**
```bash
# Single secret
doppler secrets set NODE_ENV="production"

# Multiple secrets
doppler secrets set DB_HOST="localhost" DB_PORT="5432" DB_USER="admin"
```

**3. From Files**
```bash
# From stdin
echo "secret_value" | doppler secrets set MY_SECRET

# From file
cat private_key.pem | doppler secrets set PRIVATE_KEY

# Bulk upload
doppler secrets upload .env.production
```

## 5. Running Multiple Commands with Doppler

### Command Chaining
```bash
# Using && (runs second command only if first succeeds)
doppler run --command="npm test && npm start"

# Using ; (runs all commands regardless)
doppler run --command="npm install; npm test; npm start"

# Using || (runs second command only if first fails)
doppler run --command="npm start || npm run fallback"

# Complex example with cleanup
doppler run --command="./setup.sh && ./main-app || ./error-handler; ./cleanup.sh"
```

### Running Scripts
```bash
# Run a shell script with secrets
doppler run -- bash deploy.sh

# Run multiple scripts in sequence
doppler run --command="./pre-deploy.sh && ./deploy.sh && ./post-deploy.sh"
```

### Important Notes:
- Always use quotes when using `--command` flag with shell operators
- The `--` separator is optional when using `--command`
- Commands inherit all environment variables from Doppler

## 6. Automatic Restart Functionality

The automatic restart feature monitors for secret changes and restarts your application automatically.

### Enabling Auto-Restart
```bash
# Add --watch flag to doppler run
doppler run --watch -- node server.js

# With mounted secrets
doppler run --watch --mount .env -- python app.py
```

### How It Works:
1. Maintains a long-lived HTTP connection to Doppler servers
2. Receives notifications when secrets change
3. Fetches the latest secrets
4. Gracefully stops the current process (SIGTERM)
5. Waits up to 10 seconds for process exit
6. Force kills (SIGKILL) if necessary
7. Remounts secret files if using `--mount`
8. Restarts the original command with new secrets

### Important Considerations:
- **Requires Team or Enterprise subscription**
- Not recommended for production environments
- All CLI instances watching the same config restart simultaneously
- For production, use Doppler Kubernetes Operator instead

### Example Use Cases:
```bash
# Development server with auto-restart
doppler run --watch -- npm run dev

# Docker container with restart
doppler run --watch -- docker-compose up

# Multiple services with restart
doppler run --watch --command="./api-server & ./worker & wait"
```

## Best Practices

1. **Security:**
   - Use interactive mode for setting sensitive secrets
   - Prefer mounting secrets over direct environment injection when possible
   - Avoid exposing secrets in shell history

2. **Development Workflow:**
   - Use `doppler setup` to link directories to specific projects/configs
   - Leverage the TUI for quick secret management
   - Use `--watch` flag during development for automatic updates

3. **Production:**
   - Use service tokens instead of personal tokens
   - Avoid using `--watch` in production
   - Consider using Doppler integrations for production deployments

4. **Command Execution:**
   - Always use `--` separator before your command to avoid flag conflicts
   - Quote complex commands when using `--command` flag
   - Test commands locally before deploying

## Quick Reference

```bash
# Setup
doppler login                              # Authenticate
doppler setup                              # Configure project/config

# Run
doppler run -- npm start                   # Basic run
doppler run --mount .env -- python app.py  # With mounted file
doppler run --watch -- node server.js      # With auto-restart

# Secrets
doppler secrets                            # View all
doppler secrets get API_KEY --plain        # Get one
doppler secrets set API_KEY                # Set interactively
doppler secrets upload .env                # Bulk upload

# TUI
doppler tui                                # Launch interactive UI
```

This guide covers the essential aspects of using Doppler CLI for secret management across different environments and platforms.