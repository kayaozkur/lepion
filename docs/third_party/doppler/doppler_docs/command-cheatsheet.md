---
title: "Doppler Command Cheatsheet"
description: "Quick reference guide for the most commonly used Doppler CLI commands including authentication, setup, secrets management, and project operations"
category: "cli"
type: "reference"
tags: ["doppler", "cli", "commands", "cheatsheet", "reference", "quick-guide"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Command Cheatsheet

## Quick Reference for Most Used Commands

### Authentication & Setup

```bash
# Login interactively
doppler login

# Login with service token
export DOPPLER_TOKEN="dp.st.xxx"

# Setup project (interactive)
doppler setup

# Quick setup
doppler setup --project myapp --config dev --no-interactive

# Check current user
doppler me

# Logout
doppler logout
```

### Secret Management - Essential Commands

```bash
# List all secrets
doppler secrets

# Get specific secret
doppler secrets get DATABASE_URL --plain

# Set secrets
doppler secrets set KEY="value" KEY2="value2"

# Delete secret
doppler secrets delete KEY

# Download as .env
doppler secrets download --no-file --format env > .env

# Run command with secrets
doppler run -- npm start
```

### Common Workflows

```bash
# Development workflow
doppler setup                              # One-time setup
doppler run -- npm run dev                # Run with secrets

# Production deployment
export DOPPLER_TOKEN="dp.st.prod.xxx"     # Set service token
doppler run -- node server.js             # Run application

# CI/CD usage
doppler run --token $DOPPLER_TOKEN -- ./deploy.sh

# Docker usage
doppler secrets download --no-file --format env > .env
docker run --env-file .env myapp:latest
rm .env
```

### Project & Config Management

```bash
# List projects
doppler projects

# List configs
doppler configs

# Create new config
doppler configs create staging

# Switch config
doppler configure set config staging

# Check current settings
doppler configure
```

### Quick Debugging

```bash
# Test connection
doppler ping

# Check version
doppler --version

# Enable debug mode
export DOPPLER_DEBUG=1

# Clear cache
doppler configure clear
```

## One-Liner Solutions

```bash
# Export all secrets to current shell
export $(doppler secrets download --no-file --format env | xargs)

# Get single secret value
DATABASE_URL=$(doppler secrets get DATABASE_URL --plain)

# Create and save service token
doppler configs tokens create --name "prod" --plain > token.txt

# Sync secrets to .env file
doppler secrets download --no-file --format env > .env

# Run Node.js app with secrets
doppler run -- node index.js

# Run Python app with specific config
doppler run --config production -- python app.py

# Quick secret update
doppler secrets set API_KEY="new-value"

# Backup all secrets as JSON
doppler secrets download --no-file --format json > backup.json

# List secrets as JSON and filter
doppler secrets --json | jq 'keys[]' | grep -i database

# Run tests with fallback
doppler run --fallback .env.test -- npm test
```

## Common Patterns by Use Case

### Local Development

```bash
# Initial setup
git clone <repo>
cd <project>
doppler setup
doppler run -- npm install
doppler run -- npm run dev
```

### Docker Deployment

```bash
# Build with secrets
doppler secrets download --no-file --format docker > .env.docker
docker build --env-file .env.docker -t myapp .
rm .env.docker

# Run container
docker run -e DOPPLER_TOKEN=$DOPPLER_TOKEN myapp
```

### CI/CD Integration

```bash
# GitHub Actions
- name: Deploy
  run: doppler run -- ./deploy.sh
  env:
    DOPPLER_TOKEN: ${{ secrets.DOPPLER_TOKEN }}

# Jenkins
withCredentials([string(credentialsId: 'doppler-token', variable: 'DOPPLER_TOKEN')]) {
    sh 'doppler run -- ./deploy.sh'
}
```

### Kubernetes Secrets

```bash
# Create K8s secret from Doppler
kubectl create secret generic app-secrets \
  --from-literal=token=$DOPPLER_TOKEN

# Or create from all secrets
doppler secrets download --no-file --format yaml | \
  kubectl create secret generic app-secrets --from-file=secrets.yaml=/dev/stdin
```

### Database Migrations

```bash
# Run migrations with DB credentials
doppler run -- npm run migrate

# With specific database
doppler run -- psql $DATABASE_URL -f migration.sql

# Backup before migration
doppler run -- pg_dump $DATABASE_URL > backup.sql
doppler run -- npm run migrate
```

## Environment-Specific Commands

### Development

```bash
doppler run --config dev -- npm start
doppler secrets --config dev
doppler secrets set --config dev DEBUG=true
```

### Staging

```bash
doppler run --config staging -- ./test.sh
doppler secrets download --config staging --format env > .env.staging
```

### Production

```bash
export DOPPLER_TOKEN=$PRODUCTION_TOKEN
doppler run -- pm2 start app.js
doppler secrets get --config production DATABASE_URL --plain
```

## Format-Specific Downloads

```bash
# Environment variables (.env)
doppler secrets download --no-file --format env

# JSON
doppler secrets download --no-file --format json

# YAML
doppler secrets download --no-file --format yaml

# Shell export
doppler secrets download --no-file --format shell

# Docker
doppler secrets download --no-file --format docker

# Key=Value pairs
doppler secrets download --no-file --format env-no-quotes
```

## Service Token Management

```bash
# Create token
doppler configs tokens create \
  --project myapp \
  --config production \
  --name "Server Token" \
  --plain

# List tokens
doppler configs tokens list

# Revoke token
doppler configs tokens revoke --slug xxx-xxx-xxx
```

## Useful Aliases

Add to ~/.bashrc or ~/.zshrc:

```bash
# Quick secret access
alias ds='doppler secrets'
alias dsg='doppler secrets get --plain'
alias dss='doppler secrets set'

# Run shortcuts
alias drun='doppler run --'
alias ddev='doppler run --config dev --'
alias dprod='doppler run --config production --'

# Config switching
alias dconf='doppler configure set config'

# Download shortcuts
alias denv='doppler secrets download --no-file --format env > .env'
alias djson='doppler secrets download --no-file --format json'
```

## Emergency Commands

```bash
# When something goes wrong

# Clear all cache
rm -rf ~/.doppler
doppler configure clear

# Re-authenticate
doppler logout --all
doppler login

# Force token refresh
unset DOPPLER_TOKEN
export DOPPLER_TOKEN="new-token"

# Test with minimal setup
DOPPLER_TOKEN="xxx" doppler secrets get DOPPLER_PROJECT --plain

# Skip TLS (not recommended)
export DOPPLER_SKIP_TLS_VERIFY=1

# Increase timeout
export DOPPLER_TIMEOUT=60

# Maximum debug info
export DOPPLER_DEBUG=1
export DOPPLER_LOG_LEVEL=debug
doppler secrets 2>&1 | tee debug.log
```

## Pro Tips

1. **Use `--plain` for scripting**
   ```bash
   DB_URL=$(doppler secrets get DATABASE_URL --plain)
   ```

2. **Pipe to jq for JSON processing**
   ```bash
   doppler secrets --json | jq -r '.DATABASE_URL.computed'
   ```

3. **Use fallback for offline work**
   ```bash
   doppler run --fallback .env.local -- npm start
   ```

4. **Combine with other tools**
   ```bash
   doppler secrets --json | jq 'to_entries[]' | grep -i api
   ```

5. **Quick environment check**
   ```bash
   doppler run -- env | grep -E '^(DATABASE|API|SECRET)'
   ```

Remember: Always keep service tokens secure and never commit them to version control!