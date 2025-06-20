---
title: "Admin Settings & Workspace Management"
description: "- [Administrative Overview](#administrative-overview)"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Admin Settings & Workspace Management

Complete guide to advanced workspace administration, security settings, analytics, and enterprise features in Linear.

## 📋 Table of Contents

- [Administrative Overview](#administrative-overview)
- [Security & Access Control](#security-access-control)
- [SCIM User Provisioning](#scim-user-provisioning)
- [Analytics & Insights](#analytics-insights)
- [Billing & Plans](#billing-plans)
- [Data Management](#data-management)
- [Enterprise Features](#enterprise-features)
- [Audit & Compliance](#audit-compliance)
- [Advanced Configuration](#advanced-configuration)

---

## 👨‍💼 Administrative Overview

### Admin Responsibilities
Linear workspace administrators have comprehensive control over workspace settings, user management, security policies, and integrations. Admin access provides additional capabilities beyond standard member permissions.

### Admin-Only Features
- **User management**: Invite, suspend, and manage member roles
- **Security settings**: SAML, SCIM, login method configuration
- **Billing management**: Plan changes and payment administration
- **Data controls**: Import/export capabilities
- **Workspace settings**: Organization-wide configurations
- **Integration management**: Approve and configure workspace integrations

### Accessing Admin Settings
1. **Click workspace name** in upper left corner
2. **Select Settings** from dropdown
3. **Navigate to Administration** section (admin-only)
4. **Choose specific admin area** from sidebar

### Admin Setting Categories
| Category | Purpose | Key Features |
|----------|---------|---------------|
| **General** | Basic workspace settings | Name, URL, features |
| **Members** | User and role management | Invitations, suspensions, roles |
| **Security** | Authentication and access | SAML, SCIM, login methods |
| **Billing** | Payment and plan management | Subscriptions, usage |
| **Import/Export** | Data migration | Bulk operations |
| **Integrations** | Third-party connections | OAuth apps, webhooks |

---

## 🔒 Security & Access Control

### Authentication Methods

#### Login Method Configuration
**Available Options**:
- **Email/Password**: Traditional authentication
- **Google SSO**: Google Workspace integration
- **SAML**: Enterprise identity provider
- **GitHub**: Developer-focused authentication
- **Magic links**: Passwordless email authentication

**Configuration Steps**:
1. Go to **Settings > Administration > Security**
2. **Choose allowed methods** for your workspace
3. **Configure provider settings** (for SSO)
4. **Test authentication** before enforcing
5. **Communicate changes** to team members

#### SAML Configuration
**Prerequisites**:
- Enterprise plan subscription
- Access to identity provider configuration
- Domain verification

**Setup Process**:
1. **Enable SAML** in Linear security settings
2. **Configure identity provider** with Linear details
3. **Map user attributes** (email, name, groups)
4. **Test SSO flow** with test user
5. **Enable enforcement** for all users

**Supported Identity Providers**:
- **Okta**: Full SAML 2.0 support
- **Azure AD**: Microsoft integration
- **OneLogin**: Complete SSO solution
- **Auth0**: Custom authentication flows
- **Google Workspace**: Google SSO integration

### Access Control

#### Workspace Security Settings
**Domain Restrictions**:
- **Approved email domains**: Auto-join for company emails
- **Domain verification**: Confirm ownership
- **Guest access controls**: Limit external user access

**Session Management**:
- **Session timeouts**: Automatic logout configuration
- **Device management**: Monitor and revoke active sessions
- **Location tracking**: Geographic access monitoring

#### Third-Party App Management
**App Review Process**:
- **Admin approval required**: Control integration installations
- **Security assessment**: Review app permissions
- **Usage monitoring**: Track connected applications
- **Revocation controls**: Remove access when needed

### Two-Factor Authentication
**Enforcement Options**:
- **Required for admins**: Mandatory 2FA for administrators
- **Organization-wide**: Required for all users
- **Optional**: User choice for 2FA enablement

---

## 🔄 SCIM User Provisioning

### SCIM Overview
SCIM (System for Cross-domain Identity Management) enables automated user provisioning, allowing user accounts to be automatically created, updated, and suspended based on identity provider settings.

**Enterprise Feature**: Available on Enterprise plans only

### SCIM Benefits
- **Automated provisioning**: Users created automatically from IdP
- **Lifecycle management**: Updates and suspensions sync automatically
- **Reduced admin overhead**: Eliminate manual user management
- **Security compliance**: Ensure access stays synchronized
- **Group synchronization**: Map IdP groups to Linear teams

### SCIM Setup Process

#### Enable SCIM in Linear
1. **Navigate to** Settings > Administration > Security
2. **Click Configure** next to "SAML & SCIM"
3. **Toggle SCIM** enablement
4. **Copy configuration details**:
   - SCIM base connector URL
   - Bearer authentication token
5. **Note**: Manual user management becomes restricted

#### Identity Provider Configuration

**Okta Setup**:
1. **Open Linear application** in Okta admin
2. **Edit General settings** and choose SCIM provisioning
3. **Configure Provisioning tab**:
   - Enter SCIM base connector URL
   - Set unique identifier to "email"
   - Enable provisioning actions
   - Configure HTTP Header authentication with Bearer token
4. **Test configuration** and save
5. **Enable SCIM functionality** (Create, Update, Deactivate users)

**OneLogin Setup**:
1. **Add App** in OneLogin admin panel
2. **Search for** "SCIM Provisioner with SAML"
3. **Configure** with SCIM URL and Bearer token
4. **Enable Provisioning** in Provisioning tab
5. **Save application** configuration

### Group Synchronization
**Group Push Setup**:
- **Enable group push** in identity provider
- **Map IdP groups** to Linear teams (1:1 mapping)
- **Sync existing teams** with IdP groups
- **Configure group membership** rules

**Team Mapping**:
1. **Create groups** in identity provider
2. **Push groups** to Linear via SCIM
3. **Link existing teams** to synced groups
4. **Configure member assignments** through IdP

### SCIM Best Practices
1. **Test thoroughly**: Verify provisioning with test users
2. **Plan team structure**: Align IdP groups with Linear teams
3. **Monitor sync status**: Regular verification of user states
4. **Document mappings**: Clear record of group relationships
5. **Have fallback plan**: Manual override capabilities if needed

---

## 📊 Analytics & Insights

### Insights Overview
Linear Insights provides real-time analytics for all Linear data, enabling teams to visualize issue trends, identify bottlenecks, and optimize workflows.

**Plan Availability**: Business and Enterprise plans

### Insights Capabilities
**Key Questions Answered**:
- What projects consume the most resources?
- How quickly are bugs resolved?
- How consistent is issue prioritization?
- How accurate are time estimates?
- What are the team velocity trends?

### Accessing Insights

#### Location Options
- **Views**: Custom views with Insights sidebar
- **Teams**: Team-specific analytics
- **Projects**: Project progress analysis
- **Cycles**: Sprint performance metrics

#### Opening Insights
- **Keyboard shortcut**: `Cmd/Ctrl + Shift + I`
- **Sidebar**: Click Insights panel in right sidebar
- **Best location**: Workspace-level custom views for maximum flexibility

### Creating Insights

#### Data Filtering
**Useful Filters for Analytics**:
| Filter | Purpose | Use Case |
|--------|---------|----------|
| **Created at** | Time-based analysis | Limit to specific periods |
| **Completed at** | Completion trends | Track delivery patterns |
| **Status Type** | Cross-team analysis | Works with different status names |
| **Label/Project/Team** | Focused analysis | Specific area deep-dives |

**Advanced Options**:
- **Show archived issues**: Include completed work in analysis
- **Filter unprioritized**: Remove unassigned priority items
- **Date ranges**: Custom time period selection

#### Insights Parameters

**Measures (Y-axis)**:
| Measure | Description | Graph Type | Filters |
|---------|-------------|------------|---------|
| **Issue Count** | Total number of issues | Bar | None |
| **Effort** | Total estimate value | Bar | None |
| **Cycle Time** | Time from start to completion | Scatterplot | In-progress issues only |
| **Lead Time** | Time from creation to completion | Scatterplot | Completed issues only |

**Slices (X-axis)**:
- **Time periods**: Days, weeks, months, quarters
- **Teams**: Cross-team comparison
- **Projects**: Resource allocation analysis
- **Assignees**: Individual performance
- **Labels**: Work type distribution
- **Priority**: Urgency analysis

**Segments (Color coding)**:
- **Additional dimension**: Further data breakdown
- **Color differentiation**: Visual pattern recognition
- **Trend identification**: Multi-variable analysis

### Common Insights Use Cases

#### Team Performance Analysis
```
Measure: Issue Count
Slice: Week
Segment: Team
Filter: Completed at > 30 days ago
```

#### Bug Resolution Tracking
```
Measure: Cycle Time
Slice: Month
Segment: Priority
Filter: Label = "bug", Completed at > 90 days ago
```

#### Project Resource Analysis
```
Measure: Effort
Slice: Project
Segment: Team
Filter: Created at > Q1 2024
```

#### Velocity Trends
```
Measure: Issue Count
Slice: Cycle
Segment: Team
Filter: Status Type = completed
```

### Insights Best Practices
1. **Start with questions**: Define what you want to learn
2. **Use appropriate timeframes**: Seasonal and business cycle considerations
3. **Combine filters**: Multiple dimensions for deeper insights
4. **Regular reviews**: Weekly/monthly team discussions
5. **Action-oriented**: Convert insights into process improvements

---

## 💳 Billing & Plans

### Plan Management

#### Available Plans
| Plan | Features | User Limits | Key Capabilities |
|------|----------|-------------|------------------|
| **Free** | Basic features | Up to 10 users | Core issue tracking |
| **Standard** | Full features | Unlimited users | Advanced workflows |
| **Business** | Analytics + automation | Unlimited users | Insights, SLA, automation |
| **Enterprise** | Security + compliance | Unlimited users | SAML, SCIM, audit logs |

#### Plan Comparison
**Standard vs Business**:
- **Insights**: Advanced analytics (Business+)
- **SLA tracking**: Service level agreements (Business+)
- **Advanced automation**: Complex workflows (Business+)
- **Priority support**: Faster response times (Business+)

**Business vs Enterprise**:
- **SAML/SCIM**: Enterprise authentication (Enterprise only)
- **Audit logs**: Compliance tracking (Enterprise only)
- **Advanced security**: Enhanced controls (Enterprise only)
- **Dedicated support**: Account management (Enterprise only)

### Billing Administration

#### Payment Management
- **Billing cycles**: Monthly or annual options
- **Payment methods**: Credit cards, invoicing (Enterprise)
- **Usage tracking**: User count and feature utilization
- **Cost optimization**: Regular plan review and adjustment

#### User Billing
**How Users Are Counted**:
- **Active members**: All workspace participants
- **Guests**: Counted as users (Business+ plans)
- **Suspended users**: Not counted toward limits
- **Admin users**: Counted same as regular users

**Billing Events**:
- **Adding users**: Prorated charges
- **Removing users**: Credit for unused time
- **Plan changes**: Immediate effect with prorated billing

---

## 📁 Data Management

### Import Capabilities

#### Supported Import Sources
- **Jira**: Full project and issue migration
- **GitHub Issues**: Issue and milestone import
- **Asana**: Task and project migration
- **Trello**: Board and card import
- **CSV**: Custom data format import

#### Import Process
1. **Prepare data**: Clean and organize source data
2. **Access import tool**: Settings > Administration > Import
3. **Select source**: Choose import method
4. **Map fields**: Align source data with Linear properties
5. **Review mapping**: Verify field assignments
6. **Execute import**: Run import process
7. **Verify results**: Check imported data accuracy

### Export Capabilities

#### Export Options
- **Issues**: Complete issue data with relationships
- **Projects**: Project structure and metadata
- **Comments**: Discussion threads and history
- **Attachments**: Files and images
- **Custom views**: Saved filter configurations

#### Export Formats
- **CSV**: Spreadsheet-compatible format
- **JSON**: Structured data format
- **GraphQL**: API-compatible export

### Data Backup Strategies
1. **Regular exports**: Scheduled data backups
2. **Version control**: Track important configuration changes
3. **API integration**: Custom backup solutions
4. **Documentation**: Record of custom configurations

---

## 🏢 Enterprise Features

### Advanced Security

#### Enterprise Security Controls
- **Advanced audit logs**: Comprehensive activity tracking
- **IP restrictions**: Geographic and network access controls
- **Advanced session management**: Enhanced security policies
- **Data residency**: Geographic data storage options
- **Compliance certifications**: SOC 2, GDPR compliance

#### Security Monitoring
- **Access logs**: User authentication tracking
- **Permission changes**: Role and access modifications
- **Data access**: Resource access monitoring
- **Integration activity**: Third-party app usage

### Enterprise Support

#### Support Tiers
- **Standard**: Community and documentation support
- **Business**: Email support with SLA
- **Enterprise**: Dedicated account management
- **Premium**: Phone support and custom SLA

#### Support Features
- **Priority response**: Faster issue resolution
- **Technical account management**: Dedicated contact
- **Custom training**: Team onboarding assistance
- **Implementation support**: Migration and setup help

---

## 📝 Audit & Compliance

### Audit Logging (Enterprise)

#### Tracked Activities
- **User management**: Account creation, suspension, role changes
- **Security events**: Login attempts, authentication changes
- **Data access**: Issue views, project access
- **Configuration changes**: Workspace settings modifications
- **Integration activity**: Third-party app connections

#### Audit Log Access
1. **Navigate to** Settings > Administration > Audit
2. **Filter events** by type, user, date range
3. **Export logs** for compliance reporting
4. **Review regularly** for security monitoring

### Compliance Features

#### Data Protection
- **GDPR compliance**: European data protection regulations
- **Data encryption**: At-rest and in-transit protection
- **Access controls**: Role-based permission systems
- **Data portability**: Export and deletion capabilities

#### Security Certifications
- **SOC 2 Type II**: Security and availability controls
- **ISO 27001**: Information security management
- **Privacy Shield**: US-EU data transfer framework

---

## ⚙️ Advanced Configuration

### Workspace Customization

#### Branding Options
- **Workspace name**: Organization identifier
- **Custom URL**: Branded workspace URL
- **Logo**: Organization branding (Enterprise)
- **Color schemes**: Custom theme options

#### Feature Configuration
- **Initiative settings**: Enable/disable initiatives
- **Project updates**: Configure update requirements
- **Cycle settings**: Default cycle length and behavior
- **Automation rules**: Workspace-wide automations

### Advanced Integrations

#### Webhook Management
- **Workspace webhooks**: Organization-wide event handling
- **Security configuration**: Webhook authentication and encryption
- **Event filtering**: Selective event subscription
- **Monitoring**: Webhook delivery tracking and debugging

#### API Management
- **Rate limiting**: Custom rate limit configuration
- **Access controls**: API key scope management
- **Usage monitoring**: API utilization tracking
- **Custom endpoints**: Enterprise API extensions

### Performance Optimization

#### Workspace Performance
- **Data archiving**: Automated cleanup policies
- **Search optimization**: Index configuration
- **Caching strategies**: Performance tuning
- **Resource monitoring**: Usage analytics

#### Scalability Planning
- **User growth**: Capacity planning
- **Data growth**: Storage management
- **Integration load**: External service impact
- **Performance monitoring**: Regular health checks

## 💡 Best Practices for Administrators

### Security Management
1. **Regular access reviews**: Quarterly user and permission audits
2. **Strong authentication**: Enforce 2FA and SSO where possible
3. **Principle of least privilege**: Minimal required access only
4. **Monitor integrations**: Regular review of connected applications
5. **Document policies**: Clear security and access procedures

### User Management
1. **Onboarding process**: Standardized new user setup
2. **Role definitions**: Clear permission levels and responsibilities
3. **Regular training**: Keep users updated on features and policies
4. **Offboarding procedure**: Secure user removal process
5. **Support structure**: Clear escalation paths for user issues

### Data Governance
1. **Backup strategy**: Regular data backup and recovery testing
2. **Retention policies**: Define data lifecycle management
3. **Privacy compliance**: Ensure regulatory requirement adherence
4. **Change management**: Controlled configuration changes
5. **Documentation**: Maintain administrative procedures and decisions

## 🔗 Related Guides

- **[Workspace Management](workspace-management.md)** - Basic team and workspace setup
- **[User Account](user-account.md)** - Individual user settings and preferences
- **[Integrations](integrations.md)** - Third-party tool connections
- **[API & CLI](api-cli.md)** - Developer tools and automation
- **[Getting Started](getting-started.md)** - Basic Linear concepts and setup

---

*Effective administration ensures your Linear workspace remains secure, compliant, and optimized for your organization's needs. Regular review and proactive management of these settings creates a foundation for productive team collaboration.*