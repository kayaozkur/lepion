---
title: "Views & Navigation"
description: "- [Understanding Views](#understanding-views)"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Views & Navigation

Complete guide to organizing, filtering, and navigating your work in Linear through custom views, boards, and powerful filtering systems.

## 📋 Table of Contents

- [Understanding Views](#understanding-views)
- [Board Layouts](#board-layouts)
- [Timeline & Planning Views](#timeline-planning-views)
- [Custom Views](#custom-views)
- [Filtering System](#filtering-system)
- [Triage Management](#triage-management)
- [Search & Discovery](#search-discovery)
- [Display Options](#display-options)
- [Navigation Shortcuts](#navigation-shortcuts)

---

## 👁️ Understanding Views

### What are Views?
Views in Linear are different ways to organize and display your issues, projects, and work items. They help you focus on what matters most and provide different perspectives on the same data.

### Types of Views

#### Default Views
Every team comes with standard views:
- **All Issues**: Complete team issue list
- **Active Issues**: Unstarted and started work
- **Board**: Column-based visual layout
- **Backlog**: Unprioritized work items
- **My Issues**: Personal work assignments

#### Specialized Views
- **Triage**: New issues needing review
- **Archive**: Completed and canceled work
- **Timeline**: Gantt-style project planning
- **Cycles**: Sprint-based planning
- **Projects**: Feature and initiative tracking

#### Custom Views
User-created views with:
- **Specific filters**: Show exactly what you need
- **Saved configurations**: Reusable setups
- **Team sharing**: Collaborative perspectives
- **Personal organization**: Individual workflows

### View Hierarchy
- **Workspace Views**: Available to all teams
- **Team Views**: Scoped to specific teams
- **Personal Views**: Private to individual users
- **Project Views**: Specific to projects
- **Cycle Views**: Sprint-focused displays

---

## 📋 Board Layouts

### Understanding Boards
Boards provide a visual, column-based view of issues organized by a specific property, similar to Kanban boards. They're perfect for tracking workflow progression.

### Board Types

#### Status Board (Default)
- **Columns**: Workflow states (Backlog, Todo, In Progress, Done)
- **Purpose**: Track issue progression through development
- **Use case**: Daily standups, workflow management

#### Assignee Board
- **Columns**: Team members
- **Purpose**: Balance workload distribution
- **Use case**: Resource planning, identifying bottlenecks

#### Priority Board
- **Columns**: Priority levels (Urgent, High, Medium, Low)
- **Purpose**: Focus on most important work
- **Use case**: Sprint planning, escalation management

#### Label Board
- **Columns**: Different labels (Feature, Bug, Improvement)
- **Purpose**: Organize by work type
- **Use case**: Release planning, team specialization

#### Project Board
- **Columns**: Different projects
- **Purpose**: Multi-project overview
- **Use case**: Portfolio management, resource allocation

### Board Navigation & Actions

#### Navigation Techniques
- **Horizontal scrolling**: See more columns
- **Column collapse/expand**: Manage visual complexity
- **Column reordering**: Drag columns to reorganize
- **Filtering within boards**: Focus on specific criteria

#### Board Actions
| Action | Method | Purpose |
|--------|--------|---------|
| **Move issues** | Drag between columns | Change status/assignee |
| **Quick edit** | Hover over issue | Update properties inline |
| **Bulk selection** | `Shift + Click` | Multi-issue operations |
| **Create in column** | Click + in column | New issue with column property |
| **Auto-refresh** | Real-time updates | See team changes immediately |

### Board Customization

#### Visual Options
- **Choose grouping property**: Status, assignee, priority, labels
- **Show/hide columns**: Focus on relevant states
- **Set column limits**: WIP (Work In Progress) constraints
- **Color coding**: Visual categorization

#### Advanced Configuration
- **Custom column order**: Arrange by workflow
- **Column filters**: Show subset of items
- **Issue previews**: Expand for details
- **Compact mode**: More items visible

---

## 📅 Timeline & Planning Views

### Timeline View Purpose
Timeline provides a Gantt-style visualization showing issues scheduled over time, perfect for project planning, dependency management, and resource allocation.

### Timeline Features

#### Visual Elements
- **Gantt-style bars**: Show issue duration and timing
- **Dependency lines**: Connect related work
- **Milestone markers**: Important deadlines and deliverables
- **Today indicator**: Current progress reference
- **Critical path**: Longest sequence of dependent tasks

#### Timeline Grouping Options
| Grouping | Purpose | Best For |
|----------|---------|----------|
| **By assignee** | Individual workload view | Resource planning |
| **By project** | Project timeline view | Project management |
| **By team** | Team coordination | Cross-team planning |
| **By priority** | Urgency-based view | Risk management |
| **By status** | Workflow stage view | Process optimization |

### Using Timeline Effectively

#### Planning Activities
- **Drag to reschedule**: Move work to different dates
- **Resize for duration**: Adjust time estimates
- **Identify conflicts**: See overlapping work
- **Balance workload**: Distribute work evenly

#### Dependency Management
- **Draw connections**: Link dependent issues
- **See critical path**: Identify sequence bottlenecks
- **Spot blockers**: Find workflow impediments
- **Adjust for delays**: Cascade timeline changes

### Timeline Best Practices
1. **Set realistic dates**: Account for complexity and dependencies
2. **Include buffer time**: Allow for unexpected issues
3. **Review weekly**: Keep timeline current and accurate
4. **Update proactively**: Don't wait for delays to compound
5. **Communicate changes**: Alert team to timeline shifts

---

## 🎯 Custom Views

### Creating Custom Views

#### View Creation Process
1. **Start from any view**: Use existing view as foundation
2. **Apply filters**: Define what issues to show
3. **Choose layout**: Board, list, or timeline
4. **Set display options**: Grouping, sorting, appearance
5. **Save with descriptive name**: Make it findable

#### Access Methods
- **Keyboard**: `G` then `U` to go to Views
- **Quick open**: `O` then `V` to open specific view
- **Create from filter**: `Option/Alt + V` to save current filter
- **Sidebar**: Click "Views" for complete list

### View Components

#### Core Elements
| Component | Purpose | Options |
|-----------|---------|---------|
| **Filters** | Define what to show | Properties, dates, text, relations |
| **Grouping** | How to organize items | Status, assignee, project, priority |
| **Sorting** | Order of items | Created date, priority, status |
| **Display** | Visual options | Compact, detailed, preview |
| **Layout** | View type | Board, list, timeline |

#### Advanced Configuration
- **Multiple filters**: Combine AND/OR logic
- **Nested grouping**: Sub-categories within groups
- **Custom sorting**: Multiple sort criteria
- **Dynamic filters**: Relative dates, current user
- **Conditional formatting**: Visual highlighting

### View Management

#### Organization
- **Workspace views**: Shared across all teams
- **Team views**: Visible to team members only
- **Personal views**: Private to individual users
- **Favorites**: Quick access to frequently used views

#### Sharing and Collaboration
- **Share views**: Make custom views available to others
- **Copy view URLs**: Direct links to specific views
- **Duplicate views**: Create variations of existing views
- **Edit permissions**: Control who can modify views

### Common View Patterns

#### Development Team Views
```
"Frontend Issues" - Filter: assignee:frontend-team, status:active
"Bug Backlog" - Filter: label:bug, status:backlog
"This Sprint" - Filter: cycle:current, team:engineering
"Blocked Work" - Filter: blocked:true, assignee:me
```

#### Management Views
```
"Team Capacity" - Group: assignee, Filter: status:active
"Overdue Items" - Filter: due-date:<today, status:!done
"High Priority" - Filter: priority:urgent|high, status:!done
"Weekly Review" - Filter: updated:>7d, team:all
```

#### Product Views
```
"Feature Requests" - Filter: label:feature, status:backlog
"Customer Issues" - Filter: created-by:support, priority:high
"Release Planning" - Filter: project:current-release
"Design Review" - Filter: label:needs-design-review
```

---

## 🔍 Filtering System

### Filter Overview
Linear's powerful filtering system allows you to refine issue lists to show only relevant work. You can apply filters to almost every view and combine multiple filters for precise results.

### Accessing Filters
- **Keyboard**: Press `F` to open filter menu
- **Mouse**: Click "Filter" button in top bar
- **Command menu**: `Cmd/Ctrl + K` → "filter" → filter type
- **Quick filters**: Type filter name directly

### Filter Categories

#### Issue Properties
| Filter Type | Examples | Use Cases |
|-------------|----------|-----------|
| **Priority** | Urgent, High, Medium, Low | Focus on important work |
| **Status** | In Progress, Todo, Done | Track workflow stages |
| **Labels** | bug, feature, frontend | Categorize work types |
| **Estimate** | 1, 2, 3, 5, 8 points | Plan sprint capacity |
| **Project** | Q1 Launch, Mobile App | Project-specific views |
| **Cycle** | Current, Upcoming | Sprint planning |

#### User-Related Filters
- **Assignee**: Who's responsible for the work
- **Created by**: Who originally created the issue
- **Subscribers**: Who's following the issue
- **Team**: Which team owns the issue

#### Date Filters
- **Created**: When issue was created
- **Updated**: Last modification time
- **Due**: Deadline for completion
- **Completed**: When work was finished

#### Relationship Filters
- **Blocked**: Issues with dependencies
- **Blocking**: Issues preventing other work
- **Related**: Connected work items
- **Parent/Sub-issue**: Hierarchical relationships
- **Duplicate**: Identified duplicate work

### Advanced Filtering

#### Filter Operators
- **Is**: Exact match
- **Is not**: Exclusion
- **Contains**: Partial match
- **Does not contain**: Exclusion with partial match
- **Is empty**: No value set
- **Is not empty**: Has value

#### Date Operators
- **Before**: `<2024-01-01`
- **After**: `>2024-01-01`
- **Relative**: `<7d` (within 7 days)
- **Range**: Between two dates

#### Combining Filters
- **AND logic**: All conditions must be met
- **OR logic**: Any condition can be met
- **Mixed logic**: Complex combinations
- **Parentheses**: Group conditions

### Quick Filter Shortcuts

#### Property Quick Filters
| Property | Quick Filter Examples |
|----------|---------------------|
| **Team** | Type team name directly |
| **Status** | "in progress", "done", "backlog" |
| **Assignee** | Username or "me" |
| **Priority** | "high", "urgent", "low" |
| **Labels** | Label name or group name |
| **Project** | Project name |
| **Cycle** | "current", "active", "upcoming" |

#### Date Quick Filters
- **"Today"**: Issues for current date
- **"This week"**: Current week range
- **"Overdue"**: Past due date
- **"No due date"**: Unscheduled work

---

## 🏥 Triage Management

### Understanding Triage
Triage is a special inbox for your team where issues created by integrations or non-team members appear for review before entering your regular workflow.

### When Issues Go to Triage
- **Integration-created**: From Slack, Sentry, customer support
- **External creators**: Non-team members creating issues
- **Manual assignment**: Issues manually set to Triage status
- **Support requests**: Customer or stakeholder submissions

### Accessing Triage
- **Keyboard**: `G` then `T` to go to Triage
- **Team switching**: `O` then `T` to open different team's Triage
- **Sidebar**: Find under team's default views
- **Enable**: Team Settings → Triage (if not visible)

### Triage Actions

#### Primary Actions
| Action | Shortcut | Result |
|--------|----------|--------|
| **Accept** | `1` | Move to team's default status |
| **Mark as duplicate** | `2` | Merge with existing issue |
| **Decline** | `3` | Close as won't fix |
| **Snooze** | `H` | Temporarily hide for later review |

#### Detailed Actions
- **Accept with comment**: Provide feedback to creator
- **Assign to cycle**: Add to current sprint
- **Update properties**: Set priority, labels, assignee
- **Request information**: Comment and leave in Triage

### Triage Workflow

#### Daily Triage Process
1. **Review new items**: Check overnight submissions
2. **Categorize quickly**: Accept, duplicate, decline, or snooze
3. **Prioritize accepted**: Set urgency and assignments
4. **Communicate decisions**: Provide feedback to creators
5. **Update team**: Share important items from Triage

#### Triage Best Practices
1. **Review regularly**: Daily check prevents backlog
2. **Quick decisions**: Don't over-analyze in Triage
3. **Clear communication**: Explain decisions to creators
4. **Consistent criteria**: Define acceptance standards
5. **Team ownership**: Rotate Triage responsibility

### Triage Responsibility (Business/Enterprise)
- **Rotating schedule**: Assign Triage duty to team members
- **Responsibility tracking**: See who's on Triage duty
- **Notification settings**: Alert responsible person
- **Coverage planning**: Ensure Triage is always monitored

---

## 🔍 Search & Discovery

### Global Search
Linear provides powerful search capabilities across all your work:

#### Search Access
- **Keyboard**: Press `/` from anywhere
- **Command palette**: `Cmd/Ctrl + K` includes search
- **Search bar**: Click search icon in top navigation

#### Search Scope
- **Issues**: All work items and tasks
- **Projects**: Feature initiatives and goals
- **Documents**: Project documentation
- **Comments**: Discussions and updates
- **Teams**: Organizational units
- **Users**: Team members and stakeholders

### Search Syntax

#### Basic Search
- **Simple text**: Find by title or description
- **Issue IDs**: Direct issue lookup (e.g., ENG-123)
- **Partial matches**: Finds relevant content

#### Advanced Search Operators
```
assignee:me status:in-progress
label:bug priority:urgent  
created:>2024-01-01
updated:<7d
project:"Q1 Launch"
team:engineering
```

### Search Best Practices
1. **Use specific terms**: More precise results
2. **Combine operators**: Narrow down results
3. **Save as views**: Convert searches to custom views
4. **Use filters**: Combine search with filtering
5. **Recent items**: Check recent activity first

---

## 🎨 Display Options

### Layout Options

#### List View
- **Compact information**: See more items at once
- **Property columns**: Show specific fields
- **Quick actions**: Inline editing capabilities
- **Bulk operations**: Multi-select and edit

#### Board View
- **Visual workflow**: Column-based organization
- **Drag and drop**: Move items between states
- **WIP limits**: Constrain work in progress
- **Swimlanes**: Group by additional properties

#### Timeline View
- **Gantt charts**: See work over time
- **Dependencies**: Visual connection lines
- **Resource allocation**: Team capacity view
- **Milestone tracking**: Important deadlines

### Grouping and Sorting

#### Grouping Options
- **Status**: Workflow progression
- **Assignee**: Individual workload
- **Priority**: Urgency levels
- **Project**: Feature groupings
- **Team**: Organizational structure
- **Labels**: Work categorization

#### Sorting Criteria
- **Created date**: Newest or oldest first
- **Updated date**: Recently modified
- **Priority**: Importance order
- **Status**: Workflow progression
- **Assignee**: Alphabetical by person

### Visual Customization

#### Appearance Settings
- **Compact mode**: More items visible
- **Preview mode**: Show descriptions
- **Property display**: Choose visible fields
- **Color coding**: Visual categorization

#### Density Options
- **Comfortable**: Spacious layout
- **Compact**: Dense information
- **Minimal**: Essential information only

---

## ⌨️ Navigation Shortcuts

### Essential Navigation
| Shortcut | Action | Context |
|----------|--------|---------|
| `G + I` | Go to Issues | Global navigation |
| `G + P` | Go to Projects | Global navigation |
| `G + U` | Go to Views | Access custom views |
| `G + T` | Go to Triage | Team triage inbox |
| `G + M` | Go to My Issues | Personal work |
| `G + S` | Go to Settings | Configuration |

### View Management
| Shortcut | Action | Context |
|----------|--------|---------|
| `O + V` | Open specific view | Quick view access |
| `O + T` | Open team | Switch team context |
| `F` | Open filters | Add filtering |
| `Option/Alt + V` | Save current view | Create custom view |
| `Cmd/Ctrl + K` | Command palette | Universal actions |

### List Navigation
| Shortcut | Action | Context |
|----------|--------|---------|
| `J/K` | Move up/down | Navigate items |
| `Enter` | Open item | View details |
| `X` | Select item | Multi-selection |
| `Shift + X` | Select range | Bulk operations |
| `Cmd/Ctrl + A` | Select all | Bulk operations |

### Board Actions
| Shortcut | Action | Context |
|----------|--------|---------|
| `←/→` | Move between columns | Board navigation |
| `↑/↓` | Move within column | Item navigation |
| `C` | Create issue | New work item |
| `E` | Edit current | Quick editing |

## 💡 Best Practices Summary

### View Organization
1. **Create focused views**: Specific purposes and audiences
2. **Use descriptive names**: Make views findable
3. **Share team views**: Collaborate on common perspectives  
4. **Favorite frequently used**: Quick access to daily views
5. **Review and cleanup**: Remove outdated views

### Filtering Strategy
1. **Start broad, narrow down**: Progressive filtering
2. **Save useful filters**: Convert to custom views
3. **Combine multiple filters**: Precise results
4. **Use relative dates**: Dynamic, always current
5. **Document complex filters**: Help team understand

### Navigation Efficiency
1. **Master keyboard shortcuts**: Faster than mouse
2. **Use command palette**: Universal access point
3. **Customize workspace**: Arrange for your workflow
4. **Regular view maintenance**: Keep relevant and current
5. **Train team on patterns**: Shared efficiency gains

## 🔗 Related Guides

- **[Issues Management](issues-management.md)** - Creating and organizing work items
- **[User Account](user-account.md)** - Personal productivity settings
- **[Projects & Cycles](projects-cycles.md)** - Higher-level planning and organization
- **[Workspace Management](workspace-management.md)** - Team and workspace setup
- **[Getting Started](getting-started.md)** - Basic Linear concepts and navigation

---

*Mastering Linear's views and navigation system transforms how you interact with your work, making it easier to focus on what matters and coordinate with your team effectively.*