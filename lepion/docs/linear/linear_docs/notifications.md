---
title: "Notifications"
description: "Linear notifications keep you informed about important updates across your workspace. All notifications are automatically sent to your Linear inbox, with options to configure additional channels:"
category: "general"
type: "guide"
tags: ["doppler"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# Notifications

Receive alerts on important updates to desktop, mobile, Slack, or email.

## Overview

Linear notifications keep you informed about important updates across your workspace. All notifications are automatically sent to your Linear inbox, with options to configure additional channels:

- Desktop push notifications
- Mobile notifications
- Personal Slack notifications
- Email digests

## Configure Notifications

Navigate to **Settings > Account > Notifications** to manage your notification preferences.

### Notification Methods

Each notification method is indicated by a colored dot:
- **Green dot**: Method is enabled
- **Gray dot**: Method is disabled

Available methods:
- **Desktop**: Real-time push notifications to your computer
- **Mobile**: Real-time notifications to your mobile device
- **Email**: Digest summaries of unread notifications
- **Slack**: Real-time notifications to your personal Slack

### Enabling Notifications

1. Click on a notification method
2. Toggle the switch to enable/disable
3. Select specific notification types you want to receive

**Note**: Notifications are grouped by category. For example, enabling "status changes" includes notifications for status, priority, and blocking relationship changes.

## Notification Timing

### Real-time Notifications
- Desktop, mobile, and Slack notifications are sent immediately

### Email Digests
- Sent with time delays based on urgency
- Only sent if you haven't read the notification in your Linear inbox
- Configurable options:
  - **Immediate delivery**: For urgent issues or SLA breaches assigned to you
  - **Work hours delivery**: Delay low-priority emails outside 8 AM - 6 PM (your timezone)

## Issue Subscriptions

### Automatic Subscriptions

You're automatically subscribed to issues when you:
- Create them
- Are assigned to them
- Are @mentioned in comments or descriptions
- Manually subscribe via the Activity section

### Managing Subscriptions

- **Subscribe**: Press `Shift + S` on an issue
- **Unsubscribe**: Press `Cmd/Ctrl + Shift + S`
- **View all subscriptions**: Go to **My Issues > Subscribed**

## Troubleshooting

### Multiple Tabs/Apps
If using Linear in multiple tabs or both desktop and web apps simultaneously, notifications may only appear in one location. Use only one instance at a time.

### Browser-Specific Issues

#### Safari
Safari doesn't support Push API for desktop notifications. Consider using a different browser for desktop notifications.

#### Chrome
If notifications aren't working:
1. Go to `chrome://settings/content/notifications`
2. Check Linear's notification permissions
3. Re-enable in Linear settings

### macOS Settings
Ensure notifications are enabled in macOS System Preferences:
1. Allow notifications for Linear
2. Enable badge app icon if desired

### Status Change Notifications
When "Status changes" is selected, you'll be notified about:
- Issue completions
- Issue cancellations
- Other status transitions

For notifications about specific status entries, consider using [view subscriptions](../views-navigation/custom-views.md#view-subscriptions).

## Best Practices

- Configure email digest timing based on your work schedule
- Use desktop notifications for urgent updates
- Set up Slack notifications if you spend most of your time in Slack
- Regularly review and clean up issue subscriptions
- Consider using view subscriptions for team-wide monitoring

## Related Topics

- [Inbox](inbox.md)
- [My Issues](my-issues.md)
- [Custom Views](../views-navigation/custom-views.md)
- [Account Preferences](account-preferences.md)
