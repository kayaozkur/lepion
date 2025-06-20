---
title: "Pull Request Reviews"
description: "The Pull Request Reviews feature integrates GitHub PRs into Linear, streamlining your code review workflow. Access a dedicated Reviews section in your sidebar to:"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Pull Request Reviews

View and comment on pull request reviews directly from Linear.

## Overview

The Pull Request Reviews feature integrates GitHub PRs into Linear, streamlining your code review workflow. Access a dedicated Reviews section in your sidebar to:

- View PRs awaiting your review
- See PRs you've authored
- Comment on PR discussions
- Receive review request notifications

**Note**: Code review and approval actions still require opening PRs in GitHub.

## Setup

### Enable Reviews

1. Navigate to **Settings > Connected Accounts**
2. Connect your GitHub account if not already connected
3. Toggle on "Enable pull request reviews inside Linear"

Once enabled, the Reviews section appears in your sidebar.

## Display and Grouping

### Default View: Responsibility Grouping

PRs are organized into three categories:
- **To Do**: PRs requiring your review
- **Waiting for others**: PRs you've commented on or authored
- **Approved**: PRs you've approved

### Customization Options

#### Grouping Options
- **Responsibility** (default)
- **Status**: Draft, Open, Merged, Closed
- **Author**: Grouped by PR creator
- **Repository**: Organized by source repository
- **No Grouping**: Flat list view

#### Display Settings
- Show/hide closed PRs
- Show/hide draft PRs
- Toggle PR ID visibility
- Show/hide reviewer avatars

## Viewing Pull Requests

### PR Details View

When selecting a PR, you'll see:
- PR title and description
- Direct link to GitHub PR
- Summary of file changes
- CI/CD check status
- Review status from all reviewers
- Complete comment thread

### Available Information
- **Read-only in Linear**: PR metadata, checks, reviews
- **Interactive**: Comments and reactions
- **Requires GitHub**: Code review, approval, inline comments

## Commenting on PRs

### Comment Features
- View all PR discussion threads
- Add new comments
- Reply to existing comments
- React with emojis
- See suggested changes from comments

### Comment Effects
- Adding a comment moves PR from "To Do" to "Waiting for Others"
- Keeps you engaged in the PR discussion
- Triggers notifications for other participants

## Actions and Limitations

### Available in Linear
- View PR details and status
- Read and write comments
- See review states
- Track CI/CD checks
- Navigate to GitHub

### Requires GitHub
- Approve or request changes
- Comment on specific code lines
- Request additional reviewers
- Merge or close PRs
- Edit PR details

## Notifications

### PR Authors Receive Notifications For:
- All comments on their PRs
- Reviews from other users
- CI/CD check failures
- Status changes

### PR Reviewers Receive Notifications For:
- Review requests
- Comments in threads they're participating in
- Mentions in PR discussions

### Everyone Receives:
- @mention notifications in any PR

## Best Practices

1. **Check Reviews daily**: Stay on top of review requests
2. **Comment in Linear**: Keep discussion centralized for non-code feedback
3. **Use GitHub for code**: Navigate to GitHub for line-by-line code review
4. **Set up filters**: Customize display to focus on priority reviews
5. **Enable notifications**: Stay informed about review requests

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Navigate to Reviews | `G` → `R` |
| Open PR in GitHub | `Cmd/Ctrl + O` |
| Comment | `C` |
| Navigate PRs | `J`/`K` |

## Troubleshooting

### PR State Not Updating

If PR status appears incorrect:
1. Make a minor edit to PR description in GitHub (add/remove a space)
2. This triggers a webhook update
3. If issue persists, contact support@linear.app with PR IDs

### Missing PRs

Ensure:
- GitHub account is properly connected
- You have access to the repository
- Reviews feature is enabled in settings

## FAQ

**Q: Will GitLab be supported?**
A: Yes, GitLab support is planned for the near future.

**Q: Why can't I approve PRs in Linear?**
A: Code review actions require GitHub's interface for security and full functionality.

**Q: Can I filter PRs by repository?**
A: Yes, use the grouping options in display settings.

## Related Topics

- [GitHub Integration](../integrations/github.md)
- [Inbox](inbox.md)
- [Notifications](notifications.md)
- [My Issues](my-issues.md)
