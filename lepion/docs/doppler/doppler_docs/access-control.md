---
title: "Doppler Access Control & Permissions"
description: "Guide to managing user permissions and access control in Doppler"
category: "security"
type: "guide"
tags: ["doppler", "access-control", "permissions", "security"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Access Control & Permissions

## Permission Levels Overview

Doppler uses a hierarchical permission system with three project-based access levels:

### 1. **Viewer**
- Read-only access to secrets
- Cannot modify configurations
- Cannot manage tokens or settings

### 2. **Collaborator**
- Read and write access to secrets
- Can manage service tokens
- Can configure trusted IPs
- **Cannot**: Rename or delete configs

### 3. **Admin**
- Full project control
- All Collaborator permissions
- Can rename and delete configs
- Can manage project members

## Workplace-Level Permissions

### Owner
- Full control over the entire workplace
- Can manage billing and subscription
- Automatically has admin access to all projects

### Admin
- Workplace management capabilities
- Automatically has admin access to all projects
- Cannot manage billing

## Access Management

### Granting Access by User

1. Navigate to Team dashboard
2. Select the user
3. Click "Add Project Access"
4. Choose:
   - Project
   - Role (Viewer/Collaborator/Admin)
   - Specific environments/configs

### Granting Access by Project

1. Open the project
2. Click "Members" button
3. Select "Add Members"
4. Assign:
   - User
   - Role
   - Environment permissions

## Environment-Specific Access

Collaborators can be granted access to specific environments:

```
Project: api-service
├── User: john@company.com
│   ├── Role: Collaborator
│   └── Access: [dev, staging]
└── User: sarah@company.com
    ├── Role: Admin
    └── Access: [all environments]
```

## Service Token Permissions

Service tokens inherit permissions based on:
- The config they're created in
- The user who created them
- Token-specific restrictions

### Token Types
- **Read-Only**: Can only fetch secrets
- **Read/Write**: Can fetch and modify secrets
- **CI/CD Token**: Optimized for pipeline usage

## Advanced Permission Features

### Role-Based Access Control (RBAC)
> **Note**: RBAC requires Team or Enterprise subscription

Features include:
- Custom roles
- Granular permissions
- Permission templates
- Audit logging

### Trusted IP Restrictions
Collaborators can configure:
- IP allowlists for specific environments
- Service token IP restrictions
- Dashboard access limitations

## Permission Best Practices

### 1. Principle of Least Privilege
- Grant minimum necessary permissions
- Use environment-specific access
- Regularly audit permissions

### 2. Separation of Concerns
```
Developer Team:
- Dev: Admin
- Staging: Collaborator
- Production: Viewer

DevOps Team:
- All environments: Admin
```

### 3. Service Token Management
- Create dedicated tokens per service
- Use read-only tokens when possible
- Rotate tokens regularly
- Name tokens descriptively

## Common Permission Scenarios

### Scenario 1: Developer Onboarding
```bash
# Grant dev environment access
Project: backend-api
Role: Collaborator
Environments: [dev]
```

### Scenario 2: CI/CD Pipeline
```bash
# Create read-only token for production deployments
Project: backend-api
Environment: production
Type: Service Token (Read-Only)
```

### Scenario 3: Cross-Team Collaboration
```bash
# Frontend team needs backend secrets
Project: backend-api
Role: Viewer
Environments: [dev, staging]
Secrets: Limited to specific API keys
```

## Security Considerations

### Access Reviews
- Conduct monthly permission audits
- Remove access for departed team members
- Review service token usage

### Compliance Requirements
- Maintain access logs
- Document permission changes
- Implement approval workflows for production access

## Troubleshooting Permissions

### Common Issues

1. **"Access Denied" Errors**
   - Verify user has project access
   - Check environment-specific permissions
   - Confirm workplace-level permissions

2. **Service Token Not Working**
   - Validate token hasn't expired
   - Check IP restrictions
   - Verify config access

3. **Cannot Modify Secrets**
   - Ensure Collaborator or Admin role
   - Check restricted secret visibility
   - Verify environment access

## Permission Matrix

| Action | Viewer | Collaborator | Admin | Workplace Admin |
|--------|--------|--------------|-------|-----------------|
| View secrets | ✓ | ✓ | ✓ | ✓ |
| Modify secrets | ✗ | ✓ | ✓ | ✓ |
| Create service tokens | ✗ | ✓ | ✓ | ✓ |
| Delete configs | ✗ | ✗ | ✓ | ✓ |
| Manage members | ✗ | ✗ | ✓ | ✓ |
| Create projects | ✗ | ✗ | ✗ | ✓ |