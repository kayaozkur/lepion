---
title: "Doppler Troubleshooting Guide"
description: "Comprehensive troubleshooting guide for diagnosing and resolving common Doppler issues including authentication, configuration, integration, and performance problems"
category: "troubleshooting"
type: "reference"
tags: ["doppler", "troubleshooting", "debugging", "errors", "authentication", "support"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Troubleshooting Guide

## Overview

This comprehensive guide helps you diagnose and resolve common issues with Doppler. Whether you're facing authentication problems, configuration issues, or integration challenges, this guide provides solutions and debugging strategies.

## Common Issues and Solutions

### Authentication Issues

#### Issue: "Unable to authenticate" error

**Symptoms:**
- `Error: Unable to authenticate. Please run 'doppler login'`
- 401 Unauthorized errors
- Token validation failures

**Solutions:**

1. **For Personal Authentication:**
   ```bash
   # Re-authenticate
   doppler logout
   doppler login
   
   # Verify authentication
   doppler me
   ```

2. **For Service Tokens:**
   ```bash
   # Verify token format
   echo $DOPPLER_TOKEN | grep -E "^dp\.(pt|st)\.[a-zA-Z0-9_]+\.[a-zA-Z0-9]{20,}$"
   
   # Test token directly
   curl -X GET https://api.doppler.com/v3/me \
     -H "Authorization: Bearer $DOPPLER_TOKEN"
   
   # Check token permissions
   doppler configs tokens list --json | jq '.[] | select(.slug=="your-token-slug")'
   ```

3. **Clear Local Cache:**
   ```bash
   # Clear all Doppler cache
   doppler configure clear
   rm -rf ~/.doppler
   
   # Re-setup
   doppler setup
   ```

#### Issue: "Token expired" or "Invalid token"

**Solutions:**

1. **Check Token Expiration:**
   ```bash
   # List tokens with expiration dates
   doppler configs tokens list --project myapp --config production --json | \
     jq '.[] | {name, expires_at}'
   ```

2. **Create New Token:**
   ```bash
   # Generate fresh token
   doppler configs tokens create \
     --project myapp \
     --config production \
     --name "Replacement Token $(date +%Y%m%d)" \
     --plain
   ```

3. **For CI/CD Environments:**
   ```bash
   # Update CI/CD secret with new token
   # GitHub Actions example
   gh secret set DOPPLER_TOKEN --body "dp.st.production.newtoken"
   ```

### Configuration Issues

#### Issue: "No project configured"

**Symptoms:**
- `Error: No project has been configured`
- Commands fail without --project flag

**Solutions:**

1. **Run Setup:**
   ```bash
   # Interactive setup
   doppler setup
   
   # Non-interactive setup
   doppler setup --project myapp --config dev --no-interactive
   ```

2. **Manual Configuration:**
   ```bash
   # Set project
   doppler configure set project myapp
   
   # Set config
   doppler configure set config production
   
   # Verify settings
   doppler configure
   ```

3. **Directory-Specific Setup:**
   ```bash
   # Setup for current directory only
   doppler setup --scope .
   
   # Check local config
   cat .doppler/.doppler.yaml
   ```

#### Issue: Wrong environment/config being used

**Solutions:**

1. **Check Current Configuration:**
   ```bash
   # Show all configurations
   doppler configure
   
   # Check specific values
   doppler configure get project
   doppler configure get config
   ```

2. **Override Configuration:**
   ```bash
   # Run with specific config
   doppler run --project myapp --config production -- env
   
   # Set environment variable
   export DOPPLER_CONFIG=production
   ```

3. **Debug Configuration Loading:**
   ```bash
   # Enable debug mode
   export DOPPLER_DEBUG=1
   doppler configure
   ```

### Secret Access Issues

#### Issue: "Secret not found"

**Solutions:**

1. **Verify Secret Exists:**
   ```bash
   # List all secrets
   doppler secrets
   
   # Search for specific secret
   doppler secrets | grep -i database
   
   # Check in different configs
   doppler secrets --config staging | grep DATABASE_URL
   ```

2. **Check Secret References:**
   ```bash
   # Look for computed secrets
   doppler secrets --json | jq '.DATABASE_URL'
   
   # Check for typos
   doppler secrets get DATEBASE_URL 2>&1 | grep -q "not found" && \
     echo "Secret not found - check spelling"
   ```

#### Issue: Secrets not updating

**Solutions:**

1. **Force Refresh:**
   ```bash
   # Clear local cache
   rm -rf ~/.doppler/cache
   
   # Fetch fresh secrets
   doppler secrets --no-cache
   ```

2. **Check for Overrides:**
   ```bash
   # Look for local overrides
   cat .env.local
   
   # Check environment variables
   env | grep -E "^(DATABASE_URL|API_KEY)"
   ```

3. **Verify Webhook Delivery:**
   ```bash
   # For applications using webhooks
   curl -X POST https://api.doppler.com/v3/webhooks/test \
     -H "Authorization: Bearer $DOPPLER_TOKEN"
   ```

### CLI Issues

#### Issue: "Command not found: doppler"

**Solutions:**

1. **Verify Installation:**
   ```bash
   # Check if installed
   which doppler
   
   # Check version
   doppler --version
   
   # Reinstall if needed
   curl -Ls --tlsv1.2 --proto "=https" --retry 3 \
     https://cli.doppler.com/install.sh | sudo sh
   ```

2. **Fix PATH Issues:**
   ```bash
   # Add to PATH
   echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

#### Issue: CLI hangs or times out

**Solutions:**

1. **Check Network:**
   ```bash
   # Test API connectivity
   curl -I https://api.doppler.com/v3/ping
   
   # Check with Doppler
   doppler ping
   
   # Test with timeout
   timeout 5 doppler secrets || echo "Command timed out"
   ```

2. **Proxy Configuration:**
   ```bash
   # Set proxy if needed
   export HTTPS_PROXY=http://proxy.company.com:8080
   export NO_PROXY=localhost,127.0.0.1
   
   # Test with proxy
   doppler ping
   ```

3. **Debug Mode:**
   ```bash
   # Enable verbose logging
   export DOPPLER_DEBUG=1
   export DOPPLER_TIMEOUT=30
   doppler secrets
   ```

### Integration Issues

#### Issue: Docker container can't access secrets

**Solutions:**

1. **Check Token in Container:**
   ```bash
   # Debug Dockerfile
   docker run --rm -e DOPPLER_TOKEN=$DOPPLER_TOKEN myapp:latest \
     sh -c 'echo $DOPPLER_TOKEN | head -c 20'
   ```

2. **Proper Dockerfile Setup:**
   ```dockerfile
   FROM node:18-alpine
   
   # Install Doppler CLI
   RUN wget -q -t3 'https://packages.doppler.com/public/cli/rsa.8004D9FF50437357.key' -O /etc/apk/keys/cli@doppler-8004D9FF50437357.rsa.pub && \
       echo 'https://packages.doppler.com/public/cli/alpine/any-version/main' | tee -a /etc/apk/repositories && \
       apk add doppler
   
   # Don't hardcode token!
   ARG DOPPLER_TOKEN
   ENV DOPPLER_TOKEN=$DOPPLER_TOKEN
   
   # Run with Doppler
   CMD ["doppler", "run", "--", "node", "server.js"]
   ```

3. **Docker Compose Fix:**
   ```yaml
   version: '3.8'
   services:
     app:
       build: .
       environment:
         - DOPPLER_TOKEN=${DOPPLER_TOKEN}
       command: doppler run -- npm start
   ```

#### Issue: Kubernetes pods failing to start

**Solutions:**

1. **Check Secret Creation:**
   ```bash
   # Verify secret exists
   kubectl get secret doppler-token -o yaml
   
   # Recreate if needed
   kubectl create secret generic doppler-token \
     --from-literal=token=$DOPPLER_TOKEN \
     --dry-run=client -o yaml | kubectl apply -f -
   ```

2. **Pod Configuration:**
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: debug-doppler
   spec:
     containers:
     - name: debug
       image: dopplerhq/cli:latest
       command: ["sh", "-c", "doppler secrets get DOPPLER_PROJECT --plain"]
       env:
       - name: DOPPLER_TOKEN
         valueFrom:
           secretKeyRef:
             name: doppler-token
             key: token
   ```

3. **Debug Pod:**
   ```bash
   # Run debug pod
   kubectl run doppler-debug --rm -i --tty \
     --image=dopplerhq/cli:latest \
     --env="DOPPLER_TOKEN=$DOPPLER_TOKEN" \
     -- doppler secrets
   ```

### Performance Issues

#### Issue: Slow secret fetching

**Solutions:**

1. **Enable Caching:**
   ```bash
   # Use local cache
   doppler secrets download --no-file > .doppler-cache
   
   # Run with fallback
   doppler run --fallback .doppler-cache -- npm start
   ```

2. **Optimize API Calls:**
   ```bash
   # Download once, use multiple times
   eval $(doppler secrets download --no-file --format shell)
   
   # Instead of multiple calls
   # doppler secrets get DATABASE_URL --plain
   # doppler secrets get API_KEY --plain
   ```

3. **Regional Endpoints:**
   ```bash
   # Use closer API endpoint if available
   export DOPPLER_API_HOST=https://api.eu.doppler.com
   ```

## Advanced Debugging

### Enable Debug Logging

```bash
# Maximum debugging
export DOPPLER_DEBUG=1
export DOPPLER_TIMEOUT=60
export DOPPLER_LOG_LEVEL=debug

# Run command
doppler secrets 2>&1 | tee doppler-debug.log
```

### Network Diagnostics

```bash
#!/bin/bash
# Network diagnostic script

echo "=== DNS Resolution ==="
nslookup api.doppler.com

echo -e "\n=== Connectivity Test ==="
curl -I https://api.doppler.com/v3/ping

echo -e "\n=== SSL Certificate ==="
openssl s_client -connect api.doppler.com:443 -servername api.doppler.com < /dev/null

echo -e "\n=== Traceroute ==="
traceroute api.doppler.com

echo -e "\n=== API Response Time ==="
time curl -s https://api.doppler.com/v3/ping > /dev/null
```

### Token Validation Script

```bash
#!/bin/bash
# Comprehensive token validation

TOKEN=${1:-$DOPPLER_TOKEN}

if [ -z "$TOKEN" ]; then
    echo "Error: No token provided"
    exit 1
fi

echo "Validating token: ${TOKEN:0:20}..."

# Check format
if ! echo "$TOKEN" | grep -qE "^dp\.(pt|st)\.[a-zA-Z0-9_]+\.[a-zA-Z0-9]{20,}$"; then
    echo "Error: Invalid token format"
    exit 1
fi

# Test API access
RESPONSE=$(curl -s -w "\n%{http_code}" https://api.doppler.com/v3/me \
    -H "Authorization: Bearer $TOKEN")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "200" ]; then
    echo "✓ Token is valid"
    echo "$BODY" | jq -r '"User: \(.name)"'
else
    echo "✗ Token validation failed (HTTP $HTTP_CODE)"
    echo "$BODY" | jq -r '.messages[]' 2>/dev/null || echo "$BODY"
fi
```

### Environment Diagnostic

```bash
#!/bin/bash
# Full environment diagnostic

echo "=== Doppler Environment Diagnostic ==="
echo "Date: $(date)"
echo "Host: $(hostname)"
echo

echo "=== CLI Version ==="
doppler --version || echo "Doppler CLI not found"

echo -e "\n=== Configuration ==="
doppler configure || echo "No configuration found"

echo -e "\n=== Environment Variables ==="
env | grep DOPPLER | sed 's/\(TOKEN=\).*/\1[REDACTED]/'

echo -e "\n=== Local Files ==="
ls -la ~/.doppler/ 2>/dev/null || echo "No .doppler directory"
ls -la .doppler/ 2>/dev/null || echo "No local .doppler directory"

echo -e "\n=== Token Test ==="
if [ -n "$DOPPLER_TOKEN" ]; then
    doppler me || echo "Token authentication failed"
else
    echo "No DOPPLER_TOKEN set"
fi

echo -e "\n=== API Connectivity ==="
doppler ping || echo "API ping failed"
```

## Error Reference

### Common Error Messages

| Error | Cause | Solution |
|-------|-------|----------|
| `Unable to authenticate` | Invalid or missing token | Run `doppler login` or check `DOPPLER_TOKEN` |
| `Project not found` | Project doesn't exist or no access | Verify project name and permissions |
| `Config not found` | Configuration doesn't exist | Create config or check spelling |
| `Secret not found` | Secret doesn't exist in current config | Check secret name and config |
| `Rate limit exceeded` | Too many API requests | Implement caching or wait |
| `Network timeout` | Connection issues | Check network and proxy settings |
| `Permission denied` | Insufficient token permissions | Create new token with proper scope |

### Exit Codes

| Code | Meaning | Example |
|------|---------|---------|
| 0 | Success | Command completed successfully |
| 1 | General error | Invalid arguments or failed operation |
| 2 | Authentication error | Invalid token or not logged in |
| 3 | Not found | Project, config, or secret not found |
| 4 | Already exists | Trying to create duplicate resource |
| 5 | Network error | Connection or timeout issues |

## Getting Help

### Self-Help Resources

1. **Check Documentation:**
   ```bash
   # CLI help
   doppler --help
   doppler secrets --help
   
   # Online docs
   open https://docs.doppler.com
   ```

2. **Version Information:**
   ```bash
   # Check for updates
   doppler update check
   
   # Current version
   doppler --version
   ```

### Support Channels

1. **Community Support:**
   - [Doppler Community Forum](https://community.doppler.com)
   - [GitHub Issues](https://github.com/DopplerHQ/cli/issues)

2. **Enterprise Support:**
   - Email: support@doppler.com
   - In-app chat support

3. **Status Page:**
   - [status.doppler.com](https://status.doppler.com)

## Preventive Measures

### Regular Maintenance

```bash
#!/bin/bash
# Monthly maintenance script

echo "=== Doppler Maintenance ==="

# Update CLI
echo "Checking for updates..."
doppler update install

# Clean old tokens
echo "Reviewing service tokens..."
doppler configs tokens list --json | \
  jq -r '.[] | select(.last_seen_at == null) | .name' | \
  while read token; do
    echo "Consider removing unused token: $token"
  done

# Verify configurations
echo "Verifying configurations..."
doppler projects | while read project; do
    echo "Checking $project..."
    doppler configs --project "$project" > /dev/null || \
      echo "  Warning: Cannot access $project"
done

echo "Maintenance complete!"
```

### Monitoring Script

```bash
#!/bin/bash
# Health check script for monitoring

check_doppler_health() {
    # Check CLI
    if ! command -v doppler &> /dev/null; then
        echo "CRITICAL: Doppler CLI not found"
        return 1
    fi
    
    # Check API
    if ! doppler ping &> /dev/null; then
        echo "CRITICAL: Cannot reach Doppler API"
        return 1
    fi
    
    # Check token
    if [ -n "$DOPPLER_TOKEN" ]; then
        if ! doppler me &> /dev/null; then
            echo "WARNING: Token authentication failed"
            return 2
        fi
    fi
    
    echo "OK: Doppler healthy"
    return 0
}

check_doppler_health
```

## Resources

- [Doppler Documentation](https://docs.doppler.com)
- [API Reference](https://docs.doppler.com/reference)
- [CLI Repository](https://github.com/DopplerHQ/cli)
- [Status Page](https://status.doppler.com)
- [Community Forum](https://community.doppler.com)