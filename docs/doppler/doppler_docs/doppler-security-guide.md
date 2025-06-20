---
title: "Doppler Security Features and Best Practices Guide"
description: "Master Doppler security with service token management, trusted IP configurations, permission models, webhooks, and configuration inheritance patterns"
category: "security"
type: "guide"
tags: ["doppler", "security", "service-tokens", "permissions", "webhooks", "best-practices"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Security Features and Best Practices Guide

## Table of Contents
1. [Service Token Management and Security](#service-token-management-and-security)
2. [Trusted IP Configurations](#trusted-ip-configurations)
3. [Project Permission Models](#project-permission-models)
4. [Webhook Implementation](#webhook-implementation)
5. [Configuration Inheritance Patterns](#configuration-inheritance-patterns)
6. [Root and Branch Config Management](#root-and-branch-config-management)

---

## Service Token Management and Security

### Overview
Service tokens provide read-only access to specific configs, implementing the principle of least privilege. They are the recommended authentication method for production environments.

### Security Best Practices

#### ⚠️ Critical Security Warnings
- **NEVER use CLI or Personal Tokens in production** - these provide write access
- **Service tokens are displayed only once** - store them securely immediately
- **Each token should be unique per service/environment** - never share tokens

#### Token Creation and Management

##### Via Dashboard
1. Navigate to Project → Config → Access tab
2. Generate token with specific permissions
3. Consider setting expiration for temporary access
4. Store token securely in your secrets management system

##### Via CLI
```bash
doppler configs tokens create --project PROJECT --config CONFIG --name TOKEN_NAME
```

#### Security Recommendations

1. **Use Ephemeral Tokens** when possible
   - Set automatic expiration
   - Reduces risk of long-term exposure
   - Ideal for CI/CD pipelines

2. **Token Storage Methods** (in order of security)
   - Environment variable: `DOPPLER_TOKEN`
   - Persisted service token (for VMs only)
   - CLI argument: `--token` (least secure, visible in process lists)

3. **Token Rotation Strategy**
   - Implement regular rotation schedules
   - Use separate tokens for different services
   - Monitor token usage through audit logs
   - Revoke immediately if compromised

4. **Revocation Process**
   - Can be done via dashboard or CLI
   - Takes effect immediately
   - Note: CLI fallback files may retain cached secrets

---

## Trusted IP Configurations

### Overview
Trusted IPs restrict config access to specific network ranges, providing network-level security for your secrets.

### ⚠️ Important Limitations
- **Only available in Team and Enterprise plans**
- **Only restricts API access** - does NOT control dashboard login access
- **Default allows all traffic** (`0.0.0.0/0`) - must be explicitly configured

### Configuration Best Practices

1. **Remove Global Whitelist First**
   - Default configuration allows all internet traffic
   - Always remove `0.0.0.0/0` before adding specific ranges

2. **Use CIDR Notation Correctly**
   - Example: `183.27.224.0/24` for a subnet
   - Example: `192.168.1.100/32` for a single IP

3. **Document Your IP Ranges**
   ```
   # Production servers: 10.0.1.0/24
   # CI/CD pipeline: 172.16.0.0/16
   # Office network: 203.0.113.0/24
   ```

4. **Security Recommendations**
   - Use the most restrictive ranges possible
   - Regularly audit and update IP ranges
   - Consider using VPN endpoints for remote access
   - Plan for disaster recovery scenarios

### Implementation Checklist
- [ ] Identify all legitimate access points
- [ ] Document IP ranges with descriptions
- [ ] Remove global whitelist
- [ ] Add specific trusted ranges
- [ ] Test access from approved and unapproved IPs
- [ ] Create runbook for IP range updates

---

## Project Permission Models

### Overview
Doppler uses a role-based access control (RBAC) system with three project-level roles.

### Permission Levels

| Role | Capabilities | Restrictions |
|------|-------------|--------------|
| **Viewer** | Read secrets, view configs | Cannot modify anything |
| **Collaborator** | Manage secrets, configure trusted IPs, manage service tokens | Cannot rename/delete configs |
| **Admin** | Full project control | No restrictions |

### ⚠️ Security Considerations
- **Workplace Owners/Admins automatically have full project access**
- **Collaborators need explicit environment permissions**
- **Role-based access requires Team or Enterprise subscription**

### Best Practices

1. **Principle of Least Privilege**
   - Start with Viewer access
   - Upgrade to Collaborator only when needed
   - Limit Admin access to essential personnel

2. **Environment-Specific Permissions**
   - Grant production access sparingly
   - Use different permission levels per environment
   - Regularly audit access lists

3. **Access Management Process**
   ```
   1. Identify user's actual needs
   2. Grant minimum required role
   3. Set environment-specific permissions
   4. Document access reasoning
   5. Schedule periodic access reviews
   ```

4. **Security Recommendations**
   - Implement quarterly access reviews
   - Remove access immediately upon role changes
   - Use service tokens instead of user access for automation
   - Monitor permission changes through audit logs

---

## Webhook Implementation

### Overview
Webhooks enable automatic notifications when secrets change, but require careful security configuration.

### ⚠️ Security Warnings
- **Webhooks are NOT guaranteed exactly-once delivery**
- **Payload may contain sensitive information**
- **Always use HTTPS endpoints**
- **Implement request signing for authentication**

### Security Implementation

#### 1. Request Signing (Highly Recommended)
```python
# Example signature verification
import hmac
import hashlib

def verify_webhook(payload, signature, secret):
    expected = hmac.new(
        secret.encode(),
        payload.encode(),
        hashlib.sha256
    ).hexdigest()
    
    # Use timing-safe comparison
    return hmac.compare_digest(expected, signature)
```

#### 2. Webhook Configuration Best Practices
- Use unique signing secrets per webhook
- Rotate signing secrets periodically
- Implement IP allowlisting on webhook endpoints
- Add rate limiting to prevent abuse
- Log all webhook attempts for auditing

#### 3. Payload Security
- Default payload includes secret differences
- Consider custom payloads to minimize data exposure
- Never log full webhook payloads
- Implement encryption for sensitive webhook data

### Implementation Checklist
- [ ] Use HTTPS endpoint only
- [ ] Implement request signing
- [ ] Add IP allowlisting
- [ ] Configure rate limiting
- [ ] Set up monitoring and alerting
- [ ] Test failure scenarios
- [ ] Document webhook endpoints

---

## Configuration Inheritance Patterns

### Overview
Config inheritance allows sharing secrets across configs but requires careful planning to avoid security issues.

### ⚠️ Security Warnings
- **Only available in Team and Enterprise plans**
- **Dynamic Secrets are NOT supported**
- **Inheritance can be disabled at multiple levels**
- **Secret conflicts follow precedence rules**

### Security Best Practices

1. **Inheritance Hierarchy Design**
   ```
   Base Config (shared credentials)
   ├── Production Config (inherits base)
   ├── Staging Config (inherits base)
   └── Development Config (inherits base)
   ```

2. **Precedence Rules** (highest to lowest)
   - Config's own secrets
   - First inherited config
   - Second inherited config
   - (and so on...)

3. **Security Recommendations**
   - Never inherit production secrets into lower environments
   - Use inheritance for read-only shared resources
   - Document inheritance relationships clearly
   - Regularly audit inherited secrets
   - Monitor for unintended secret exposure

4. **Anti-Patterns to Avoid**
   - Circular inheritance dependencies
   - Over-sharing sensitive credentials
   - Using inheritance for temporary overrides
   - Inheriting secrets with environment-specific values

---

## Root and Branch Config Management

### Overview
Root configs represent core environments while branch configs enable specialized use cases.

### Root Config Security

#### Best Practices
1. **Environment Segregation**
   - Maintain strict separation between dev, stg, and prd
   - Never copy production secrets to lower environments
   - Use missing secret detection to ensure consistency

2. **Custom Environment Considerations**
   - Add CI environment for build processes
   - Create separate configs for different regions
   - Implement proper access controls per environment

3. **Secret Mirroring** 
   - **Prefer secret references over manual mirroring**
   - Audit mirrored secrets regularly
   - Document why secrets are mirrored
   - Set up alerts for secret divergence

### Branch Config Security

#### Use Cases and Security Implications

1. **Personal Development Configs**
   - ✅ Automatically created for users with write access
   - ✅ Private to individual developers
   - ⚠️ Can override production values if misconfigured
   - ⚠️ May accumulate stale secrets over time

2. **Feature Branch Configs**
   - Use for isolated feature development
   - Set expiration dates when possible
   - Clean up after feature completion
   - Restrict access to feature team only

3. **Security Best Practices**
   - Lock configs to prevent accidental modifications
   - Implement naming conventions (e.g., `feature/auth-update`)
   - Regular cleanup of unused branch configs
   - Monitor branch config creation
   - Audit override patterns

### Implementation Guidelines

#### Config Lifecycle Management
```
1. Creation
   - Document purpose and owner
   - Set appropriate permissions
   - Configure inheritance if needed

2. Active Use
   - Monitor for unusual changes
   - Regular security audits
   - Update documentation

3. Deprecation
   - Remove unnecessary access
   - Archive or delete configs
   - Update dependent systems
```

---

## General Security Recommendations

### 1. Regular Security Audits
- [ ] Review all service tokens quarterly
- [ ] Audit trusted IP configurations
- [ ] Check user permissions and access
- [ ] Verify webhook endpoints and signatures
- [ ] Review inheritance relationships
- [ ] Clean up unused configs

### 2. Monitoring and Alerting
- Set up alerts for:
  - New service token creation
  - Permission changes
  - Trusted IP modifications
  - Failed webhook deliveries
  - Config inheritance changes
  - Unusual access patterns

### 3. Incident Response Plan
1. **Token Compromise**
   - Immediately revoke affected tokens
   - Rotate all potentially exposed secrets
   - Review audit logs for unauthorized access
   - Update all dependent systems

2. **Unauthorized Access**
   - Lock affected configs
   - Review and update trusted IPs
   - Audit recent secret changes
   - Notify security team

### 4. Documentation Requirements
- Maintain current documentation of:
  - All service tokens and their purposes
  - Trusted IP ranges and justifications
  - User permissions matrix
  - Webhook endpoints and handlers
  - Config inheritance diagrams
  - Emergency response procedures

---

## Conclusion

Doppler provides robust security features, but they must be properly configured and maintained. Regular audits, proper access controls, and adherence to these best practices will help ensure your secrets remain secure.

Remember: **Security is not a one-time configuration but an ongoing process.** Regularly review and update your security settings as your infrastructure and team evolve.