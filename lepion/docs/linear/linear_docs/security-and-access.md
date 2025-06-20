---
title: "Security & Access"
description: "Security features and access control guide"
category: "security"
type: "guide"
tags: ["doppler", "security", "access-control"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Security & Access

Manage your account security and access settings in Linear.

## Overview

The Security & Access page (found at **Settings > Account > Security & Access**) provides centralized control over:
- Connected devices and sessions
- Passkey authentication
- Personal API keys
- OAuth application permissions

## Sessions Management

### View Active Sessions

Monitor all devices and locations accessing your Linear account:
- **Device type**: Desktop, mobile, or browser information
- **Location**: Geographic location of access
- **Last seen**: Most recent activity timestamp
- **Additional details**: Click any entry to view IP address and original sign-in date

### Revoke Access

Two options for managing sessions:
1. **Individual revocation**: Hover over a session and click "Revoke access"
2. **Revoke all**: Remove all connections except your current session

Use cases:
- Lost or stolen devices
- Suspicious activity
- Regular security maintenance

## Passkeys

### What are Passkeys?

Passkeys provide passwordless authentication that is:
- More secure than traditional passwords
- Faster to use
- Resistant to phishing attacks

### Supported Platforms

- All major browsers (Chrome, Safari, Firefox, Edge)
- Mobile operating systems (iOS, Android)
- Password managers (1Password, etc.)

### Managing Passkeys

- Register multiple devices for passkey login
- Each device maintains its own passkey
- Remove passkeys for lost or replaced devices

## Personal API Keys

### Creating API Keys

Generate API keys for:
- Personal automation scripts
- Custom integrations
- Development and testing

### Managing API Keys

- View all active API keys
- See creation dates and last usage
- Revoke keys that are no longer needed

### Security Best Practices

- Rotate API keys regularly
- Use descriptive names for keys
- Never share API keys or commit them to repositories
- Revoke immediately if compromised

## OAuth Applications

### Authorized Applications

View and manage third-party applications with access to your Linear account:
- Application name and developer
- Granted permissions and scopes
- Authorization date

### Revoking OAuth Access

1. Hover over an application
2. Click "Revoke access"
3. The application immediately loses access to your account

Common OAuth applications:
- Development tools
- Time tracking software
- Reporting and analytics tools
- Communication platforms

## Security Recommendations

1. **Regular audits**: Review active sessions monthly
2. **Use passkeys**: Enable for enhanced security
3. **Minimize API keys**: Only create what you need
4. **Review OAuth apps**: Remove unused integrations
5. **Monitor locations**: Check for unexpected access locations

## Troubleshooting

### Can't Access Account
- Use "Forgot password" if locked out
- Contact workspace admin if suspended
- Check email for security alerts

### Suspicious Activity
1. Immediately revoke all sessions
2. Change your password
3. Enable passkeys for added security
4. Review OAuth applications
5. Contact support if needed

## Related Topics

- [Profile](profile.md)
- [Login Methods](../workspace-management/login-methods.md)
- [API and Webhooks](../workspace-management/api-and-webhooks.md)
- [Third-party Application Approvals](../workspace-management/third-party-application-approvals.md)
