---
title: "Integrations"
description: "Integration guide for third-party platforms"
category: "integration"
type: "guide"
tags: ["doppler", "integration", "ci-cd"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Integrations

Complete guide to connecting Linear with external tools and services to streamline your development workflow.

## 📋 Table of Contents

- [Integration Overview](#integration-overview)
- [GitHub Integration](#github-integration)
- [GitLab Integration](#gitlab-integration)
- [Slack Integration](#slack-integration)
- [Figma Integration](#figma-integration)
- [Sentry Integration](#sentry-integration)
- [Zapier Automation](#zapier-automation)
- [Zendesk Integration](#zendesk-integration)
- [Custom Integrations & API](#custom-integrations-api)

---

## 🔗 Integration Overview

### What are Integrations?
Integrations connect Linear with external tools and services, creating seamless workflows between platforms. They enable automatic data sync, reduce context switching, and improve team productivity.

### Integration Benefits
- **Reduced context switching**: Work stays in flow
- **Automatic updates**: Sync status between tools
- **Centralized communication**: All updates in one place
- **Improved visibility**: See cross-platform activity
- **Workflow automation**: Trigger actions across tools

### Integration Types

#### Development Tools
- **Version Control**: GitHub, GitLab, Bitbucket
- **CI/CD**: GitHub Actions, GitLab CI, Jenkins
- **Code Quality**: SonarCloud, CodeClimate
- **Package Management**: npm, PyPI integrations

#### Communication Platforms
- **Team Chat**: Slack, Microsoft Teams, Discord
- **Video Conferencing**: Zoom, Google Meet
- **Email**: Gmail, Outlook notifications

#### Design & Collaboration
- **Design Tools**: Figma, Sketch, InVision
- **Documentation**: Notion, Confluence, GitBook
- **File Storage**: Google Drive, Dropbox

#### Monitoring & Support
- **Error Tracking**: Sentry, Bugsnag, Rollbar
- **Customer Support**: Zendesk, Intercom, Front
- **Analytics**: Mixpanel, Amplitude

#### Automation
- **Workflow Automation**: Zapier, Make (Integromat)
- **Project Management**: Jira, Asana (via imports)
- **Custom APIs**: Build your own integrations

---

## 🐙 GitHub Integration

### Overview
Linear's GitHub integration provides comprehensive connection between your code and project management, automating workflow updates and maintaining issue-to-code traceability.

### Core Features
- **Automatic issue linking**: Connect pull requests to Linear issues
- **Status automation**: Update issue status based on PR events
- **Branch naming**: Generate standardized branch names
- **Commit linking**: Reference issues in commit messages
- **PR synchronization**: Keep code reviews aligned with issue progress

### Setup Process

#### Installation Requirements
- **GitHub organization owner** OR **repository administrator** permissions
- Linear admin permissions for organization-level access
- Repository access (all repositories or selected repositories)

#### Configuration Steps
1. Go to **Settings > Features > Integrations > GitHub**
2. Click **Enable** 
3. Select GitHub organization to connect
4. Choose repository access:
   - **All repositories**: Complete organization access
   - **Only select repositories**: Specific repo access
5. Click **Install**
6. Authenticate with GitHub account

### GitHub Features

#### Pull Request Linking
**Automatic Linking**:
- Reference Linear issues in PR titles or descriptions
- Use issue identifiers (e.g., ENG-123)
- Linear automatically detects and links

**Manual Linking**:
- Add Linear issue URLs to PR descriptions
- Use GitHub's "Connect" feature
- Link from Linear issue sidebar

#### Status Automation
| GitHub Event | Linear Action |
|--------------|---------------|
| **PR opened** | Move issue to "In Review" |
| **PR merged** | Move issue to "Done" |
| **PR closed (unmerged)** | Return to previous status |
| **PR ready for review** | Update status and notify assignee |

#### Branch Naming
**Auto-generated Format**:
```
team-prefix/issue-number/description
eng-123/add-user-authentication
design-456/update-login-flow
```

**Copy Branch Name** (`Cmd/Ctrl + Shift + .`):
- Automatically move issue to "In Progress"
- Auto-assign to current user (if enabled)
- Generate standardized branch name

#### Commit Linking
**Commit Message Formats**:
```bash
git commit -m "Fix authentication bug (ENG-123)"
git commit -m "Add user login feature

Addresses ENG-123: Implement OAuth2 authentication"
```

**Automatic Recognition**:
- Linear issue IDs in commit messages
- Full issue URLs
- Multiple issue references per commit

### Advanced GitHub Features

#### GitHub Enterprise
- **GitHub Enterprise Cloud**: Full integration support
- **GitHub Enterprise Server**: Limited feature set (PR automation only)
- **IP Allow Lists**: Configure for enterprise security

#### Multiple Repositories
- **Organization-wide**: Single integration for all repos
- **Selective access**: Choose specific repositories
- **Repository settings**: Per-repo configuration options

#### Permissions and Security
- **Required permissions**: Read access to checks and metadata
- **Write access**: Issues and pull requests
- **Webhook setup**: Automatic for commit linking
- **Security considerations**: Review connected repositories regularly

---

## 🦊 GitLab Integration

### Overview
Similar to GitHub integration, GitLab provides merge request linking, pipeline status sync, and automatic issue status updates.

### Core Features
- **Merge Request (MR) linking**: Connect GitLab MRs to Linear issues
- **Pipeline status**: CI/CD pipeline results in Linear
- **Auto-close on merge**: Complete issues when MRs merge
- **Branch management**: Standardized naming and creation

### Setup Process
1. Navigate to **Settings > Integrations > GitLab**
2. Connect GitLab account with OAuth
3. Select GitLab groups or projects
4. Configure automation rules
5. Test connection with sample MR

### GitLab-Specific Features

#### Merge Request Workflow
- **Draft MR**: Issue remains in current status
- **Ready for review**: Move to "In Review" 
- **Approved**: Ready for merge
- **Merged**: Complete issue automatically

#### Pipeline Integration
- **Build status**: Show CI/CD results in Linear
- **Deployment tracking**: Link deployments to issues
- **Test results**: Display test outcomes
- **Quality gates**: Block merging if tests fail

#### Multi-Project Support
- **Group-level**: Connect entire GitLab groups
- **Project selection**: Choose specific projects
- **Cross-project**: Link issues across projects

---

## 💬 Slack Integration

### Overview
Slack integration creates seamless communication flow between Linear and team chat, enabling issue creation, status updates, and notifications without leaving Slack.

### Core Features
- **Issue creation**: Create Linear issues from Slack messages
- **Rich unfurls**: Preview Linear content in Slack
- **Notifications**: Receive Linear updates in Slack channels
- **Slash commands**: Quick Linear actions from Slack
- **Thread synchronization**: Keep conversations connected

### Setup Process

#### Initial Setup (Admin Required)
1. Go to **Settings > Features > Integrations > Slack**
2. Click **Connect to Slack**
3. Authorize Linear in your Slack workspace
4. Configure workspace-level settings

#### Personal Setup (Any User)
1. Go to **Settings > Account > Notifications**
2. Enable Slack notifications
3. Authenticate personal Slack account
4. Choose notification preferences

### Slack Features

#### Creating Issues from Slack

**From Message Menu**:
1. Click **More actions** (⋯) on any Slack message
2. Select **Create Linear issue**
3. Fill out issue details
4. Issue automatically includes Slack message context

**Using Slash Commands**:
```
/linear create Fix login bug
/linear create "User authentication" team:engineering priority:high
/linear search authentication
/linear assign ENG-123 @username
```

#### Rich Content Unfurls
When Linear URLs are shared in Slack:
- **Issue previews**: Title, status, assignee, priority
- **Project updates**: Progress summaries
- **Document links**: Doc titles and descriptions
- **Comment threads**: Conversation previews

#### Notification Types

**Team Notifications**:
- Configure from Team Settings or Integration page
- Choose specific Slack channel
- Filter by issue types, status changes
- Customize notification format

**Project Notifications**:
- Set up from individual project pages
- Click bell icon in project header
- Select Slack channel for updates
- Choose update frequency

**Personal Notifications**:
- Configure in personal notification settings
- Receive DMs for assigned issues
- Get notifications for subscribed issues
- Customize timing and frequency

#### View Subscriptions
Set up channel notifications for custom views:
1. Open any Linear view
2. Click bell icon at top
3. Configure Slack notifications
4. Choose trigger events (added, completed, etc.)

### Slack Best Practices
1. **Channel organization**: Dedicated channels for different teams/projects
2. **Notification filtering**: Avoid notification fatigue
3. **Thread usage**: Keep related discussions together
4. **Status updates**: Regular project/sprint updates to channels
5. **Integration training**: Ensure team knows available commands

---

## 🎨 Figma Integration

### Overview
Figma integration bridges design and development workflows, allowing design embeds in Linear and issue creation from Figma designs.

### Dual Integration Approach
1. **Figma embeds in Linear**: Preview designs in issues and documents
2. **Linear plugin for Figma**: Create and link issues directly from Figma

### Setup Process

#### Embed Integration
1. Go to **Settings > Features > Integrations > Figma**
2. **Use browser** (not desktop client) for setup
3. Authenticate with Figma account
4. Integration works across entire workspace

#### Figma Plugin
1. In Figma, go to **Resources > Plugins**
2. Search for "Linear" or install from [Figma Community](https://www.figma.com/community/plugin/1221187540287746170)
3. Run plugin on selected frames or sections

### Figma Embed Features

#### Design Previews
**Automatic Conversion**:
- Copy Figma link to frame or file
- Paste in Linear issue description or comment
- Link automatically converts to visual preview
- Snapshot preserved even if design changes

**Supported Content**:
- Individual frames
- Complete files
- Figma prototypes
- Component libraries

#### Interactive Previews
- **In-app preview**: View designs without leaving Linear
- **Public files only**: Private file support under consideration
- **Fast loading**: Custom integration using Figma's API
- **Full interactivity**: Click through prototypes

#### Preview Management
**Refresh Controls**:
1. Enter edit mode on issue or comment
2. Hover over Figma embed
3. Click **Refresh** button to update
4. **Note**: Refresh cannot be undone

**Context Preservation**:
- Default: Previews don't auto-refresh
- Maintains comment/issue context
- Manual refresh when needed
- Historical design snapshots

### Linear Plugin for Figma

#### Plugin Features
- **View linked issues**: See all Linear issues connected to designs
- **Create new issues**: Generate Linear issues from selected elements
- **Navigate to Linear**: Jump directly to linked issues
- **Element linking**: Connect specific frames to issues

#### Workflow Integration
1. **Design phase**: Create issues for design tasks
2. **Development handoff**: Link designs to implementation issues
3. **Review process**: Reference designs in Linear discussions
4. **Documentation**: Embed designs in project documentation

### Design-Development Workflow

#### Typical Process
1. **Designer creates mockup** in Figma
2. **Designer links frames** to Linear issues using plugin
3. **Designer embeds design** in Linear issue description
4. **Developer receives notification** with visual context
5. **Team discusses implementation** with design reference
6. **Designer updates design**, optionally refreshes embed

#### Best Practices
1. **Link early**: Connect designs to issues during creation
2. **Embed strategically**: Include designs in relevant issues
3. **Update regularly**: Refresh embeds for current designs
4. **Document decisions**: Use comments to explain design choices
5. **Version control**: Create new issues for major design changes

---

## 🔍 Sentry Integration

### Overview
Sentry integration connects error monitoring with issue tracking, automatically creating Linear issues from production errors and keeping error resolution in sync.

### Core Features
- **Automatic issue creation**: Generate Linear issues from Sentry errors
- **Manual issue linking**: Connect existing issues to Sentry errors
- **Status synchronization**: Resolve Sentry issues when Linear issues complete
- **Assignee sync**: Keep assignees synchronized between platforms

### Setup Process
1. Go to **Settings > Workspace > Integrations > Sentry**
2. Enable Sentry integration
3. Authenticate with Sentry account
4. Configure organization and project access
5. Set up automatic creation rules

### Sentry Features

#### Creating Issues from Sentry

**Manual Creation**:
1. In Sentry, view an error issue
2. Go to right sidebar
3. Click **Create Linear issue**
4. Fill out quick form (pre-filled with error details)
5. Set title, team, assignee, priority

**Automatic Creation**:
- Configure in Sentry: **Alerts > Create Alert**
- Set rules for automatic Linear issue creation
- Based on issue/event alerts
- Based on metric thresholds
- Customizable trigger conditions

#### Linking Existing Issues
1. In Sentry, view an error issue
2. Go to right sidebar  
3. Click **Link Linear issue**
4. Search by issue ID or title
5. Select existing Linear issue

#### Automation Features

**Status Synchronization**:
- **Linear issue completed** → Sentry issue resolved
- **Linear issue reopened** → Sentry issue reopened
- **Automatic status updates** → Bidirectional sync

**Assignee Synchronization**:
- **Linear assignee change** → Update Sentry assignee
- **Requires same email** in both Linear and Sentry
- **Automatic notification** to new assignee

#### Sentry Display Options
**Linear Issue Views**:
- **Sentry icon**: Display in list/board views
- **Quick access**: Click icon to open Sentry directly
- **Status indicator**: See error resolution state
- **Configure in**: Display properties for views

### Sentry Workflow

#### Error-to-Resolution Process
1. **Error occurs** in production
2. **Sentry captures** error details
3. **Linear issue created** (auto or manual)
4. **Team triages** and assigns issue
5. **Developer fixes** bug
6. **Linear issue completed**
7. **Sentry issue resolved** automatically

#### Alert Configuration
**Sentry Alert Rules**:
- **Error frequency**: Create issue after X occurrences
- **New errors**: Auto-create for first-time errors
- **Regression**: Create when resolved errors reoccur
- **Performance**: CPU, memory, or response time thresholds

#### Managing Sentry Links
**Remove Connections**:
1. In Linear issue, find Sentry link
2. Right-click on link
3. Select **Remove**
4. Confirm disconnection

### Sentry Limitations
- **Cloud only**: Self-hosted Sentry not supported
- **Single organization**: One Sentry org per Linear workspace
- **Public teams only**: Private Linear teams not supported
- **Email matching**: Assignee sync requires matching emails

---

## ⚡ Zapier Automation

### Overview
Zapier integration enables powerful workflow automation between Linear and hundreds of other apps, creating custom triggers and actions without coding.

### Common Automations

#### Issue Management
- **New issue** → Create Slack message, send email
- **Issue completed** → Update Google Sheets, notify customer
- **High priority assigned** → Send SMS alert
- **Bug reported** → Create calendar event for triage

#### Communication Workflows
- **Project milestone** → Post to multiple Slack channels
- **Sprint complete** → Generate report in Google Docs
- **Blocker identified** → Email project manager
- **Release deployed** → Update customer in CRM

#### Data Synchronization
- **Customer request** → Create Linear issue from Zendesk
- **New feature request** → Add to product roadmap in Notion
- **Bug fixed** → Update status in external tracking tool
- **Sprint metrics** → Update dashboard in Airtable

### Setup Process
1. **Create Zapier account** or log in
2. **Search for Linear** in Zapier app directory
3. **Create new Zap** with Linear trigger or action
4. **Authenticate Linear** account with API key
5. **Configure trigger/action** parameters
6. **Test workflow** and activate

### Zapier Triggers (Linear → Other Apps)
- **New issue created**
- **Issue updated**
- **Issue completed**
- **Comment added**
- **Project updated**
- **Cycle completed**

### Zapier Actions (Other Apps → Linear)
- **Create issue**
- **Update issue**
- **Add comment**
- **Create project**
- **Update project status**

---

## 🎫 Zendesk Integration

### Overview
Zendesk integration connects customer support tickets with Linear issues, enabling seamless customer request tracking and resolution.

### Core Features
- **Ticket-to-issue creation**: Convert support tickets to Linear issues
- **Bidirectional sync**: Keep tickets and issues synchronized
- **Customer communication**: Update customers when issues resolve
- **Priority mapping**: Align support urgency with Linear priority

### Setup Process
1. **Enable integration** in Linear workspace settings
2. **Connect Zendesk** account with admin permissions
3. **Configure field mapping** between platforms
4. **Set up automation rules** for ticket conversion
5. **Train support team** on Linear integration

### Zendesk Features

#### Ticket Conversion
**Automatic Conversion**:
- Configure rules in Zendesk triggers
- Convert based on ticket type, priority, or tags
- Map Zendesk fields to Linear properties
- Maintain ticket-issue relationship

**Manual Conversion**:
- Zendesk agents create Linear issues
- Include customer context and requirements
- Link ticket to Linear issue
- Track progress in both systems

#### Status Synchronization
| Linear Status | Zendesk Status |
|---------------|----------------|
| **Todo** | Open |
| **In Progress** | Pending |
| **In Review** | Pending |
| **Done** | Solved |
| **Canceled** | Closed |

#### Customer Communication
- **Auto-update tickets** when Linear issues progress
- **Custom messages** for different status changes
- **Customer notifications** when features ship
- **Internal notes** for development updates

---

## 🔌 Custom Integrations & API

### Linear API Overview
Linear provides a comprehensive GraphQL API for building custom integrations and automations.

### API Capabilities
- **Full CRUD operations**: Create, read, update, delete all resources
- **Real-time subscriptions**: WebSocket-based live updates  
- **Webhook support**: Receive notifications on events
- **Bulk operations**: Efficient batch processing
- **Custom fields**: Extend Linear with your data

### Authentication
```bash
curl -X POST https://api.linear.app/graphql \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json"
```

### Common API Use Cases

#### Data Integration
- **Import existing issues** from other tools
- **Sync with external databases** 
- **Export for reporting** and analytics
- **Backup and archival** workflows

#### Workflow Automation
- **Custom status transitions** based on external events
- **Automatic assignment** using custom logic
- **Integration with deployment** systems
- **Time tracking** and reporting

#### Custom Applications
- **Public roadmap** websites
- **Customer portals** for feature requests
- **Team dashboards** and metrics
- **Mobile applications** with Linear data

### Webhook Configuration
1. **Go to API settings** in Linear workspace
2. **Create webhook endpoint** with target URL
3. **Select event types** to receive
4. **Configure authentication** (optional)
5. **Test webhook** delivery

### API Rate Limits
- **2000 requests per hour** per API key
- **Complexity-based limiting** for expensive queries
- **Burst allowance** for temporary spikes
- **GraphQL introspection** for query optimization

## 💡 Integration Best Practices

### Planning Integrations
1. **Define clear objectives**: What problem does the integration solve?
2. **Map workflows**: How will data flow between systems?
3. **Consider maintenance**: Who will manage the integration?
4. **Plan for failures**: How will errors be handled?
5. **Security review**: What data is being shared?

### Implementation Guidelines
1. **Start simple**: Begin with basic use cases
2. **Test thoroughly**: Verify all scenarios work correctly
3. **Monitor performance**: Watch for rate limits and errors
4. **Document setup**: Help team members understand configuration
5. **Plan updates**: Keep integrations current with tool changes

### Team Adoption
1. **Training sessions**: Teach team how to use integrations
2. **Clear documentation**: Provide usage guidelines
3. **Gradual rollout**: Introduce integrations incrementally
4. **Feedback collection**: Improve based on user experience
5. **Regular review**: Assess integration value and usage

### Security Considerations
1. **Principle of least privilege**: Minimal required permissions
2. **Regular audits**: Review connected applications
3. **Key rotation**: Update API keys periodically
4. **Data sensitivity**: Understand what data is shared
5. **Compliance requirements**: Meet organizational security standards

## 🔗 Related Guides

- **[API & CLI](api-cli.md)** - Linear API setup and command-line tools
- **[Workspace Management](workspace-management.md)** - Admin settings and permissions
- **[Issues Management](issues-management.md)** - Work item organization and tracking
- **[Projects & Cycles](projects-cycles.md)** - Planning and project management
- **[Getting Started](getting-started.md)** - Basic Linear setup and concepts

---

*Integrations transform Linear from a standalone tool into the hub of your development workflow. Choose integrations that solve real problems and reduce friction in your team's daily work.*