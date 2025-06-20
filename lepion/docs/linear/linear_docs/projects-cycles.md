---
title: "Projects & Cycles Management"
description: "- [Understanding Projects](#understanding-projects)"
category: "project-management"
type: "guide"
tags: ["doppler", "projects", "organization"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Projects & Cycles Management

Complete guide to planning, organizing, and tracking larger initiatives and sprint-based work in Linear.

## 📋 Table of Contents

- [Understanding Projects](#understanding-projects)
- [Creating & Managing Projects](#creating-managing-projects)
- [Project Structure & Organization](#project-structure-organization)
- [Project Milestones](#project-milestones)
- [Initiatives & Strategic Planning](#initiatives-strategic-planning)
- [Project Updates & Communication](#project-updates-communication)
- [Understanding Cycles](#understanding-cycles)
- [Cycle Planning & Management](#cycle-planning-management)
- [Progress Tracking & Analytics](#progress-tracking-analytics)

---

## 🎯 Understanding Projects

### What are Projects?
Projects are units of work with clear outcomes and planned completion dates, such as new feature launches. They comprise issues and optional documents, can be shared across multiple teams, and come with unique features like progress graphs and notification options.

### Project vs. Issue Hierarchy
```
Initiative (Strategic Goal)
  └── Projects (Features/Outcomes)
       └── Issues (Tasks/Work Items)
            └── Sub-issues (Implementation Details)
```

### When to Use Projects
- **Feature development**: New product capabilities
- **Major releases**: Version launches or updates
- **Cross-team initiatives**: Multi-departmental efforts
- **Time-boxed efforts**: Work with clear deadlines
- **Milestone tracking**: Progress toward specific goals

### Project Benefits
- **Organized work**: Group related issues together
- **Progress visibility**: Track completion and timeline
- **Team collaboration**: Share context across teams
- **Stakeholder communication**: Regular updates and status
- **Resource planning**: Understand capacity and allocation

---

## ➕ Creating & Managing Projects

### Creating Projects

#### Quick Creation
- **From projects view**: Click **+ New Project**
- **Command palette**: `Cmd/Ctrl + K` → "New project"
- **From team level**: Access team-specific project creation
- **From workspace**: Create workspace-wide projects

#### Required Information
- **Project name**: Clear, descriptive title that explains the outcome
- **Project lead**: Primary responsible person for execution and updates

#### Optional Setup Fields
| Field | Purpose | Examples |
|-------|---------|----------|
| **Icon** | Visual identifier | 🚀, 📱, ⚙️, 🎨 |
| **Color** | Quick recognition | Blue for infrastructure, Green for features |
| **Description** | Context and goals | Problem statement, success criteria |
| **Start date** | When work begins | Project kickoff date |
| **Target date** | Expected completion | Launch date, milestone deadline |
| **Teams** | Multi-team collaboration | Engineering, Design, Marketing |
| **Status** | Current state | Not started, Started, Completed, Canceled |
| **Health** | Progress assessment | On track, At risk, Off track |
| **Priority** | Strategic importance | High, Medium, Low |

### Project Management

#### Accessing Project Settings
- **Sidebar toggle**: `Cmd/Ctrl + I` in project view
- **Right-click menu**: On project in lists or boards
- **Overview page**: Click properties to edit inline

#### Project Properties Management
- **Update status**: Change between Not started, Started, Completed, Canceled
- **Health tracking**: Monitor if project is on track, at risk, or off track
- **Date adjustments**: Modify start and target dates as needed
- **Team management**: Add or remove teams from project
- **Visibility control**: Set as public or private

### Adding Work to Projects

#### Adding Issues
| Method | How to Use | Best For |
|--------|------------|----------|
| **Create new** | Press `C` from project view | New work items |
| **Move existing** | Select issues, press `Shift + P` | Reorganizing work |
| **Bulk assignment** | Multi-select and batch update | Large reorganizations |
| **Convert from bullets** | Transform document lists to issues | Planning sessions |

#### Issue-Project Relationship
- **One project per issue**: Issues can only belong to one project at a time
- **Sub-issue workaround**: Create sub-issues for different projects
- **Project inheritance**: Sub-issues can inherit parent project assignment

#### Project Views
Next to the "Issues" tab in each project:
- **Create custom views**: Filter and save specific issue perspectives
- **Reorder views**: Drag and drop to reorganize
- **Team-specific views**: Different views for different teams
- **Saved filters**: Persistent filtering for common use cases

---

## 🏗️ Project Structure & Organization

### Project Overview Page

#### Core Sections
1. **Header**: Title, lead, status, and health indicators
2. **Summary**: Brief description and key objectives
3. **Properties**: Metadata like dates, teams, priority
4. **Resources**: Links to external documents and tools
5. **Description**: Detailed information and context
6. **Milestones**: Timeline markers and deliverables
7. **Activity**: Recent updates and changes

#### Customization Options
- **Reorder sections**: Arrange information by importance
- **Add custom fields**: Team-specific metadata
- **Embed content**: Include charts, images, links
- **Pin important info**: Highlight critical details

### Project Documents

#### Document System
Projects include collaborative document creation and management:

**Creating Documents**:
1. From project overview, click **+ Add document**
2. Enter descriptive title
3. Choose icon and color for organization
4. Start collaborative writing

#### Document Types
| Type | Purpose | Contains |
|------|---------|----------|
| **PRD** | Product requirements | Features, user stories, acceptance criteria |
| **Technical Spec** | Implementation details | Architecture, APIs, database design |
| **Design Doc** | UI/UX specifications | Wireframes, mockups, user flows |
| **Meeting Notes** | Decision records | Action items, discussions, outcomes |
| **Status Reports** | Regular updates | Progress, blockers, next steps |

#### Collaborative Features
- **Real-time editing**: Multiple cursors and instant sync
- **Presence indicators**: See who's currently editing
- **Auto-save**: Never lose work
- **Version history**: Track changes over time
- **Rich formatting**: Same editor as issues with Markdown support

### Multi-Team Projects

#### Setup and Management
- **Add teams during creation**: Include relevant teams from start
- **Separate team tabs**: Organize issues by team
- **Unified progress tracking**: See overall project completion
- **Cross-team collaboration**: Shared context and communication

#### Team-Specific Views
- **Team filtering**: View only your team's issues
- **Custom workflows**: Teams can use different states
- **Independent planning**: Teams plan their own cycles
- **Shared milestones**: Common deliverables and deadlines

---

## 🎯 Project Milestones

### Understanding Milestones
Milestones mark significant achievements or phases within a project, helping track progress and celebrate wins along the way.

### Creating Effective Milestones

#### Milestone Types
1. **Phase completion**: End of design phase, development complete
2. **Deliverables**: Beta release, public launch, feature complete
3. **Reviews**: Stakeholder approval, security review
4. **External deadlines**: Customer commitments, conference demos

#### Milestone Properties
- **Name**: Clear, specific identifier
- **Target date**: When milestone should be achieved
- **Description**: Success criteria and definition of done
- **Linked issues**: Work items required for completion
- **Dependencies**: Other milestones or external factors

### Managing Milestones

#### Progress Tracking
- **Completion percentage**: Automatic calculation from linked issues
- **Issues remaining**: Count of outstanding work
- **Days until due**: Time pressure indicator
- **Risk indicators**: Early warning system for delays

#### Milestone Updates
- **Date adjustments**: Modify timelines based on new information
- **Scope changes**: Add or remove linked issues
- **Description updates**: Clarify success criteria
- **Completion marking**: Celebrate achievement

### Milestone Best Practices
1. **Keep milestones meaningful**: Represent significant progress
2. **Space appropriately**: Not too frequent, not too sparse
3. **Link all related issues**: Ensure complete tracking
4. **Celebrate completions**: Acknowledge team achievements
5. **Review in retrospectives**: Learn from milestone patterns

---

## 🎢 Initiatives & Strategic Planning

### What are Initiatives?
Initiatives are high-level organizational objectives that group multiple projects. They represent strategic goals spanning quarters or years and provide executive-level visibility.

### Creating Initiatives

#### Initiative Setup
1. Navigate to Initiatives view (if enabled in workspace)
2. Click **+ New Initiative**
3. Define strategic goal and business objective
4. Set long-term timeline (quarters or years)
5. Link relevant projects

#### Initiative Properties
| Property | Purpose | Examples |
|----------|---------|----------|
| **Name** | Strategic objective | "Improve Customer Onboarding", "Mobile Platform" |
| **Lead** | Executive sponsor | VP Product, Engineering Director |
| **Timeline** | Long-term planning | Q1-Q3 2024, 2024 Annual Goal |
| **Projects** | Linked projects | Onboarding redesign, Mobile app, API development |
| **Metrics** | Success KPIs | User activation rate, mobile adoption |

### Initiative Management

#### Strategic Hierarchy
```
Initiative: Mobile Platform Strategy
  ├── Project: iOS App Development
  │   ├── Issue: User authentication
  │   └── Issue: Core features
  ├── Project: Android App Development
  │   ├── Issue: Platform setup
  │   └── Issue: Feature parity
  └── Project: Backend API
      ├── Issue: Mobile endpoints
      └── Issue: Performance optimization
```

#### Progress Tracking
- **Rollup metrics**: Automatic aggregation from all linked projects
- **Quarterly reviews**: Regular strategic assessment
- **Strategic alignment**: Ensure projects support initiative goals
- **Resource allocation**: Understand investment across initiatives

### Initiative Views
- **Roadmap timeline**: Visual planning across quarters
- **Progress dashboard**: Executive summary of completion
- **Team allocation**: Resource distribution across initiatives
- **Milestone tracking**: Key deliverables and deadlines

---

## 📢 Project Updates & Communication

### Update System

#### Purpose of Updates
- **Communicate progress**: Keep stakeholders informed
- **Align teams**: Ensure everyone understands current state
- **Document decisions**: Record important choices and changes
- **Track changes**: Monitor scope and timeline adjustments

#### Update Types
1. **Status updates**: Regular progress reports
2. **Milestone updates**: Completion announcements
3. **Change updates**: Scope or timeline adjustments
4. **Risk updates**: Issues and mitigation strategies

### Creating Effective Updates

#### Update Components
- **Status indicator**: On track, at risk, off track
- **Executive summary**: Key points for leadership
- **Progress details**: What's been completed
- **Next steps**: Upcoming work and priorities
- **Blockers**: Issues needing escalation or help
- **Metrics**: Quantitative progress indicators

#### Rich Content in Updates
- **Metrics and charts**: Visual progress representation
- **Before/after comparisons**: Show improvements
- **Team highlights**: Recognize contributions
- **Visual progress**: Screenshots, demos, prototypes

### Update Workflow

#### Update Frequency
- **Weekly updates**: For active, fast-moving projects
- **Bi-weekly updates**: For longer-term initiatives
- **Milestone updates**: On significant achievements
- **Ad-hoc updates**: For major changes or risks

#### Distribution and Visibility
- **Auto-notifications**: Automatic alerts to stakeholders
- **Slack/Teams integration**: Post updates to team channels
- **Email digests**: Summary emails for executives
- **Dashboard views**: Centralized update viewing

---

## 🔄 Understanding Cycles

### What are Cycles?
Cycles are fixed time periods (usually 1-2 weeks) for planning and executing work, similar to sprints in Agile methodology. They help maintain team momentum and provide regular delivery cadence.

### Cycle Philosophy
Cycles in Linear are designed to:
- **Maintain momentum**: Regular delivery rhythm
- **Focus work**: Clear boundaries and objectives
- **Enable planning**: Predictable schedule for stakeholders
- **Allow flexibility**: Adapt to changing priorities
- **Measure progress**: Track team velocity and performance

### Setting Up Cycles

#### Team Configuration
1. Go to **Team Settings** → **Cycles**
2. **Enable cycles**: Turn on cycle functionality
3. **Set duration**: Choose 1-4 weeks (2 weeks recommended)
4. **Choose start day**: Monday is common
5. **Configure cooldown**: Break time between cycles

#### Cycle Properties
- **Cycle number**: Sequential identifier (e.g., Cycle 12)
- **Custom name**: Optional descriptive name
- **Duration**: Time period length
- **Cooldown period**: Buffer time between cycles
- **Auto-scheduling**: Automatic cycle transitions

### Cycle States
- **Upcoming**: Next planned cycle
- **Active**: Current cycle in progress
- **Completed**: Finished cycles
- **Cooldown**: Break period between cycles

---

## 📝 Cycle Planning & Management

### Pre-Cycle Planning

#### Preparation Steps
1. **Review backlog**: Assess available work items
2. **Estimate capacity**: Consider team availability
3. **Prioritize issues**: Order by business value and urgency
4. **Size estimation**: Ensure work fits in cycle duration

#### Planning Meeting Process
- **Set cycle goals**: Define what success looks like
- **Balance workload**: Distribute work across team members
- **Consider dependencies**: Identify blocking relationships
- **Leave buffer time**: Account for unexpected work

### Issue Selection for Cycles

#### Selection Criteria
- **Mix of sizes**: Combine small, medium, and large issues
- **Clear priorities**: Understand business importance
- **Achievable scope**: Realistic for team capacity
- **Team consensus**: Agreement on commitments

#### Capacity Planning
- **Team availability**: Account for time off, meetings
- **Historical velocity**: Use past performance as guide
- **Issue complexity**: Consider difficulty and unknowns
- **Buffer time**: Reserve 20% for unexpected work

### Managing Active Cycles

#### Daily Cycle Management
- **Review progress**: Check issue status updates
- **Update statuses**: Move issues through workflow
- **Address blockers**: Identify and resolve impediments
- **Adjust scope**: Add or remove work as needed

#### Mid-Cycle Assessment
- **Check velocity**: Are we on track for completion?
- **Reallocate work**: Balance load across team members
- **Remove blocked items**: Move obstacles to backlog
- **Add capacity work**: Include additional issues if ahead

#### End of Cycle Process
1. **Review completion**: Assess what was finished
2. **Move incomplete items**: Transfer to next cycle or backlog
3. **Document learnings**: Record insights and improvements
4. **Celebrate wins**: Acknowledge team achievements
5. **Plan next cycle**: Begin planning for upcoming work

---

## 📊 Progress Tracking & Analytics

### Project Progress Graphs

#### Understanding Project Graphs
The project graph visualizes progress over time, showing completion trends and predicting finish dates based on current velocity.

#### Graph Components
- **X-axis**: Time progression (days/weeks)
- **Y-axis**: Completion metric (issues completed or story points)
- **Ideal line**: Target progress rate
- **Actual line**: Real progress achieved
- **Projected line**: Estimated completion based on current trend

#### Graph Markers
- **Milestones**: Important deliverables and deadlines
- **Scope changes**: When work is added or removed
- **Team changes**: When team composition changes
- **Blocker periods**: Times when progress was impeded

### Reading Project Health

#### Healthy Progress Patterns
- **Steady progress**: Consistent upward trend
- **Above ideal line**: Ahead of schedule
- **Consistent velocity**: Predictable delivery rate
- **Clear acceleration**: Improving team performance

#### Warning Signs
- **Flat lines**: No progress for extended periods
- **Below ideal**: Falling behind target schedule
- **Erratic changes**: Unpredictable velocity
- **Scope creep**: Continuously increasing work

### Cycle Analytics

#### Key Cycle Metrics
- **Completion rate**: Percentage of planned work finished
- **Velocity**: Points or issues completed per cycle
- **Scope change**: Amount of work added or removed mid-cycle
- **Team capacity**: Actual vs. planned utilization

#### Historical Analysis
- **Velocity trends**: How team speed changes over time
- **Completion improvements**: Getting better at delivery
- **Estimation accuracy**: How well team estimates work
- **Capacity planning**: Understanding team limits

### Using Analytics for Improvement

#### Data-Driven Actions
1. **Adjust scope**: Reduce if consistently behind schedule
2. **Add resources**: Increase team size if needed
3. **Re-estimate timeline**: Update targets based on reality
4. **Communicate changes**: Keep stakeholders informed
5. **Celebrate momentum**: Recognize good performance

#### Continuous Improvement Process
- **Regular retrospectives**: Team reflection on performance
- **Process experiments**: Try new approaches
- **Measure impact**: Track improvement results
- **Standardize successes**: Adopt what works
- **Share learnings**: Help other teams improve

### Cycle Graph Analysis

#### Current Cycle Insights
- **Daily progress**: Track daily completion rate
- **Remaining work**: Understand what's left
- **Burn-down rate**: How quickly work is being completed
- **Completion prediction**: When cycle will likely finish

#### Historical Cycle Trends
- **Past performance**: Previous cycle completion rates
- **Velocity patterns**: Seasonal or periodic changes
- **Team improvements**: Upward trends in performance
- **Planning accuracy**: How well team estimates cycles

## 💡 Best Practices Summary

### Project Management
1. **Clear objectives**: Define specific, measurable outcomes
2. **Regular updates**: Communicate progress consistently
3. **Scope management**: Control changes and additions
4. **Team collaboration**: Ensure cross-functional coordination
5. **Milestone tracking**: Celebrate progress and achievements

### Cycle Planning
1. **Realistic planning**: Don't overcommit team capacity
2. **Clear priorities**: Understand what matters most
3. **Buffer time**: Reserve capacity for unexpected work
4. **Team input**: Include team in planning decisions
5. **Continuous improvement**: Learn from each cycle

### Progress Tracking
1. **Regular monitoring**: Check progress frequently
2. **Early warnings**: Address issues before they become critical
3. **Data-driven decisions**: Use analytics to guide choices
4. **Transparent communication**: Share status openly
5. **Celebrate successes**: Recognize team achievements

## 🔗 Related Guides

- **[Issues Management](issues-management.md)** - Creating and organizing individual work items
- **[Workspace Management](workspace-management.md)** - Team setup and organization
- **[Views & Navigation](views-navigation.md)** - Custom views and filtering
- **[User Account](user-account.md)** - Personal productivity features
- **[Getting Started](getting-started.md)** - Basic Linear concepts and setup

---

*Effective project and cycle management transforms how teams plan, execute, and deliver software. Master these concepts to build predictable, high-performing development processes.*