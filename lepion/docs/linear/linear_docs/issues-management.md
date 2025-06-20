---
title: "Issues Management"
description: "- [Understanding Issues](#understanding-issues)"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Issues Management

Complete guide to creating, organizing, and managing work items in Linear.

## 📋 Table of Contents

- [Understanding Issues](#understanding-issues)
- [Creating Issues](#creating-issues)
- [Issue Properties](#issue-properties)
- [Editing & Updating](#editing-updating)
- [Issue Hierarchy](#issue-hierarchy)
- [Issue Relations](#issue-relations)
- [Labels & Organization](#labels-organization)
- [Templates](#templates)
- [Comments & Collaboration](#comments-collaboration)
- [Workflow Management](#workflow-management)

---

## 📝 Understanding Issues

### What are Issues?
Issues are the fundamental unit of work in Linear. They represent tasks, bugs, features, or any work item that needs to be tracked and completed.

### Issue Types
- **Tasks**: General work items and to-dos
- **Bugs**: Defects and issues to fix
- **Features**: New functionality to build
- **Improvements**: Enhancements to existing features
- **Research**: Investigation and discovery work

### Issue Lifecycle
1. **Creation**: Issue is created and added to backlog
2. **Planning**: Prioritized and assigned to cycles/projects
3. **Development**: Moved through workflow states
4. **Review**: Verified and tested
5. **Completion**: Marked as done or canceled

---

## ➕ Creating Issues

### Quick Creation Methods

#### Primary Creation
- **Keyboard shortcut**: Press `C` from anywhere in Linear
- **From toolbar**: Click the + button
- **Command palette**: `Cmd/Ctrl + K` → "New issue"

#### Advanced Creation
- **From templates**: `Cmd/Ctrl + K` → "New issue from template"
- **From selection**: Select text and press `C` to create issue with context
- **Bulk creation**: Create multiple issues from lists in descriptions

### Required Fields
- **Title**: Clear, actionable description of the work

### Optional Fields
| Field | Purpose | Examples |
|-------|---------|----------|
| **Description** | Detailed information, acceptance criteria | User stories, technical specs |
| **Assignee** | Team member responsible | Developer, designer, QA |
| **Status** | Current state of work | Backlog, Todo, In Progress |
| **Priority** | Urgency level | Urgent, High, Medium, Low |
| **Labels** | Categories and tags | bug, feature, frontend |
| **Project** | Parent project | Q1 Launch, Mobile App |
| **Cycle** | Sprint assignment | Current cycle, Sprint 23 |
| **Estimate** | Complexity points | 1, 2, 3, 5, 8 points |
| **Due date** | Deadline | Specific date or milestone |

### Creation Best Practices
1. **Clear titles**: Action-oriented and searchable
2. **Detailed descriptions**: Include acceptance criteria
3. **Proper categorization**: Use appropriate labels and projects
4. **Right sizing**: Break large tasks into smaller issues

---

## 🏷️ Issue Properties

### Status Management

#### Default Workflow States
1. **Backlog**: Not yet prioritized or planned
2. **Todo**: Ready to start working
3. **In Progress**: Actively being worked on
4. **In Review**: Awaiting review or testing
5. **Done**: Completed successfully
6. **Canceled**: Won't be completed

#### Custom Workflows
Teams can customize states to match their process:
- Add new states (e.g., "Design Review", "QA Testing")
- Rename existing states
- Set state categories (Unstarted, Started, Completed, Canceled)
- Configure auto-close rules

### Priority Levels

#### Priority Scale
- **Urgent (1)**: Drop everything, critical issues
- **High (2)**: Next priority, important work
- **Medium (3)**: Normal workflow priority
- **Low (4)**: When time permits
- **No priority**: Backlog items, not yet triaged

#### Priority Guidelines
- **Urgent**: Production outages, security issues
- **High**: Key features, blocking issues
- **Medium**: Standard development work
- **Low**: Nice-to-have improvements

### Estimates and Sizing

#### Estimation Methods
- **Story points**: 1, 2, 3, 5, 8, 13 (Fibonacci)
- **T-shirt sizes**: XS, S, M, L, XL
- **Time-based**: Hours or days
- **Custom scales**: Team-defined values

#### Estimation Best Practices
- Use consistent scale across team
- Consider complexity, not just time
- Update estimates as understanding improves
- Include testing and review time

### Due Dates and Deadlines
- Set realistic target dates
- Use for external dependencies
- Consider team capacity
- Track overdue items

---

## ✏️ Editing & Updating

### Single Issue Editing

#### Inline Editing
- Click any field to edit directly
- Changes save automatically
- Use Tab to move between fields

#### Quick Actions
| Shortcut | Action | Description |
|----------|--------|-------------|
| `E` | Edit title | Quick title editing |
| `Cmd/Ctrl + I` | Open sidebar | Full property editing |
| `S` | Change status | Workflow state transitions |
| `A` | Assign | Set assignee |
| `L` | Add labels | Apply categorization |
| `P` | Set project | Project assignment |
| `D` | Set due date | Add deadline |
| `1-5` | Set priority | Quick priority setting |

### Bulk Editing

#### Selection Methods
- **Range selection**: `Shift + Click` for range
- **Individual selection**: `Cmd/Ctrl + Click` for specific issues
- **Select all**: `Cmd/Ctrl + A` for all visible issues
- **Keyboard selection**: `X` to select current issue

#### Bulk Operations
1. Select multiple issues using methods above
2. Press `Cmd/Ctrl + Shift + E` for bulk edit
3. Update common properties
4. Apply changes to all selected issues

#### Bulk Actions Available
- Change status
- Update assignee
- Add/remove labels
- Set project
- Update priority
- Set due dates
- Archive issues

### Issue Actions

#### Individual Issue Actions
- **Duplicate**: Create copy with same properties
- **Move**: Transfer to different team
- **Archive**: Remove from active views
- **Delete**: Permanently remove (admin only)
- **Subscribe**: Get notifications for updates

#### Contextual Menus
Right-click any issue for quick access to:
- Property updates
- Status changes
- Assignment options
- Label management

---

## 🌳 Issue Hierarchy

### Understanding Issue Hierarchy

#### Parent Issues
- **Purpose**: High-level tasks or features
- **Function**: Container for related work
- **Usage**: Track overall progress
- **Example**: "User Authentication Feature"

#### Sub-Issues
- **Purpose**: Specific implementation tasks
- **Function**: Individual work items
- **Assignment**: Can be assigned separately
- **Progress**: Rolls up to parent completion

### Creating Issue Hierarchies

#### Methods to Create Sub-Issues
1. **From parent**: Click "Add sub-issue" button
2. **Convert existing**: Drag issue onto another to make it a sub-issue
3. **Keyboard shortcut**: Select issue, press `Cmd/Ctrl + Shift + .`
4. **Bulk creation**: List tasks in description, convert to sub-issues

#### Hierarchy Best Practices
- **Keep sub-issues focused**: Single, clear objectives
- **Distribute work**: Assign sub-issues to different team members
- **Consistent naming**: Use clear, descriptive titles
- **Progress tracking**: Update parent when sub-issues complete
- **Reasonable depth**: Avoid too many hierarchy levels

### Managing Hierarchies

#### Progress Tracking
- Parent shows completion percentage automatically
- Visual progress indicators
- Automatic rollup from sub-issues
- Status inheritance options

#### Navigation
- **Breadcrumb navigation**: Clear path through hierarchy
- **Quick jumping**: Move between levels efficiently
- **Collapsible views**: Manage visual complexity
- **Tree view**: See entire hierarchy structure

---

## 🔗 Issue Relations

### Types of Relations

#### Blocking Relationships
- **Blocks**: Current issue prevents other work
- **Blocked by**: Other issues prevent current work
- **Visual indicators**: Red/orange flags in UI
- **Workflow impact**: Helps prioritize unblocking work

#### Associative Relations
- **Related to**: Loose connections between issues
- **Purpose**: Reference and context
- **Usage**: Similar work or shared themes
- **No dependency**: Doesn't affect workflow

#### Duplicate Handling
- **Duplicate of**: Same work item as another issue
- **Purpose**: Consolidate efforts and avoid double work
- **Action**: Close duplicates, link to original
- **Status**: Automatically set to canceled

### Creating Relations

#### Adding Relations
1. **From issue sidebar**: Relations section
2. **Keyboard shortcuts**: 
   - `M + R`: Add related issue
   - `M + B`: Mark as blocked by
   - `M + X`: Mark as blocking
   - `M + M`: Mark as duplicate
3. **Drag & drop**: In board view for some relations
4. **Command palette**: `Cmd/Ctrl + K` → relation actions

#### Automatic Relations
- **Reference linking**: Issues mentioned in descriptions/comments become related
- **Pull request linking**: Connected via Git integration
- **Import relations**: Preserved during data imports

### Managing Relations

#### Removing Relations
- **Hover and click X**: On related issue
- **Command menu**: `Cmd/Ctrl + K` → "Remove relation"
- **Bulk operations**: Select multiple and remove

#### Relation Best Practices
1. **Document reasons**: Add comments explaining relationships
2. **Minimize dependencies**: Keep blocking relationships essential only
3. **Regular review**: Clean up outdated relations
4. **Update on completion**: Mark blocking issues as resolved

---

## 🏷️ Labels & Organization

### Label System Overview

#### Label Types
- **Workspace labels**: Available to all teams
- **Team labels**: Scoped to specific teams
- **Label groups**: Organized categories with single selection

#### Common Label Categories
| Category | Examples | Purpose |
|----------|----------|---------|
| **Type** | bug, feature, improvement, task | Work classification |
| **Area** | frontend, backend, design, infrastructure | Technical domain |
| **Priority** | P0, P1, P2, P3 | Alternative priority system |
| **Status** | needs-review, blocked, waiting-for-feedback | Workflow states |
| **Platform** | web, mobile, desktop, API | Target platform |
| **Effort** | quick-win, large-effort, research | Size indicators |

### Creating and Managing Labels

#### Creating Labels
1. **Settings approach**: Go to **Settings > Workspace > Labels** or **Team Settings > Labels**
2. **Inline creation**: During "Add label" workflow
3. **Quick syntax**: Use `group/label` or `group:label` format

#### Label Properties
- **Name**: Descriptive identifier
- **Color**: Visual categorization (custom hex codes supported)
- **Description**: Usage guidelines
- **Scope**: Workspace or team level

#### Label Groups
- **Purpose**: Organize related labels
- **Limitation**: Only one label per group can be applied
- **Maximum**: 250 labels per group
- **Examples**: Priority group (P0, P1, P2), Type group (bug, feature, task)

### Using Labels Effectively

#### Applying Labels
- **Keyboard shortcut**: Press `L` on any issue
- **Bulk application**: Select multiple issues, press `L`
- **During creation**: Add labels when creating issues
- **Drag and drop**: In some board views

#### Label Strategy
1. **Start minimal**: Begin with few essential labels
2. **Consistent naming**: Use clear, standardized names
3. **Document meanings**: Define what each label represents
4. **Regular cleanup**: Archive unused labels
5. **Team alignment**: Ensure team understands label system

#### Filtering and Views
- **Multi-team filtering**: Team labels with same name act as workspace labels
- **Custom views**: Save filtered views by labels
- **Search integration**: Labels work in global search
- **API considerations**: Use unique identifiers for team labels

---

## 📄 Templates

### Template System

#### Template Types
1. **Issue templates**: Standardized issue creation
2. **Project templates**: Reusable project structures
3. **Document templates**: Consistent documentation

#### Template Benefits
- **Consistency**: Ensure all necessary information captured
- **Efficiency**: Save time on common issue types
- **Quality**: Reduce errors and omissions
- **Onboarding**: Help new team members create proper issues

### Creating Issue Templates

#### Template Elements
- **Name**: Descriptive identifier
- **Icon**: Visual recognition
- **Title format**: With variables and placeholders
- **Description**: Pre-filled content with prompts
- **Default properties**: Status, labels, assignee, etc.

#### Template Variables
- `{{user}}`: Current user creating the issue
- `{{date}}`: Today's date
- `{{team}}`: Current team
- `{{project}}`: Active project

### Common Template Examples

#### Bug Report Template
```markdown
## Bug Description
Brief description of the bug

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- Browser:
- OS:
- Version:

## Additional Context
Screenshots, logs, etc.
```

#### Feature Request Template
```markdown
## Problem Statement
What problem does this solve?

## Proposed Solution
How should we solve it?

## Success Criteria
How will we know it's successful?
- [ ] Criterion 1
- [ ] Criterion 2

## Impact Assessment
- User impact:
- Technical complexity:
- Business value:

## Additional Context
Links, mockups, research
```

#### Task Template
```markdown
## Objective
What needs to be accomplished?

## Requirements
- [ ] Requirement 1
- [ ] Requirement 2

## Dependencies
What needs to happen first?

## Definition of Done
- [ ] Task completed
- [ ] Tests written
- [ ] Documentation updated
- [ ] Code reviewed
```

### Using Templates

#### Access Methods
- `Cmd/Ctrl + K` → "New issue from template"
- Templates button in issue creation dialog
- Team-specific quick actions
- URL parameters for direct access

#### Template Customization
- **Override defaults**: Modify pre-filled values
- **Fill variables**: Replace template placeholders
- **Add content**: Expand on template structure
- **Save variations**: Create new templates from modifications

---

## 💬 Comments & Collaboration

### Commenting System

#### Adding Comments
- **Type in comment box**: Standard text input
- **Submit**: `Cmd/Ctrl + Enter` to save
- **Formatting**: Full Markdown support
- **Attachments**: Drag & drop files and images

#### Comment Features
- **Mentions**: `@username` for notifications
- **Issue references**: `#issue-id` for linking
- **Reactions**: Emoji responses to comments
- **Threads**: Reply to specific comments
- **Editing**: Modify your own comments
- **Deletion**: Remove comments if needed

### Rich Content Support

#### Formatting Options
- **Headers**: `#`, `##`, `###`
- **Lists**: `-` for bullets, `1.` for numbers
- **Code**: Backticks for inline, triple backticks for blocks
- **Links**: `[text](url)` format
- **Quotes**: `>` for blockquotes
- **Tables**: Standard Markdown table syntax

#### Media and Embeds
- **Images**: Drag & drop or paste from clipboard
- **Videos**: Upload or link to external videos
- **Automatic embeds**: YouTube, Loom, Figma
- **Code snippets**: GitHub Gists
- **File attachments**: Documents, PDFs, etc.

### Collaboration Best Practices

#### Communication Guidelines
1. **Stay focused**: Keep comments relevant to the issue
2. **Use threads**: Organize sub-discussions
3. **Mention stakeholders**: Notify relevant team members
4. **Document decisions**: Clearly summarize outcomes

#### Status Updates
- **Start work**: Comment when beginning tasks
- **Progress updates**: Regular status communication
- **Blockers**: Immediately note impediments
- **Completion**: Document what was accomplished

---

## ⚙️ Workflow Management

### Custom Workflows

#### Workflow Customization
Teams can customize issue workflows to match their processes:
- **Add states**: Create new workflow steps
- **Rename states**: Use familiar terminology
- **Set categories**: Group states (Unstarted, Started, Completed)
- **Configure transitions**: Control valid state changes

#### Common Workflow Patterns

**Development Workflow**:
Backlog → Todo → In Progress → Code Review → QA → Done

**Design Workflow**:
Backlog → Todo → In Progress → Design Review → Approved → Done

**Support Workflow**:
New → Triaged → In Progress → Waiting for Customer → Resolved

### Automation

#### Git Integration
- **Status transitions**: Auto-update on PR events
- **Branch creation**: Generate branch names from issues
- **Commit linking**: Connect commits to issues
- **Auto-assignment**: Assign issues on branch creation

#### Rule-Based Automation
- **Auto-assign**: Set assignee based on labels or projects
- **Status updates**: Change status based on conditions
- **Label application**: Auto-label based on title keywords
- **Notifications**: Send alerts for specific events

### Workflow Best Practices

#### State Management
1. **Clear definitions**: Define what each state means
2. **Logical flow**: Ensure smooth transitions
3. **Minimal states**: Don't over-complicate workflows
4. **Team alignment**: Ensure everyone understands the process

#### Issue Hygiene
- **Regular triage**: Review and organize backlog
- **Status updates**: Keep issues current
- **Cleanup**: Archive completed work
- **Review cycles**: Periodic workflow assessment

## 💡 Best Practices Summary

### Issue Creation
1. **Descriptive titles**: Clear, action-oriented descriptions
2. **Detailed descriptions**: Include acceptance criteria and context
3. **Proper sizing**: Break large issues into manageable pieces
4. **Consistent labeling**: Use standardized categorization

### Issue Management
1. **Regular updates**: Keep status and progress current
2. **Use relations**: Link related work appropriately
3. **Manage subscriptions**: Stay informed on relevant issues
4. **Archive completed**: Keep active views clean

### Team Collaboration
1. **Clear communication**: Document decisions and progress
2. **Timely responses**: Address blockers quickly
3. **Knowledge sharing**: Use comments for team learning
4. **Consistent processes**: Follow established workflows

## 🔗 Related Guides

- **[Getting Started](getting-started.md)** - Basic Linear setup and usage
- **[User Account](user-account.md)** - Personal settings and preferences
- **[Projects & Cycles](projects-cycles.md)** - Higher-level planning and organization
- **[Views & Navigation](views-navigation.md)** - Custom views and filtering
- **[Integrations](integrations.md)** - Connect external tools and workflows

---

*Effective issue management is the foundation of productive software development. Master these concepts to maximize your team's efficiency in Linear.*