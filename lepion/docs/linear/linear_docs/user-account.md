---
title: "User Account & Profile Management"
description: "- [Profile Settings](#profile-settings)"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# User Account & Profile Management

Complete guide to managing your Linear account, profile, preferences, and personal workspace.

## 📋 Table of Contents

- [Profile Settings](#profile-settings)
- [Account Preferences](#account-preferences)
- [Notifications](#notifications)
- [Inbox Management](#inbox-management)
- [My Issues](#my-issues)
- [Security & Access](#security-access)
- [Pulse & Activity](#pulse-activity)

---

## 👤 Profile Settings

Your profile in Linear (found at **Settings > Account > Profile**) is where you personalize how other team members see you.

### Profile Picture
- **Default**: First and last initials of your account
- **To update**: 
  1. Hover over the avatar until the edit pencil icon appears
  2. Click the pencil icon
  3. Select a new photo from the pop-up folder
- **Note**: Once updated, you cannot remove your avatar—only replace it

### Name and Username
- Team members can choose to see either full names or usernames
- Configure display preference in **Settings > Account > Preferences**
- Adjust these settings based on how you want others to refer to you

### Email Address Management

Your email address serves as your unique ID across all workspaces.

#### How Email Addresses Work
| Action | Result |
|--------|--------|
| Join Workspace A using jane.doe@email.com | User Account created + User created for Workspace A |
| Join Workspace B | User created for Workspace B under existing account |
| Update email in Workspace B | Email updated for ALL workspaces |

#### Changing Your Email Address
1. Navigate to **Settings > Account > Profile**
2. Hover over your email address and click the pencil icon
3. Enter your new email address
4. Confirm via emails sent to **both** old and new addresses

**Important Notes:**
- Changing email affects ALL workspaces using that email
- To change email for only one workspace: invite the new email as a new user, then leave from the old account
- For organization-wide domain changes, contact support@linear.app

### Personal Integrations

Personal integrations are software integrations where each user has their own specific account. This helps Linear associate your user when actions are taken in third-party integrations.

**Connected Services**:
- **GitHub**: Link commits and PRs to Linear issues
- **Slack**: Personal notification preferences  
- **Figma**: Design file connections
- **Other OAuth apps**: Connected third-party applications

**Managing Integrations**:
1. Go to **Settings > Account > Profile**
2. View **Personal integrations** section
3. **Connect** or **disconnect** services as needed
4. **Review permissions** for each connected service

**Benefits**:
- **Action attribution**: Linear knows who performed actions
- **Personal settings**: Individual preferences for each service
- **Security control**: Manage your own access permissions
- **Integration history**: Track your connected services

### Leave Workspace
1. Go to **Settings > Profile**
2. Click "Leave workspace"
3. Access is immediately revoked
4. An admin must unsuspend your account to regain access

---

## ⚙️ Account Preferences

Customize your Linear experience to match your workflow and personal preferences.

### General Preferences

#### Default Home View
Sets the view that opens when you log into Linear:
- **Default**: Team's Active issues view
- **Options**: All issues, Active issues, Current cycle, Inbox, My Issues, Favorited Views, Favorited Projects

#### Display Settings
- **Display Full Names**: Choose between full names or usernames
- **First Day of Week**: Customize calendar displays
- **Convert Text Emoticons**: Automatically convert :) to 😊

### Interface and Theme

#### Display Options
- Adjust font size for better readability
- Use pointer cursor when hovering over interactive elements

#### Theme Customization
- **Presets**: Built-in Light or Dark modes
- **System preference**: Auto-switch based on computer settings
- **Custom themes**: Build your own or use community themes from [linear.style](https://linear.style/)

### Desktop Application Settings

#### Link Behavior
Control whether Linear links open in:
- Web browser
- Desktop application (when installed)

#### Desktop Features
- **Notification badges**: Show/hide badge counts on app icon
- **Spell check**: Enable spell checking for text input

### Automations and Workflows

#### Auto-assign to Self
Automatically assigns any issue you create to yourself.

**Use cases**:
- Creating personal task lists
- Bulk issue creation for projects
- Temporary enablement during sprints

**Alternative**: Use `Cmd/Ctrl + Shift + Enter` when creating issues for bulk creation.

#### Git Integration Settings

**Git Attachment Format**:
- Title only
- Title and repository

**Git Branch Copy Actions** (when copying branch names with `Cmd/Ctrl + Shift + .`):
1. **Move issue to In Progress**: Automatically transitions to first "Started" status
2. **Auto-assign to yourself**: Claims ownership when starting work

**Recommendation**: Enable both settings for developers to streamline workflow.

---

## 🔔 Notifications

Configure how and when you receive alerts about important updates.

### Overview
Linear notifications keep you informed about important updates across your workspace. All notifications automatically go to your Linear inbox, with options for additional channels:

- Desktop push notifications
- Mobile notifications  
- Personal Slack notifications
- Email digests

### Notification Configuration

Navigate to **Settings > Account > Notifications** to manage preferences.

#### Notification Methods

Each method is indicated by a colored dot:
- **Green dot**: Method is enabled
- **Gray dot**: Method is disabled

Available methods:
- **Desktop**: Real-time push notifications to your computer
- **Mobile**: Real-time notifications to your mobile device
- **Email**: Digest summaries of unread notifications
- **Slack**: Real-time notifications to your personal Slack

#### Enabling Notifications
1. Click on a notification method
2. Toggle the switch to enable/disable
3. Select specific notification types you want to receive

**Note**: Notifications are grouped by category. Enabling "status changes" includes notifications for status, priority, and blocking relationship changes.

### Notification Timing

#### Real-time Notifications
Desktop, mobile, and Slack notifications are sent immediately.

#### Email Digests
- Sent with time delays based on urgency
- Only sent if you haven't read the notification in your Linear inbox
- **Immediate delivery**: For urgent issues or SLA breaches assigned to you
- **Work hours delivery**: Delay low-priority emails outside 8 AM - 6 PM (your timezone)

### Issue Subscriptions

#### Automatic Subscriptions
You're automatically subscribed to issues when you:
- Create them
- Are assigned to them
- Are @mentioned in comments or descriptions
- Manually subscribe via the Activity section

#### Managing Subscriptions
- **Subscribe**: Press `Shift + S` on an issue
- **Unsubscribe**: Press `Cmd/Ctrl + Shift + S`  
- **View all subscriptions**: Go to **My Issues > Subscribed**

### Troubleshooting

#### Multiple Tabs/Apps
If using Linear in multiple tabs or both desktop and web apps simultaneously, notifications may only appear in one location. Use only one instance at a time.

#### Browser-Specific Issues

**Safari**: Doesn't support Push API for desktop notifications. Consider using a different browser.

**Chrome**: If notifications aren't working:
1. Go to `chrome://settings/content/notifications`
2. Check Linear's notification permissions
3. Re-enable in Linear settings

#### macOS Settings
Ensure notifications are enabled in macOS System Preferences:
1. Allow notifications for Linear
2. Enable badge app icon if desired

---

## 📥 Inbox Management

Your notification center and hub for important updates.

### Overview
The Inbox receives notifications for key events on subscribed issues. You're automatically subscribed to issues when you create, are assigned to, or are mentioned in them.

### Accessing Your Inbox

#### Navigation
- Click "Inbox" in the sidebar
- Keyboard shortcut: `G` then `I`

#### Navigation Shortcuts
- Scroll through notifications: `J`/`K` or `↑`/`↓`
- View individual issues in special Inbox view
- Take actions without leaving the Inbox

### Inbox Actions

#### Notification Management
| Action | Shortcut | Description |
|--------|----------|-------------|
| Delete notification | `Backspace` | Remove single notification |
| Delete all | `Shift + Backspace` | Clear entire inbox |
| Delete all read | `Cmd/Ctrl + D` | Remove only read notifications |
| Mark as read/unread | `U` | Toggle single notification |
| Mark all as read/unread | `Option/Alt + U` | Toggle all notifications |
| Snooze | `H` | Temporarily hide notification |
| Unsubscribe | `Shift + S` | Stop receiving updates (from issue view) |

#### Contextual Actions
Right-click any notification to access:
- Inbox-specific actions
- Issue property updates
- Quick actions menu

### Search and Filter

#### Quick Search
1. Press `Cmd/Ctrl + F`
2. Filter by: Issue title, Issue ID, Notification type, Assignee
3. Press `Esc` to clear search

#### Display Options
Toggle visibility of:
- **Show snoozed**: Display temporarily hidden notifications
- **Show read issues**: Include already-viewed notifications

### Snooze Functionality

#### How Snoozing Works
- Temporarily hides notifications from Inbox and Triage
- Reappears as unread at specified time
- Automatically canceled if new activity occurs

#### Setting Snooze Times
- Press `H` on any notification
- Right-click and select "Snooze"
- Choose from preset or custom times

### Issue Reminders

#### Setting Reminders
Create reminders for:
- Issues
- Documents
- Projects
- Initiatives

#### Managing Reminders
- View scheduled reminders at top of issues
- Reschedule by clicking existing reminder
- Cancel anytime
- Receive notification at selected time

#### Reminder Options

**Preset Times**: Later today, Tomorrow, Next week, Next month, Next quarter

**Custom Times** (type natural language):
- `Jan 3 10am`
- `next quarter`
- `until March 15`
- `for 2 weeks`

**Important**: Type options in full (e.g., "next quarter" not "next quar")

---

## 📊 My Issues

Your centralized view of the most important issues across four organized tabs.

### Overview
My Issues organizes your most pertinent issues:
- **Assigned**: Issues assigned to you
- **Created**: Issues you've created
- **Subscribed**: Issues you're following
- **Activity**: Recent issue activity

### Quick Access
- **Keyboard shortcut**: `G` then `M`
- **Sidebar**: Located under Inbox

### Assigned Issues Tab

#### Focus Grouping (Default)
My Issues uses unique "Focus" grouping that prioritizes issues by importance:

1. **Urgent Issues**: Critical priority items
2. **SLA Issues**: Items with service level agreements
3. **Blocking Issues**: Your issues blocking others
4. **Current Cycle**: Issues in active sprint (optional)
5. **Future Cycles**: Upcoming sprint issues (optional)
6. **Other Active**: In-progress issues not in above categories
7. **Triage**: Items needing review (optional)
8. **Backlog**: Unstarted issues
9. **Done**: Completed work
10. **Cancelled**: Closed without completion

**Within each group**: Issues are ordered by priority, with started issues appearing first.

#### Customization
Change grouping options using display options in the top-right corner.

### Created Issues Tab
View all issues you've created, including those from:
- Direct creation in Linear
- Slack integrations
- Support tools (Front, Intercom, Zendesk)
- Error tracking (Sentry)
- Other integrations

**Default order**: Creation date (newest first)

### Subscribed Issues Tab

#### Automatic Subscriptions
You're automatically subscribed when:
- Assigned to an issue
- @mentioned in comments or descriptions
- You create an issue

#### Managing Subscriptions

**Individual Issues**:
1. Open the issue
2. Press `Shift + S` to toggle subscription

**Bulk Operations**:
1. Select multiple issues
2. Press `Shift + S` to subscribe/unsubscribe all  

### Activity Tab
Shows recent actions on your issues, organized by date:

#### Tracked Activities
- Issue created/updated
- State changes on assigned issues
- New comments and reactions
- Pull request opened

#### Use Cases
- Review overnight changes
- Track team collaboration
- Monitor project progress
- Catch up after time off

### Subscription Management
- **Subscribe**: `Shift + S`
- **Unsubscribe**: `Cmd/Ctrl + Shift + S`
- **Via menu**: Click three dots in Activity section

---

## 🔐 Security & Access

Control your account security, sessions, and integrations.

### Access Management
- **Active Sessions**: View and manage logged-in devices
- **API Keys**: Generate and manage personal access tokens
- **OAuth Applications**: Review connected third-party apps

### Security Features
- **Passkeys**: Modern passwordless authentication
- **Two-Factor Authentication**: Additional security layer
- **Login Methods**: Control how you access Linear

### Best Practices
- Enable passkeys for faster, secure authentication
- Regularly review active sessions
- Use unique API keys for different integrations
- Review OAuth permissions periodically

---

## 📈 Pulse & Activity

Track your productivity and team activity metrics.

### Personal Metrics
- Issues completed over time
- Cycle velocity
- Response times
- Activity patterns

### Team Insights
- Collaborate on shared metrics
- Track team performance
- Identify bottlenecks
- Celebrate achievements

---

## 💡 Best Practices

### Daily Workflow
1. **Start with My Issues**: Review assigned items in Focus order
2. **Check Inbox**: Process notifications and updates
3. **Manage subscriptions**: Stay focused on relevant issues
4. **Update preferences**: Adapt settings as workflow evolves

### Productivity Tips
- Use Focus grouping to automatically prioritize work
- Enable git automations to save time when developing
- Set up passkeys for faster authentication
- Configure email digest timing to match work schedule
- Use inbox snooze to defer non-urgent notifications

### Organization
- Regularly clean up issue subscriptions
- Customize home view based on your role
- Use custom themes to reduce eye strain
- Enable notification badges for desktop awareness

## 🔗 Related Guides

- **[Getting Started](getting-started.md)** - Initial setup and onboarding
- **[Workspace Management](workspace-management.md)** - Teams, members, and permissions
- **[Issues Management](issues-management.md)** - Creating and managing work items
- **[Views & Navigation](views-navigation.md)** - Custom views and filtering
- **[Integrations](integrations.md)** - Connect external tools

---

*Your Linear account is the foundation of your productivity. Take time to configure these settings to match your workflow and maximize efficiency.*