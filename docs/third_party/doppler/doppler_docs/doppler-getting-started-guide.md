---
title: "Doppler: Complete Getting Started Guide"
description: "Comprehensive introduction to Doppler SecretOps Platform covering core concepts, setup process, workplace structure, and best practices for secrets management"
category: "getting-started"
type: "tutorial"
tags: ["doppler", "getting-started", "setup", "secretops", "onboarding", "basics"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler: Complete Getting Started Guide

## Table of Contents
1. [What is Doppler?](#what-is-doppler)
2. [Core Value Proposition](#core-value-proposition)
3. [Key Concepts and Terminology](#key-concepts-and-terminology)
4. [Initial Setup Process](#initial-setup-process)
5. [Workplace and Project Structure](#workplace-and-project-structure)
6. [Environment Configurations](#environment-configurations)
7. [Best Practices](#best-practices)
8. [Practical Examples](#practical-examples)

## What is Doppler?

Doppler is a SecretOps Platform designed to simplify secrets management for development and production environments. It provides a centralized solution for managing application configurations and secrets across teams and environments.

### The Problem Doppler Solves
Most teams start by managing secrets with `.env` files or environment variables. However, this approach quickly becomes unmanageable as:
- Services multiply
- Teams grow
- Security requirements increase
- Configuration complexity expands

Doppler addresses these challenges by providing structure, security, and visibility to your configurations.

## Core Value Proposition

### Key Benefits
- **Centralized Management**: Single source of truth for all secrets and configurations
- **Security**: Fine-grained access controls and audit logs
- **Scalability**: Grows with your organization from startup to enterprise
- **Developer Experience**: Seamless CLI integration and quick setup (typically 30 minutes)
- **Version Control**: Track changes and maintain configuration history
- **Platform Support**: Works with Docker, Serverless, Cloud providers, and more

### Target Audience
- Startups building their first products
- Growing companies experiencing "secrets sprawl"
- Global enterprises requiring robust access controls
- DevOps teams managing multiple environments

## Key Concepts and Terminology

### Organizational Hierarchy
1. **Workplace**: The top-level container for your organization
2. **Projects**: Represent specific applications or services
3. **Environments**: Map to deployment stages (dev, staging, production)
4. **Configs**: Store actual secrets and configurations
   - Root configs: Base configuration for an environment
   - Branch configs: Environment-specific overrides

### Access Control
- Applied at the environment level
- Fine-grained permissions for team members
- Activity and access logs for compliance

## Initial Setup Process

### Getting Started Steps

1. **Create Your Workplace**
   - Sign up for Doppler
   - Your workplace is automatically created

2. **Understand Your Current Setup**
   - Audit existing `.env` files
   - Identify all secrets and configurations
   - Map out environment requirements

3. **Create Your First Project**
   - Click the "+" button in the Projects section
   - Choose a descriptive name (hyphen-separated, lowercase)
   - Add an optional description

4. **Configure Environments**
   - Default environments are automatically created:
     - Development
     - Staging
     - Production
   - Add custom environments as needed

5. **Integrate with Your Tools**
   - Development environments
   - CI/CD pipelines
   - Hosting providers
   - Existing secrets managers

## Workplace and Project Structure

### Organizational Design

```
Workplace (Your Company)
│
├── Project: web-app
│   ├── Environment: development
│   ├── Environment: staging
│   └── Environment: production
│
├── Project: mobile-api
│   ├── Environment: development
│   ├── Environment: staging
│   └── Environment: production
│
└── Project: shared-services
    ├── Environment: development
    └── Environment: production
```

### Project Naming Best Practices

1. **Team Prefixes**: `team-projectname`
   - Example: `backend-user-service`

2. **Regional Suffixes**: `projectname-region`
   - Example: `web-app-us-east`

3. **Service Grouping**: `application-service`
   - Example: `ecommerce-payment`

### Structure Recommendations

#### For Microservices
Option 1: Application + Service
```
ecommerce-frontend
ecommerce-payment
ecommerce-inventory
```

Option 2: Application Only (with branch configs)
```
ecommerce
├── Branch: frontend
├── Branch: payment
└── Branch: inventory
```

#### For Monolithic Applications
```
main-application
├── Environment: development
├── Environment: staging
└── Environment: production
```

### Limits and Considerations
- Maximum 1000 projects per workplace
- Maximum 15 environments per project
- Access control is applied at the environment level

## Environment Configurations

### Default Environments

Every project starts with three environments:
1. **Development**: For local development and testing
2. **Staging**: Pre-production testing environment
3. **Production**: Live production environment

### Customizing Environments

1. **Navigate to Default Environments**
   - Projects → Default Environments

2. **Modify Environment Settings**
   - Environment Name
   - Environment Slug
   - Branch Configs enabled/disabled
   - Personal Configs enabled/disabled

3. **Naming Restrictions**
   - Cannot start or end with underscore `_` or dash `-`

### Environment-Specific Configurations

```yaml
# Example: Database configurations across environments

# Development
DATABASE_URL: "postgres://localhost:5432/app_dev"
DEBUG: "true"
LOG_LEVEL: "debug"

# Staging
DATABASE_URL: "postgres://staging.db.example.com:5432/app_staging"
DEBUG: "false"
LOG_LEVEL: "info"

# Production
DATABASE_URL: "postgres://prod.db.example.com:5432/app_prod"
DEBUG: "false"
LOG_LEVEL: "error"
```

## Best Practices

### 1. Naming Conventions
- Use consistent, descriptive names
- Follow `hyphen-separated-lowercase` format
- Include relevant prefixes/suffixes for organization

### 2. Project Organization
- Group related services logically
- Use shared projects for common credentials
- Consider future scaling needs

### 3. Access Control
- Apply principle of least privilege
- Regularly audit access permissions
- Use environment-level restrictions

### 4. Configuration Management
- Use branch configs for variations
- Keep production configs minimal and secure
- Document configuration requirements

### 5. Integration Strategy
- Start with development environment
- Gradually expand to CI/CD
- Finally integrate production systems

## Practical Examples

### Example 1: Web Application Setup

```bash
# Project: company-website
# Environments: dev, staging, production

# Development Config
API_URL=http://localhost:3000
DATABASE_URL=postgres://localhost:5432/dev_db
REDIS_URL=redis://localhost:6379
AWS_ACCESS_KEY=dev_key_123
STRIPE_KEY=sk_test_123

# Staging Config
API_URL=https://api-staging.company.com
DATABASE_URL=postgres://staging-db.company.com:5432/staging_db
REDIS_URL=redis://staging-redis.company.com:6379
AWS_ACCESS_KEY=staging_key_456
STRIPE_KEY=sk_test_456

# Production Config
API_URL=https://api.company.com
DATABASE_URL=postgres://prod-db.company.com:5432/prod_db
REDIS_URL=redis://prod-redis.company.com:6379
AWS_ACCESS_KEY=prod_key_789
STRIPE_KEY=sk_live_789
```

### Example 2: Microservices Architecture

```
# Workplace Structure
company-workspace/
├── auth-service/
│   ├── development
│   ├── staging
│   └── production
├── payment-service/
│   ├── development
│   ├── staging
│   └── production
├── notification-service/
│   ├── development
│   ├── staging
│   └── production
└── shared-credentials/
    ├── development
    └── production
```

### Example 3: Multi-Region Deployment

```
# Using Branch Configs for Regions
web-application/
├── production/
│   ├── root-config (shared configs)
│   ├── branch: us-east-1
│   ├── branch: eu-west-1
│   └── branch: ap-southeast-1
```

### Example 4: CI/CD Integration

```yaml
# GitHub Actions Example
name: Deploy
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install Doppler CLI
        run: |
          curl -Ls https://cli.doppler.com/install.sh | sh
      - name: Deploy with Doppler
        run: |
          doppler run --token ${{ secrets.DOPPLER_TOKEN }} -- npm run deploy
```

## Next Steps

1. **Watch the Introduction Video**: Understanding secrets management challenges
2. **Read "Managing Secrets at Scale"**: Deep dive into best practices
3. **Explore Team Management**: Set up your team with proper access controls
4. **Install the CLI**: Begin local development with Doppler
5. **Create Your First Project**: Start with a simple application
6. **Integrate Your Tools**: Connect your existing development workflow

## Resources

- [Doppler Documentation](https://docs.doppler.com)
- [CLI Installation Guide](https://docs.doppler.com/docs/cli)
- [Integration Guides](https://docs.doppler.com/docs/integrations)
- [Best Practices](https://docs.doppler.com/docs/best-practices)

---

*Remember: Doppler scales as you do. Start simple and expand your usage as your needs grow.*