---
title: "Secret Injection with Templates in Doppler"
description: "Learn to use Doppler's template system for dynamic secret injection into configuration files using Go text/template syntax for Kubernetes manifests and structured formats"
category: "secrets-management"
type: "guide"
tags: ["doppler", "templates", "injection", "kubernetes", "configuration", "go-templates"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Secret Injection with Templates in Doppler

## Overview

Doppler's template system allows you to dynamically inject secrets into configuration files using Go's text/template syntax. This is particularly useful for generating complex configuration files, Kubernetes manifests, or any structured format that requires secret values.

## Template Syntax Basics

### Simple Substitution
```yaml
# template.yaml
server:
  host: {{.SERVER_HOST}}
  port: {{.SERVER_PORT}}
database:
  url: {{.DATABASE_URL}}
```

### Comments
```yaml
{{/* This is a comment and won't appear in output */}}
{{/* Use comments to document your templates */}}
api:
  key: {{.API_KEY}}
  {{/* TODO: Add rate limiting config */}}
```

## Using Templates

### CLI Commands

```bash
# Substitute secrets into template and output to stdout
doppler secrets substitute template.yaml

# Save to file
doppler secrets substitute template.yaml > config.yaml

# Use specific project/config
doppler secrets substitute template.yaml --project api --config production

# Pipe directly to kubectl
kubectl apply -f <(doppler secrets substitute k8s-deployment.yaml)
```

### Multiple Template Processing
```bash
# Process all templates in a directory
for template in templates/*.tmpl; do
  output="${template%.tmpl}"
  doppler secrets substitute "$template" > "$output"
done
```

## Advanced Template Features

### Conditional Blocks

```yaml
# config.yaml.tmpl
application:
  name: {{.APP_NAME}}
  environment: {{.ENVIRONMENT}}
  
{{if .ENABLE_DEBUG}}
debug:
  enabled: true
  level: {{.DEBUG_LEVEL}}
{{end}}

{{if eq .ENVIRONMENT "production"}}
monitoring:
  enabled: true
  endpoint: {{.MONITORING_ENDPOINT}}
{{else}}
monitoring:
  enabled: false
{{end}}
```

### Working with Optional Values

```yaml
# Using 'with' for optional blocks
database:
  primary: {{.DATABASE_URL}}
{{with .DATABASE_REPLICA_URL}}
  replica: {{.}}
{{end}}

{{with .REDIS_URL}}
cache:
  enabled: true
  url: {{.}}
{{else}}
cache:
  enabled: false
{{end}}
```

### Default Values

```yaml
# Provide defaults for missing values
server:
  port: {{or .PORT "3000"}}
  host: {{or .HOST "localhost"}}
  workers: {{or .WORKER_COUNT "4"}}
```

## Custom Template Functions

Doppler provides additional functions beyond Go's standard template functions:

### tojson Function
Converts a value to JSON string:

```yaml
# template.yaml
credentials:
  # Convert multi-line private key to JSON string
  private_key: {{tojson .PRIVATE_KEY}}
  
# If PRIVATE_KEY contains newlines, output will be:
# private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkq...\n-----END PRIVATE KEY-----"
```

### fromjson Function
Parses JSON-formatted secret:

```yaml
# If API_CONFIG contains: {"timeout": 30, "retries": 3}
{{with fromjson .API_CONFIG}}
api:
  timeout: {{.timeout}}
  retries: {{.retries}}
{{end}}
```

### Combining Functions

```yaml
# Complex example with nested JSON
{{with fromjson .SERVICE_ACCOUNTS}}
services:
  {{range $name, $config := .}}
  - name: {{$name}}
    credentials: {{tojson $config.credentials}}
    endpoint: {{$config.endpoint}}
  {{end}}
{{end}}
```

## Real-World Template Examples

### Kubernetes Deployment

```yaml
# k8s-deployment.yaml.tmpl
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{.APP_NAME}}
  namespace: {{.K8S_NAMESPACE}}
spec:
  replicas: {{.REPLICAS}}
  selector:
    matchLabels:
      app: {{.APP_NAME}}
  template:
    metadata:
      labels:
        app: {{.APP_NAME}}
        version: {{.APP_VERSION}}
    spec:
      containers:
      - name: {{.APP_NAME}}
        image: {{.DOCKER_REGISTRY}}/{{.APP_NAME}}:{{.APP_VERSION}}
        ports:
        - containerPort: {{.PORT}}
        env:
        - name: DATABASE_URL
          value: "{{.DATABASE_URL}}"
        - name: REDIS_URL
          value: "{{.REDIS_URL}}"
        {{if .ENABLE_PROFILING}}
        - name: ENABLE_PROFILING
          value: "true"
        {{end}}
        resources:
          requests:
            memory: "{{.MEMORY_REQUEST}}"
            cpu: "{{.CPU_REQUEST}}"
          limits:
            memory: "{{.MEMORY_LIMIT}}"
            cpu: "{{.CPU_LIMIT}}"
```

### Docker Compose

```yaml
# docker-compose.yaml.tmpl
version: '3.8'
services:
  app:
    image: {{.APP_IMAGE}}
    ports:
      - "{{.HOST_PORT}}:{{.CONTAINER_PORT}}"
    environment:
      NODE_ENV: {{.NODE_ENV}}
      API_KEY: {{.API_KEY}}
      DATABASE_URL: {{.DATABASE_URL}}
    {{with .VOLUMES}}
    volumes:
      {{range .}}
      - {{.}}
      {{end}}
    {{end}}
    
  {{if eq .ENVIRONMENT "development"}}
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: {{.DB_NAME}}
      POSTGRES_USER: {{.DB_USER}}
      POSTGRES_PASSWORD: {{.DB_PASSWORD}}
  {{end}}
```

### Application Configuration

```json
{{/* app-config.json.tmpl */}}
{
  "app": {
    "name": "{{.APP_NAME}}",
    "version": "{{.APP_VERSION}}",
    "environment": "{{.ENVIRONMENT}}"
  },
  "server": {
    "host": "{{.SERVER_HOST}}",
    "port": {{.SERVER_PORT}},
    "ssl": {{if eq .ENVIRONMENT "production"}}true{{else}}false{{end}}
  },
  "database": {
    "host": "{{.DB_HOST}}",
    "port": {{.DB_PORT}},
    "name": "{{.DB_NAME}}",
    "pool": {
      "min": {{or .DB_POOL_MIN "2"}},
      "max": {{or .DB_POOL_MAX "10"}}
    }
  },
  {{with fromjson .FEATURE_FLAGS}}
  "features": {{tojson .}}
  {{end}}
}
```

### NGINX Configuration

```nginx
# nginx.conf.tmpl
server {
    listen {{.NGINX_PORT}};
    server_name {{.SERVER_NAME}};
    
    {{if .SSL_ENABLED}}
    ssl on;
    ssl_certificate {{.SSL_CERT_PATH}};
    ssl_certificate_key {{.SSL_KEY_PATH}};
    {{end}}
    
    location / {
        proxy_pass http://{{.UPSTREAM_HOST}}:{{.UPSTREAM_PORT}};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        
        {{if .ENABLE_CORS}}
        add_header 'Access-Control-Allow-Origin' '{{.CORS_ORIGIN}}';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        {{end}}
    }
    
    {{range $path, $backend := fromjson .API_ROUTES}}
    location {{$path}} {
        proxy_pass http://{{$backend}};
    }
    {{end}}
}
```

## Template Patterns and Best Practices

### 1. Organized Templates Structure
```
templates/
├── base/
│   ├── deployment.yaml.tmpl
│   └── service.yaml.tmpl
├── environments/
│   ├── dev.yaml.tmpl
│   ├── staging.yaml.tmpl
│   └── prod.yaml.tmpl
└── apps/
    ├── api/
    │   └── config.json.tmpl
    └── worker/
        └── config.json.tmpl
```

### 2. Template Validation Script
```bash
#!/bin/bash
# validate-templates.sh

for template in templates/**/*.tmpl; do
  echo "Validating $template..."
  if doppler secrets substitute "$template" > /dev/null 2>&1; then
    echo "✓ Valid"
  else
    echo "✗ Invalid template: $template"
    doppler secrets substitute "$template"
  fi
done
```

### 3. Environment-Specific Templates
```yaml
# base-config.yaml.tmpl
{{if eq .ENVIRONMENT "production"}}
  {{template "prod-config.yaml.tmpl" .}}
{{else if eq .ENVIRONMENT "staging"}}
  {{template "staging-config.yaml.tmpl" .}}
{{else}}
  {{template "dev-config.yaml.tmpl" .}}
{{end}}
```

### 4. Reusable Template Parts
```yaml
{{/* Define reusable database config */}}
{{define "database-config"}}
database:
  host: {{.DB_HOST}}
  port: {{.DB_PORT}}
  name: {{.DB_NAME}}
  ssl: {{.DB_SSL_ENABLED}}
{{end}}

{{/* Use in main template */}}
{{template "database-config" .}}
```

## Complex Use Cases

### Multi-Stage Configuration
```bash
# Generate configs for all environments
for env in dev staging prod; do
  doppler secrets substitute template.yaml \
    --config $env > config-$env.yaml
done
```

### Dynamic File Generation
```bash
# Generate multiple files from JSON secret
doppler secrets get FILE_CONFIGS --plain | jq -r 'to_entries | .[]' | while IFS= read -r entry; do
  filename=$(echo "$entry" | jq -r '.key')
  content=$(echo "$entry" | jq -r '.value')
  echo "$content" > "$filename"
done
```

### CI/CD Pipeline Integration
```yaml
# .github/workflows/deploy.yml
- name: Generate Kubernetes manifests
  run: |
    doppler secrets substitute k8s/deployment.yaml.tmpl > k8s/deployment.yaml
    doppler secrets substitute k8s/service.yaml.tmpl > k8s/service.yaml
    doppler secrets substitute k8s/configmap.yaml.tmpl > k8s/configmap.yaml

- name: Deploy to Kubernetes
  run: |
    kubectl apply -f k8s/
```

## Troubleshooting Templates

### Common Issues

1. **Missing Variable**
```bash
# Error: template: config.yaml:5:14: executing "config.yaml" at <.MISSING_VAR>: map has no entry for key "MISSING_VAR"

# Solution: Ensure all referenced secrets exist
doppler secrets set MISSING_VAR="default-value"
```

2. **Type Mismatch**
```yaml
# Wrong: This will quote the number
port: "{{.PORT}}"

# Correct: Let template engine handle types
port: {{.PORT}}
```

3. **JSON Parsing Errors**
```yaml
# Debug JSON secrets
doppler secrets get MY_JSON_SECRET --plain | jq .

# Safe JSON handling
{{with fromjson .MY_JSON_SECRET}}
  {{if .}}
    # Use the parsed JSON
  {{end}}
{{end}}
```

### Template Testing
```bash
# Test with dry run
doppler secrets substitute template.yaml --dry-run

# Test with minimal secrets
echo 'SERVER_HOST=localhost
SERVER_PORT=3000' | doppler secrets upload --config test

doppler secrets substitute template.yaml --config test
```

## Security Considerations

1. **Never commit templates with secrets**
   - Templates should only contain placeholders
   - Generated files should be in .gitignore

2. **Validate template output**
   ```bash
   # Check for exposed secrets
   doppler secrets substitute template.yaml | grep -E '(password|key|token)'
   ```

3. **Use restricted visibility for sensitive templates**
   ```bash
   # Store template content as secret
   doppler secrets set DEPLOYMENT_TEMPLATE < deployment.yaml.tmpl
   ```