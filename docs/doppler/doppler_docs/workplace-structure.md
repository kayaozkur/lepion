---
title: "Doppler Workplace Structure"
description: "Understand Doppler's organizational hierarchy for managing secrets at scale including projects, environments, configurations, teams, and permissions"
category: "project-management"
type: "guide"
tags: ["doppler", "workplace", "organization", "hierarchy", "structure", "teams", "permissions"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Workplace Structure

## Overview

Understanding Doppler's organizational hierarchy is crucial for effectively managing secrets at scale. This guide covers how to structure your projects, environments, and configurations for optimal security and maintainability.

## Organizational Hierarchy

```
Workplace
├── Projects (max 1000)
│   ├── Environments (max 15 per project)
│   │   ├── Branch Configs
│   │   └── Secrets
│   └── Service Tokens
├── Teams
├── Users
└── Integrations
```

## Core Concepts

### 1. Workplace
- Top-level organizational unit
- Contains all projects, users, and settings
- Single billing entity
- Global security policies

### 2. Projects
- Represents a specific application or service
- Contains environments and their secrets
- Maximum of 1000 projects per workplace
- Naming conventions are crucial for organization

### 3. Environments
- Deployment stages (dev, staging, production)
- Maximum of 15 environments per project
- Inherit base configuration
- Can override specific secrets

### 4. Branch Configs
- Environment-specific variations
- Useful for feature branches or regional deployments
- Inherit from parent environment

## Project Naming Strategies

### Strategy 1: Simple Application-Based
```
frontend-web
backend-api
mobile-app
admin-dashboard
```

**Pros:**
- Clear and intuitive
- Easy to navigate
- Good for small to medium teams

**Cons:**
- May not scale for complex architectures
- Limited organizational context

### Strategy 2: Team-Service Pattern
```
<team>-<application>-<service>

payments-api-gateway
payments-api-processor
marketing-web-landing
marketing-web-blog
```

**Pros:**
- Clear ownership
- Scales well
- Easy to apply access controls

**Cons:**
- Longer names
- Requires consistent naming discipline

### Strategy 3: Full Context Pattern
```
<team>-<app>-<service>-<region>

backend-api-auth-us-east
backend-api-auth-eu-west
frontend-web-app-global
```

**Pros:**
- Maximum clarity
- Supports complex deployments
- Region-aware

**Cons:**
- Can become verbose
- May hit naming limits

## Environment Configuration

### Standard Environments

```
Project: my-app
├── dev (Development)
│   ├── DATABASE_URL: postgres://localhost/dev
│   ├── API_KEY: dev-key-123
│   └── DEBUG: true
├── staging (Staging)
│   ├── DATABASE_URL: postgres://staging.db/app
│   ├── API_KEY: stg-key-456
│   └── DEBUG: true
└── production (Production)
    ├── DATABASE_URL: postgres://prod.db/app
    ├── API_KEY: prod-key-789
    └── DEBUG: false
```

### Environment Inheritance

```
base_config
├── SHARED_API_URL: https://api.example.com
├── LOG_LEVEL: info
└── TIMEOUT: 30

dev (inherits from base_config)
├── SHARED_API_URL: https://api.example.com (inherited)
├── LOG_LEVEL: debug (overridden)
├── TIMEOUT: 30 (inherited)
└── DATABASE_URL: postgres://localhost/dev (new)
```

## Architecture Patterns

### Pattern 1: Microservices Architecture

```
# Separate projects for each service
auth-service
├── dev
├── staging
└── production

user-service
├── dev
├── staging
└── production

payment-service
├── dev
├── staging
└── production

# Shared configuration project
shared-config
├── staging
└── production
```

**Implementation:**
```bash
# Set up auth service
doppler setup --project auth-service --config dev

# Reference shared secrets
DATABASE_URL: ${shared-config.staging.DATABASE_URL}
REDIS_URL: ${shared-config.staging.REDIS_URL}
```

### Pattern 2: Monolithic Application

```
my-application
├── dev
│   ├── main (default branch)
│   ├── feature-x (branch config)
│   └── feature-y (branch config)
├── staging
│   └── main
└── production
    ├── main
    ├── hotfix (branch config)
    └── canary (branch config)
```

### Pattern 3: Multi-Region Deployment

**Option 1: Region as Environment**
```
api-service
├── dev
├── staging-us-east
├── staging-eu-west
├── production-us-east
└── production-eu-west
```

**Option 2: Region as Project**
```
api-us-east
├── dev
├── staging
└── production

api-eu-west
├── dev
├── staging
└── production
```

**Option 3: Region as Branch Config**
```
api-service
├── dev
├── staging
│   ├── us-east
│   └── eu-west
└── production
    ├── us-east
    └── eu-west
```

## Access Control Patterns

### Role-Based Structure

```
Developer Access:
├── *-dev: Read/Write
├── *-staging: Read Only
└── *-production: No Access

DevOps Access:
├── *-dev: Read/Write
├── *-staging: Read/Write
└── *-production: Read/Write

QA Access:
├── *-dev: Read Only
├── *-staging: Read/Write
└── *-production: No Access
```

### Team-Based Structure

```
Team: payments
├── payments-*: Full Access
├── shared-config: Read Only
└── other-projects: No Access

Team: frontend
├── frontend-*: Full Access
├── backend-api: Read Only (specific endpoints)
└── payments-*: No Access
```

## Best Practices

### 1. Naming Conventions

**DO:**
- Use consistent separators (hyphens recommended)
- Include context (team, service, region)
- Keep names descriptive but concise
- Use lowercase for consistency

**DON'T:**
- Use special characters (except hyphens/underscores)
- Create overly generic names
- Mix naming patterns
- Use environment names in project names

### 2. Project Organization

**DO:**
- Group related services
- Create shared configuration projects
- Plan for growth
- Document your structure

**DON'T:**
- Create one project per team
- Mix unrelated services
- Overcomplicate initially
- Ignore access patterns

### 3. Environment Management

**DO:**
- Standardize environment names
- Use inheritance effectively
- Keep production isolated
- Plan for branches

**DON'T:**
- Create too many environments
- Mix deployment stages
- Share sensitive environments
- Ignore environment limits

## Common Scenarios

### Scenario 1: Startup to Scale
```
# Initial Structure (Startup)
my-app
├── dev
├── staging
└── production

# Scaled Structure (Growth)
backend-api
├── dev
├── staging
└── production

frontend-web
├── dev
├── staging
└── production

mobile-app
├── dev
├── staging
└── production
```

### Scenario 2: Feature Branch Workflow
```
backend-api
├── dev
│   ├── main
│   ├── feature-auth-redesign
│   └── feature-payment-integration
├── staging
│   └── main
└── production
    └── main
```

### Scenario 3: Blue-Green Deployment
```
web-app
├── dev
├── staging
└── production
    ├── blue (current)
    └── green (next)
```

## Migration Strategies

### From Flat Structure to Hierarchical

**Before:**
```
app-dev
app-staging
app-production
api-dev
api-staging
api-production
```

**After:**
```
app
├── dev
├── staging
└── production

api
├── dev
├── staging
└── production
```

### Consolidation Strategy

**Before:**
```
frontend-team-web-app
frontend-team-mobile-app
backend-team-api
backend-team-workers
```

**After:**
```
web-app
mobile-app
backend-api
backend-workers
```

## Limits and Considerations

### Hard Limits
- 1000 projects per workplace
- 15 environments per project
- Project names: 64 characters
- Environment names: 64 characters

### Soft Recommendations
- 3-5 environments per project (typical)
- 50-200 projects per workplace (manageable)
- 20-30 characters for names (readable)
- 3-4 hierarchy levels (navigable)

## Anti-Patterns to Avoid

### 1. One Project Per Team
```
# Wrong
team-backend
├── dev-api
├── dev-worker
├── staging-api
└── staging-worker
```

### 2. Environment in Project Name
```
# Wrong
my-app-dev
my-app-staging
my-app-production
```

### 3. Overly Generic Names
```
# Wrong
project1
service-a
test-env
```

### 4. Mixing Concerns
```
# Wrong
everything-project
├── frontend-dev
├── backend-staging
├── database-production
└── monitoring-dev
```

## Summary

A well-structured Doppler workplace:
- Reflects your application architecture
- Supports your team structure
- Scales with growth
- Maintains security boundaries
- Enables efficient workflows

Start simple and evolve your structure as your needs grow. The flexibility of Doppler's hierarchy allows you to reorganize without losing data or breaking integrations.