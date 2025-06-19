---
title: "Doppler CLI Advanced Features"
description: "Master advanced Doppler CLI features including automatic restart, file output, dynamic config switching, and process management capabilities"
category: "cli"
type: "guide"
tags: ["doppler", "cli", "advanced", "restart", "automation", "process-management"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler CLI Advanced Features

## Automatic Restart

The Doppler CLI can automatically restart processes when secrets change, ensuring your application always uses the latest configuration.

### Basic Usage

```bash
# Enable automatic restart with --watch flag
doppler run --watch -- npm start

# With specific restart delay
doppler run --watch --restart-delay 5 -- python app.py
```

### How It Works

1. Establishes long-lived HTTP connection to Doppler
2. Receives real-time notifications of secret changes
3. Fetches latest secrets
4. Gracefully terminates current process (SIGTERM)
5. Waits up to 10 seconds for process exit
6. Sends SIGKILL if needed
7. Restarts process with new secrets

### Best Practices

```bash
# Production usage with logging
doppler run --watch -- node server.js 2>&1 | tee app.log

# Development with nodemon
doppler run --watch -- nodemon index.js
```

### Limitations

- Multiple CLI instances watching same config restart simultaneously
- Not recommended for production without orchestration
- Consider Kubernetes Operator for production use

## Running Multiple Commands

Execute multiple commands in sequence using shell operators.

### Sequential Execution

```bash
# Run commands in sequence
doppler run --command="npm run build && npm run test && npm start"

# With error handling
doppler run --command="npm test || echo 'Tests failed' && npm start"
```

### Parallel Execution

```bash
# Run background processes
doppler run --command="npm run worker & npm run server & wait"

# Complex workflows
doppler run --command="
  echo 'Starting services...' &&
  npm run migrate &&
  npm run seed &&
  (npm run worker &) &&
  npm run server
"
```

### Conditional Execution

```bash
# Run based on environment
doppler run --command='
  if [ "$NODE_ENV" = "production" ]; then
    npm run build && npm start
  else
    npm run dev
  fi
'
```

## Managing Multiple Workplaces

Work with multiple Doppler workplaces seamlessly using scoped configurations.

### Directory-Based Scoping

```bash
# Structure projects by workplace
~/dev/
├── work/
│   └── api-service/      # Work workplace
├── personal/
│   └── blog/            # Personal workplace
└── opensource/
    └── library/         # Open source workplace

# Login to specific workplace
cd ~/dev/work
doppler login --scope .

cd ~/dev/personal
doppler login --scope .
```

### Explicit Scope Management

```bash
# Set scope for specific directory
doppler login --scope ~/projects/client-a/

# Use scope in commands
doppler run --scope ~/projects/client-a/ -- npm start

# View scope configuration
doppler configure --scope ~/projects/client-a/
```

### Advanced Scope Switching

Create a shell function for dynamic workplace switching:

```bash
# Add to ~/.bashrc or ~/.zshrc
doppler-switch() {
  local scope_dir="$HOME/.doppler/scopes"
  local selected=$(ls -1 "$scope_dir" | fzf --prompt="Select Doppler Scope: ")
  
  if [ -n "$selected" ]; then
    export DOPPLER_SCOPE="$scope_dir/$selected"
    echo "Switched to Doppler scope: $selected"
  fi
}

# Usage
doppler-switch
doppler run -- npm start
```

## Secret Templates and Injection

Use Go template syntax for dynamic configuration files.

### Basic Template Usage

```yaml
# config.yaml.tmpl
server:
  host: {{.HOST}}
  port: {{.PORT}}
database:
  url: {{.DATABASE_URL}}
{{if .REDIS_URL}}
cache:
  url: {{.REDIS_URL}}
{{end}}
```

```bash
# Generate config from template
doppler secrets substitute config.yaml.tmpl > config.yaml
```

### Advanced Template Features

```yaml
# Advanced template with functions
{{/* Parse JSON secret */}}
{{with fromjson .SERVICE_ACCOUNT}}
credentials:
  client_id: {{.client_id}}
  private_key: {{tojson .private_key}}
{{end}}

{{/* Conditional sections */}}
{{if eq .ENVIRONMENT "production"}}
monitoring:
  enabled: true
  level: "info"
{{else}}
monitoring:
  enabled: false
  level: "debug"
{{end}}

{{/* Range over comma-separated values */}}
allowed_origins:
{{range $i, $origin := split .ALLOWED_ORIGINS ","}}
  - {{trim $origin}}
{{end}}
```

### Direct Application

```bash
# Apply to Kubernetes
kubectl apply -f <(doppler secrets substitute k8s-deployment.yaml)

# Generate multiple configs
for env in dev staging prod; do
  doppler secrets substitute -c $env template.yaml > config-$env.yaml
done
```

## File Mounting Options

Advanced file mounting for complex secret requirements.

### Multiple File Mounts

```bash
# Mount different formats simultaneously
doppler run \
  --mount .env \
  --mount-format json=secrets.json \
  --mount-template config.yaml.tmpl=config.yaml \
  -- npm start
```

### Custom Mount Paths

```bash
# Mount to specific locations
doppler run \
  --mount /tmp/.env \
  --mount-format json=/config/secrets.json \
  -- python app.py
```

### Mount with Permissions

```bash
# Create mounted files with specific permissions
doppler run \
  --mount .env \
  --mount-file-mode 0600 \
  -- ./secure-app
```

## Signal Forwarding

Properly handle process signals for graceful shutdowns.

```bash
# Forward all signals to child process
doppler run --forward-signals -- node server.js

# Specific signal handling
doppler run --forward-signals SIGTERM,SIGINT -- python app.py
```

## Performance Optimization

### Connection Reuse

```bash
# Keep connection alive for multiple runs
export DOPPLER_ENABLE_CONNECTION_REUSE=1
doppler run -- ./script1.sh
doppler run -- ./script2.sh
```

### Caching

```bash
# Enable local caching
export DOPPLER_ENABLE_CACHE=1
export DOPPLER_CACHE_TTL=300  # 5 minutes

doppler run -- npm start
```

### Batch Operations

```bash
# Set multiple secrets efficiently
doppler secrets set \
  API_KEY="xxx" \
  DATABASE_URL="yyy" \
  REDIS_URL="zzz" \
  --no-interactive
```

## Debugging and Troubleshooting

### Verbose Output

```bash
# Enable debug logging
export DOPPLER_LOG_LEVEL=debug
doppler run -- npm start

# Trace HTTP requests
export DOPPLER_ENABLE_HTTP_TRACE=1
doppler secrets
```

### Dry Run

```bash
# Preview what would be injected
doppler run --dry-run -- env

# Test template substitution
doppler secrets substitute --dry-run template.yaml
```

### Fallback Mechanisms

```bash
# Use fallback file if Doppler unavailable
doppler run \
  --fallback .env.backup \
  --fallback-readonly \
  -- npm start

# Custom fallback behavior
doppler run \
  --fallback .env.local \
  --fallback-only \
  -- npm test
```

## Integration Patterns

### Docker Integration

```dockerfile
# Multi-stage build with Doppler
FROM doppler/cli:latest AS doppler
FROM node:16

# Copy Doppler binary
COPY --from=doppler /usr/local/bin/doppler /usr/local/bin/doppler

# Run with Doppler
ENTRYPOINT ["doppler", "run", "--"]
CMD ["npm", "start"]
```

### CI/CD Integration

```yaml
# GitHub Actions example
- name: Run tests with Doppler
  env:
    DOPPLER_TOKEN: ${{ secrets.DOPPLER_TOKEN }}
  run: |
    doppler run --command='
      npm ci &&
      npm run test:unit &&
      npm run test:integration
    '
```

### Local Development

```bash
# Development helper script
#!/bin/bash
# dev.sh

# Ensure Doppler is configured
if ! doppler configure get project >/dev/null 2>&1; then
  echo "Setting up Doppler..."
  doppler setup
fi

# Run with watch mode and auto-restart
doppler run --watch -- nodemon \
  --watch src \
  --ext js,json \
  --exec "npm start"
```