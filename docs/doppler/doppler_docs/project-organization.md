---
title: "Doppler Project Organization"
description: "Learn best practices for organizing Doppler projects, environments, and configurations with proper naming conventions and structural hierarchy"
category: "project-management"
type: "guide"
tags: ["doppler", "organization", "projects", "environments", "structure", "best-practices"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Project Organization

## Core Organizational Concepts

### Workplace Structure

```
Workplace (Organization)
├── Projects (Applications/Services)
│   ├── Environments (dev, staging, production)
│   │   ├── Root Config
│   │   └── Branch Configs
│   └── Secrets
└── Team Members & Permissions
```

## Project Naming Best Practices

Projects should map 1:1 to a specific application or service. Follow these naming conventions:

### Naming Patterns

1. **Team Prefixes**: Group projects by team
   ```
   frontend-website
   frontend-dashboard
   backend-api
   backend-workers
   ```

2. **Service-Based Naming**: Use descriptive service names
   ```
   auth-service
   payment-gateway
   notification-engine
   ```

3. **Region Suffixes**: Add region codes when needed
   ```
   api-service-us-east
   api-service-eu-west
   ```

### Naming Rules
- Use lowercase letters
- Separate words with hyphens
- Keep names concise but descriptive
- Maximum of 1000 projects per workplace

## Environment Structure

Each project contains environments that map to your deployment stages:

### Default Environments
- **Development** (`dev`): Local development
- **Staging** (`stg`): Pre-production testing
- **Production** (`prd`): Live application

### Custom Environment Examples
- `ci`: Continuous Integration
- `qa`: Quality Assurance testing
- `demo`: Customer demonstrations
- `pr-review`: Pull request previews

### Environment Limitations
- Maximum of 15 environments per project
- Environments share similar secret structures
- Access control applies to all configs within an environment

## Organizational Strategies

### 1. Microservices Architecture

#### Option A: Separate Projects per Service
```
auth-service
├── dev
├── staging
└── production

user-service
├── dev
├── staging
└── production
```

**Pros**: Granular access control, clear separation
**Cons**: More projects to manage

#### Option B: Single Project with Branch Configs
```
backend-services
├── dev
│   ├── auth-service
│   └── user-service
├── staging
│   ├── auth-service
│   └── user-service
└── production
    ├── auth-service
    └── user-service
```

**Pros**: Simplified management
**Cons**: Less granular access control

### 2. Shared Secrets Strategy

Create dedicated projects for shared configuration:

```
shared-database
├── dev
├── staging
└── production

shared-external-apis
├── dev
├── staging
└── production
```

Use cross-project references:
```
DATABASE_URL=${shared-database.DATABASE_URL}
```

### 3. Multi-Region Architecture

#### Option A: Region in Project Name
```
api-us-east
api-eu-west
api-ap-south
```

#### Option B: Region as Environment
```
api-service
├── dev-us
├── dev-eu
├── prod-us
└── prod-eu
```

## Dynamic Environments

For temporary or dynamic environments:

### Pull Request Environments
```
frontend-app
├── dev
├── staging
├── production
└── pr-123  (temporary)
```

### Feature Branch Configs
```
backend-api
└── dev
    ├── root
    ├── feature-auth
    └── feature-payment
```

## Anti-Patterns to Avoid

### ❌ Single Project per Team
```
team-alpha-project  // Contains all services
```
This reduces isolation and complicates access control.

### ❌ Environment Overloading
```
backend-api
├── dev-john
├── dev-sarah
├── dev-testing
└── dev-integration
```
Use branch configs instead for developer-specific configurations.

### ❌ Inconsistent Naming
```
API-Service
backend_workers
frontend.dashboard
```
Maintain consistent naming conventions across all projects.

## Project Organization Checklist

- [ ] Define clear project boundaries (1 project = 1 service)
- [ ] Establish naming conventions before creating projects
- [ ] Plan environment structure based on deployment pipeline
- [ ] Identify shared secrets and create dedicated projects
- [ ] Document project ownership and responsibilities
- [ ] Set up appropriate access controls from the start
- [ ] Consider future scaling needs (regions, services)

## Tips for Large Organizations

1. **Use Prefixes Strategically**: Group related projects with common prefixes
2. **Document Everything**: Maintain a project registry with descriptions
3. **Regular Audits**: Review project structure quarterly
4. **Automate Creation**: Use Doppler's API for consistent project setup
5. **Template Projects**: Create template configurations for common patterns