---
title: "Workspace & Team Management"
description: "- [Workspace Setup](#workspace-setup)"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Workspace & Team Management

Complete guide to setting up and managing Linear workspaces, teams, members, and organizational structure.

## 📋 Table of Contents

- [Workspace Setup](#workspace-setup)
- [Team Organization](#team-organization)
- [Member Management](#member-management)
- [Roles & Permissions](#roles-permissions)
- [Login Methods & Security](#login-methods-security)
- [Workspace Settings](#workspace-settings)

---

## 🏢 Workspace Setup

### Overview
A workspace is the home for all issues and interactions for an organization. We recommend organizations stay within a single workspace as this is the conceptual model used when designing the product.

When a workspace is created, Linear automatically creates a default Team with the same name.

### Creating a Workspace
The first step to using Linear is to create a workspace for your team:

1. **Sign up** at linear.app
2. **Create workspace** with your organization name
3. **Configure initial team** settings
4. **Invite team members**
5. **Set up integrations**

### Workspace Settings

To navigate to workspace settings:
1. Click your workspace name in the upper left
2. Select Settings
3. If you are an admin, under Administration, there is a Workspace page

#### Admin-Only Settings
Admins have an "Administration" section not viewable by members or guests:

**Administrative Controls:**
- Update workspace name and URL
- Manage login preferences
- Turn on/off third-party app review requirements (Enterprise feature)
- Set up Project Updates
- Turn on/off the Initiatives feature
- Add or remove members from the workspace
- Import or export issues
- Change plans
- View or update billing information

**Shared Admin/Member Capabilities:**
- Create workspace-level labels
- Create custom project statuses
- Create workspace-level templates for issues, projects, and documents
- Apply SLA rules (paid feature)
- Customize Asks templates (paid feature)
- Add custom emojis
- View your plan type
- Configure workspace-specific integrations

### Multiple Workspaces
You can create multiple workspaces under a single account (tied to a specific email). 

**Best Practice**: If using Linear for both work and personal purposes, create multiple Linear accounts with separate email addresses.

#### Adding/Switching Workspaces
1. Click on your workspace name in the top left corner
2. Hover over "Switch workspace"
3. Select "Create or join a workspace"
4. If you have other workspaces, you'll see a list to select from

**Keyboard shortcut**: `O` then `W` to switch workspaces

### Delete Workspace
**⚠️ Warning**: Deleting a workspace includes deleting user and issue data. This action is not reversible.

Admins can delete a workspace under **Settings > Workspace > General**.

---

## 👥 Team Organization

### Overview
Your workspace is organized into different teams. Users can be part of one or many teams.

**Consider grouping teams by:**
- Teammates who work together frequently
- Areas of work (marketing, mobile app, etc.)
- Keeping everyone on one team (simplest approach for small teams)

**Recommendation**: If unsure how to split teams, start with one or two. It's easy to add more teams later, copy settings from existing teams, and move issues between teams.

### Team Structure
Teams you have joined will appear in your sidebar. Each team has the following pages:

#### Core Team Pages
- **[Triage](views-navigation.md#triage)*** - Newly created issues to be reviewed and prioritized
- **Issues** - Default views of all issues in this team  
- **[Cycles](projects-cycles.md#cycles)*** - Review current, past and upcoming cycles
- **Projects** - Default views of all projects linked to this team
- **Views** - Custom views filtered to this team's issues

*Sections marked with * are opt-in and need to be enabled in team settings.

### Team Settings

#### Accessing Team Settings
- **From sidebar**: Hover over the team name, click the three dots `···` menu, select "Team settings"
- **From Settings**: Find the team under "Your teams" and select it

#### Configurable Settings

| Setting | Description |
|---------|-------------|
| **General** | Set timezone, estimates, create issues by email |
| **Members** | Manage team members |
| **Issue labels** | Manage team-level labels and label groups |
| **Templates** | Manage team-level issue, project, and document templates |
| **Recurring issues** | View all existing and create new recurring issues |
| **Slack notifications** | Set team-level notifications to Slack |
| **Issue statuses & automations** | Customize workflows, add/edit statuses, set up git automations |

#### Team Identity
From the team's settings page, you can update:
- **Name**: Team display name
- **Icon**: Visual identifier
- **Identifier**: Issue prefix (e.g., ENG-, DESIGN-)

**Note**: Changing the issue identifier is safe - old URLs automatically redirect to the new issue URL.

### Team Limits
The number of teams you can have depends on your plan:
- **Free**: Limited teams
- **Paid plans**: Expanded team limits
- **Enterprise**: Unlimited teams

---

## 👤 Member Management

### Inviting Members

#### Sending Invitations
1. Go to **Settings > Administration > Members**
2. Click the "Invite people" button
3. Enter invitee email addresses (separate multiple emails with commas)
4. Under "Invite as...", select the role (paid plans)
5. Select the team(s) for auto-joining
6. Click "Send invites"

**Email Filtering**: If invitation emails are filtered, whitelist:
- notifications@linear.app
- pm_bounces@pm-bounces.linear.app

#### Invitation Permissions by Plan

| Plan | Who Can Invite |
|------|----------------|
| **Free plan** | All members (all are Admins) |
| **Paid plans** | Only Admins by default |
| **SAML** | Users with IdP access can join without invitation |

**Paid Plan Setting**: Admins can allow all users to invite members by toggling "Allow users to send invites" in **Settings > Workspace > Security**.

### Approved Email Domains

#### Setup
Admins can add allowed email domains in **Settings > Administration > Security**:
- Anyone with matching domain can join without invitation
- Streamlines onboarding for organizations
- Users see prompt to join workspace during onboarding

#### For Existing Users
1. Click current workspace icon
2. Hover over "Switch workspace"
3. Select "Create or join a workspace"
4. Available workspaces with allowed domains will appear

**Best Practice**: Regularly review this list to ensure it's current and secure.

### Managing Members

#### Members Page
Located at **Settings > Administration > Members** (Admin-only):
- View current and suspended members
- Filter by roles and status (Pending invites, Suspended, Left workspace)
- See last seen times
- Manage roles and access

#### Member Status
- **Active**: Current workspace members
- **Pending**: Invitations sent but not accepted
- **Suspended**: Access revoked but data preserved
- **Left**: Members who voluntarily left the workspace

---

## 🔐 Roles & Permissions

### Role Types

#### Admin
**Access Level**: Full workspace control
- Access to "Administration" section in Settings sidebar
- Manage workspace-level configurations (SAML, login methods, billing)
- All capabilities of Members plus administrative functions

**Default Admin Assignment**:
- **Free plans**: All members are Admins
- **Paid plans**: Workspace creator and/or upgrader get Admin roles

**View Workspace Admins**:
- Command menu: `Cmd/Ctrl + K` → "View workspace admins"
- Direct link: [Settings/View Admins](https://linear.app/settings/view-admins)

#### Member
**Access Level**: Full data access (except private teams they don't belong to)
- Cannot modify workspace settings
- Cannot see administration pages
- Full access to issues, projects, and documents in their teams

#### Guest (Business and Enterprise plans only)
**Access Level**: Limited to selected teams
- Can be invited to specific teams (private or public)
- Only access issues, projects, and documents in their teams
- Same actions as members on accessible data
- Cannot see workspace-wide features (workspace views, initiatives)
- Can only view Account section of settings

### Managing Roles

#### Changing Roles
1. Navigate to **Members page** (Admin-only)
2. Click three dots next to member (appears on hover)
3. Select new role

#### Role Permissions Matrix

| Capability | Admin | Member | Guest |
|------------|-------|--------|-------|
| View all workspace data | ✅ | ✅ | ❌ |
| Access private teams (not member of) | ✅ | ❌ | ❌ |
| Modify workspace settings | ✅ | ❌ | ❌ |
| See administration pages | ✅ | ❌ | ❌ |
| Manage billing | ✅ | ❌ | ❌ |
| Invite members | ✅ | ⚠️* | ❌ |
| Access team data (member of) | ✅ | ✅ | ✅ |
| Create/edit issues | ✅ | ✅ | ✅ |
| View workspace initiatives | ✅ | ✅ | ❌ |

*⚠️ Can be enabled by Admin in workspace settings

### Guest-Specific Considerations

#### Project Sharing with Guests
When projects are shared between multiple teams:
- Guests only see issues in teams they belong to
- Issues from other teams in the project remain hidden

**Example**: Guest is part of Team A. Project 1 is shared between Team A and Team B. Guest only sees Team A issues in Project 1.

#### Guest & Integration Security
Integrations enabled for the workspace are accessible to guest users, potentially giving access to external systems. Consider this when inviting guests.

---

## 🔒 Login Methods & Security

### Authentication Options

#### Standard Login Methods
- **Email/Password**: Traditional authentication
- **Single Sign-On (SSO)**: SAML integration
- **OAuth**: Google, GitHub integration
- **Passkeys**: Modern passwordless authentication

#### SAML Configuration
For SAML-enabled workspaces:
- Ensure members have access in your Identity Provider (IdP)
- Users with IdP access can login without invitation
- Just-In-Time (JIT) provisioning creates accounts automatically
- Contact support@linear.app for domain approval if email doesn't match workspace

### Security Settings

#### Workspace Security
Located at **Settings > Workspace > Security**:
- **Allow users to send invites**: Enable/disable member invitation permissions
- **Third-party app review**: Require admin approval for integrations (Enterprise)
- **Approved email domains**: Auto-join domains
- **Login method restrictions**: Control authentication options

#### Best Practices
1. **Regular Access Review**: Audit member access quarterly
2. **Role Assignment**: Follow principle of least privilege
3. **Domain Management**: Keep approved domains current
4. **Integration Security**: Review third-party app permissions
5. **SAML Integration**: Use for enterprise security

---

## ⚙️ Workspace Settings

### General Configuration

#### Workspace Identity
- **Name**: Organization display name
- **URL**: Workspace identifier (workspace-name.linear.app)
- **Icon**: Visual branding

#### Feature Toggles
- **Initiatives**: Enable/disable workspace-level initiatives
- **Project Updates**: Configure project status updates
- **Third-party app review**: Require admin approval (Enterprise)

### Administration Settings

#### Data Management
- **Import Issues**: Bulk import from other tools
- **Export Issues**: Backup or migration
- **Member Management**: User access and roles
- **Billing**: Plan and payment management

#### Integration Configuration
Workspace-level integrations:
- **GitHub/GitLab**: Repository connections
- **Slack**: Team communication
- **Figma**: Design collaboration  
- **Sentry**: Error monitoring
- **Custom**: API and webhook integrations

### Templates and Labels

#### Workspace-Level Templates
Create reusable templates for:
- **Issues**: Bug reports, feature requests
- **Projects**: Standard project structures
- **Documents**: Meeting notes, specs

#### Workspace Labels
Create labels available across all teams:
- **Priority**: P0, P1, P2, P3
- **Type**: Bug, Feature, Task
- **Status**: Blocked, Needs Review
- **Custom**: Organization-specific categories

## 💡 Best Practices

### Workspace Organization
1. **Start Simple**: Begin with one workspace and expand as needed
2. **Team Structure**: Organize by function, not hierarchy
3. **Member Roles**: Use least privilege principle
4. **Regular Reviews**: Audit access and settings quarterly

### Team Management
1. **Clear Naming**: Use descriptive team names and identifiers
2. **Consistent Settings**: Copy settings from well-configured teams
3. **Member Assignment**: Consider skills and workload when assigning
4. **Cross-team Projects**: Use projects for collaboration across teams

### Security Management
1. **Access Control**: Regularly review member access
2. **Integration Security**: Monitor third-party app permissions
3. **Domain Management**: Keep approved domains updated
4. **Authentication**: Prefer SSO/SAML for enterprise environments

## 🔗 Related Guides

- **[User Account](user-account.md)** - Personal settings and preferences
- **[Getting Started](getting-started.md)** - Initial setup and onboarding
- **[Issues Management](issues-management.md)** - Work item organization
- **[Projects & Cycles](projects-cycles.md)** - Planning and execution
- **[Admin Settings](admin-settings.md)** - Advanced workspace administration

---

*Effective workspace and team management creates the foundation for productive collaboration in Linear.*