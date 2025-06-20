---
title: "API & CLI Tools"
description: "Command-line interface guide and reference"
category: "cli-reference"
type: "api-reference"
tags: ["doppler", "cli"]
date: 2025-06-20
author: "Doppler Team"
version: "1.0"
---

# API & CLI Tools

Complete guide to Linear's API, command-line tools, and automation capabilities for developers and power users.

## 📋 Table of Contents

- [API Overview](#api-overview)
- [Authentication Setup](#authentication-setup)
- [GraphQL Fundamentals](#graphql-fundamentals)
- [Common API Operations](#common-api-operations)
- [CLI Tools](#cli-tools)
- [SDK and Libraries](#sdk-libraries)
- [Webhooks & Events](#webhooks-events)
- [Rate Limits & Best Practices](#rate-limits-best-practices)
- [Troubleshooting](#troubleshooting)

---

## 🔗 API Overview

### What is Linear's API?
Linear provides a comprehensive GraphQL API that offers a single endpoint for all data operations. The API is designed to be efficient, strongly-typed, and self-documenting.

### API Benefits
- **Single endpoint**: All operations through GraphQL
- **Type safety**: Strongly-typed schema with introspection
- **Efficient queries**: Request exactly the data you need
- **Real-time updates**: Subscription support for live data
- **Comprehensive access**: Full CRUD operations on all resources

### API Endpoint
```
https://api.linear.app/graphql
```

### Supported Operations
- **Queries**: Read data (issues, projects, teams, users)
- **Mutations**: Write data (create, update, delete)
- **Subscriptions**: Real-time updates (WebSocket-based)
- **File uploads**: Attachments and images

---

## 🔐 Authentication Setup

### Environment Setup

#### Required Environment Variables
```bash
# Add to your shell profile (.zshrc, .bashrc, etc.)
export LINEAR_API_KEY="lin_api_your_key_here"

# Or create config file
mkdir -p ~/.config/linear
echo '{"apiKey": "lin_api_your_key_here"}' > ~/.config/linear/config.json
```

#### Getting Your API Key
1. Go to **Linear web app** → **Settings** → **Account** → **API**
2. Click **"Create new personal API key"**
3. Give it a descriptive name (e.g., "Development CLI")
4. **Copy immediately** (you won't see it again)
5. Set environment variable or config file

### Authentication Methods

#### 1. Personal API Keys (Recommended for Development)
**Usage in Headers:**
```bash
# For Linear API, use the key directly (no "Bearer" prefix)
Authorization: lin_api_your_key_here
```

**Example cURL Request:**
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ viewer { name email } }"}' \
  https://api.linear.app/graphql
```

#### 2. OAuth Applications (For Third-Party Apps)
**Setup Process:**
1. Go to **Linear Settings** → **API** → **OAuth Applications**
2. Click **"New OAuth Application"**
3. Fill in application details:
   - **Name**: Your application name
   - **Website**: Your app's website URL
   - **Redirect URI**: Post-auth redirect destination
   - **Scopes**: Required permissions

**OAuth Flow:**
```bash
# 1. Redirect user to authorization URL
https://linear.app/oauth/authorize?client_id=YOUR_CLIENT_ID&redirect_uri=YOUR_REDIRECT_URI&response_type=code&scope=read,write

# 2. Exchange authorization code for access token
curl -X POST https://api.linear.app/oauth/token \
  -H "Content-Type: application/json" \
  -d '{
    "client_id": "YOUR_CLIENT_ID",
    "client_secret": "YOUR_CLIENT_SECRET", 
    "code": "AUTHORIZATION_CODE",
    "redirect_uri": "YOUR_REDIRECT_URI",
    "grant_type": "authorization_code"
  }'
```

### API Scopes and Permissions

#### Available Scopes
| Scope | Access Level | Use Cases |
|-------|--------------|-----------|
| `read` | Read user data | View issues, projects, teams |
| `write` | Create and update | Issue management, commenting |
| `admin` | Administrative access | Team management, settings |
| `issues:create` | Create issues | Support integrations |
| `comments:create` | Create comments | Bot interactions |

#### Personal API Key Permissions
Personal API keys inherit the permissions of the user who created them, providing access to all resources the user can access.

---

## 📊 GraphQL Fundamentals

### Understanding GraphQL
GraphQL is a query language that allows you to:
- **Request specific fields**: Get exactly what you need
- **Single request**: Fetch related data in one call
- **Type safe**: Schema-defined data structures
- **Self-documenting**: Introspect the API schema

### Basic Query Structure
```graphql
query {
  field1
  field2 {
    nestedField
  }
}
```

### GraphQL Operations

#### Queries (Read Data)
```graphql
query GetIssues {
  issues(first: 10) {
    nodes {
      id
      title
      state {
        name
      }
    }
  }
}
```

#### Mutations (Write Data)
```graphql
mutation CreateIssue {
  issueCreate(input: {
    title: "New issue"
    teamId: "team-id"
  }) {
    success
    issue {
      id
      identifier
    }
  }
}
```

#### Variables
```graphql
query GetIssuesByTeam($teamId: String!) {
  issues(filter: { team: { id: { eq: $teamId } } }) {
    nodes {
      id
      title
    }
  }
}
```

---

## ⚡ Common API Operations

### 1. User Information
```graphql
query GetCurrentUser {
  viewer {
    id
    name
    email
    avatarUrl
    organization {
      id
      name
      urlKey
    }
  }
}
```

### 2. Team Management
```graphql
# List all teams
query GetTeams {
  teams {
    nodes {
      id
      name
      key
      description
      membersCount
    }
  }
}

# Get specific team details
query GetTeam($teamId: String!) {
  team(id: $teamId) {
    id
    name
    key
    members {
      nodes {
        id
        name
        email
      }
    }
  }
}
```

### 3. Issue Operations

#### Create Issue
```graphql
mutation CreateIssue($input: IssueCreateInput!) {
  issueCreate(input: $input) {
    success
    issue {
      id
      identifier
      title
      url
      state {
        name
      }
      assignee {
        name
      }
    }
  }
}

# Variables:
{
  "input": {
    "title": "Fix authentication bug",
    "description": "Users unable to log in with OAuth",
    "teamId": "team-id-here",
    "priority": 2,
    "assigneeId": "user-id-here"
  }
}
```

#### List Issues
```graphql
query GetIssues($first: Int, $after: String, $filter: IssueFilter) {
  issues(first: $first, after: $after, filter: $filter) {
    nodes {
      id
      identifier
      title
      description
      priority
      state {
        name
        type
      }
      assignee {
        name
        email
      }
      team {
        name
        key
      }
      labels {
        nodes {
          name
          color
        }
      }
      createdAt
      updatedAt
      dueDate
    }
    pageInfo {
      hasNextPage
      endCursor
    }
  }
}
```

#### Update Issue
```graphql
mutation UpdateIssue($id: String!, $input: IssueUpdateInput!) {
  issueUpdate(id: $id, input: $input) {
    success
    issue {
      id
      title
      state {
        name
      }
      assignee {
        name
      }
    }
  }
}

# Variables:
{
  "id": "issue-id-here",
  "input": {
    "title": "Updated issue title",
    "stateId": "state-id-here",
    "assigneeId": "user-id-here",
    "priority": 1
  }
}
```

### 4. Project Operations

#### Create Project
```graphql
mutation CreateProject($input: ProjectCreateInput!) {
  projectCreate(input: $input) {
    success
    project {
      id
      name
      description
      url
      state
      progress
    }
  }
}
```

#### List Projects
```graphql
query GetProjects {
  projects {
    nodes {
      id
      name
      description
      state
      progress
      startDate
      targetDate
      lead {
        name
        email
      }
      teams {
        nodes {
          name
          key
        }
      }
    }
  }
}
```

### 5. Comments and Collaboration
```graphql
# Add comment to issue
mutation CreateComment($input: CommentCreateInput!) {
  commentCreate(input: $input) {
    success
    comment {
      id
      body
      user {
        name
      }
      createdAt
    }
  }
}

# Get issue comments
query GetIssueComments($issueId: String!) {
  issue(id: $issueId) {
    comments {
      nodes {
        id
        body
        user {
          name
          avatarUrl
        }
        createdAt
        updatedAt
      }
    }
  }
}
```

---

## 🖥️ CLI Tools

### Official Linear CLI

#### Installation
```bash
# Install via npm
npm install -g @linear/cli

# Or using yarn
yarn global add @linear/cli
```

#### Authentication
```bash
# Initial setup
linear auth

# Verify authentication
linear me
```

#### Common Commands
```bash
# Create issue
linear issue create --title "Bug report" --team "ENG" --priority high

# List issues
linear issues list --assignee me --state "In Progress"

# Update issue
linear issue update ISSUE-123 --state "Done"

# List teams
linear teams list

# Create project
linear project create --name "Q1 Launch" --team "ENG"
```

### Custom CLI Script (Alternative)

When official CLI has authentication issues, you can use a custom shell script:

#### Script Location
```bash
# Save as ~/linear-cli.sh and make executable
chmod +x ~/linear-cli.sh
```

#### Script Usage
```bash
# Get user info
~/linear-cli.sh user

# List teams
~/linear-cli.sh teams

# Create issue
~/linear-cli.sh create "Issue Title" "Description" "team-id"

# List issues
~/linear-cli.sh list

# List issues by team
~/linear-cli.sh list TEAM-KEY

# Help
~/linear-cli.sh help
```

#### Custom Script Features
- ✅ Uses existing API key configuration
- ✅ Full CRUD operations for issues
- ✅ Team and user management
- ✅ Error handling and validation
- ✅ JSON output formatting
- ✅ Help documentation

#### Example Shell Script
Here's a complete shell script for creating Linear issues:

```bash
#!/bin/bash

# Linear Issue Creation Script
# Usage: ./linear-create-issue.sh "Issue Title" "Issue Description" [team_key]

set -e

# Check if Linear API key is set
if [ -z "$LINEAR_API_KEY" ]; then
    echo "Error: LINEAR_API_KEY environment variable is not set"
    echo "Please run: export LINEAR_API_KEY=\"your_api_key\""
    exit 1
fi

# Default values
TITLE="${1:-Test Issue}"
DESCRIPTION="${2:-Issue created via script}"
TEAM_KEY="${3:-KAYA}"

echo "Creating Linear issue..."
echo "Title: $TITLE"
echo "Description: $DESCRIPTION" 
echo "Team: $TEAM_KEY"
echo ""

# Get team ID from team key
TEAM_QUERY='{"query": "{ teams { nodes { id name key } } }"}'
TEAM_RESPONSE=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d "$TEAM_QUERY" \
  https://api.linear.app/graphql)

TEAM_ID=$(echo "$TEAM_RESPONSE" | jq -r ".data.teams.nodes[] | select(.key == \"$TEAM_KEY\") | .id")

if [ -z "$TEAM_ID" ] || [ "$TEAM_ID" = "null" ]; then
    echo "Error: Could not find team with key '$TEAM_KEY'"
    echo "Available teams:"
    echo "$TEAM_RESPONSE" | jq -r '.data.teams.nodes[] | "  \(.key): \(.name)"'
    exit 1
fi

echo "Found team ID: $TEAM_ID"

# Create the issue
CREATE_QUERY=$(jq -n \
  --arg title "$TITLE" \
  --arg description "$DESCRIPTION" \
  --arg teamId "$TEAM_ID" \
  '{
    query: "mutation { issueCreate(input: { title: $title, description: $description, teamId: $teamId }) { success issue { id identifier title url } } }",
    variables: { title: $title, description: $description, teamId: $teamId }
  }')

RESPONSE=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d "$CREATE_QUERY" \
  https://api.linear.app/graphql)

# Check for errors
if echo "$RESPONSE" | jq -e '.errors' > /dev/null; then
    echo "Error creating issue:"
    echo "$RESPONSE" | jq '.errors'
    exit 1
fi

# Extract issue details
SUCCESS=$(echo "$RESPONSE" | jq -r '.data.issueCreate.success')
if [ "$SUCCESS" = "true" ]; then
    ISSUE_ID=$(echo "$RESPONSE" | jq -r '.data.issueCreate.issue.identifier')
    ISSUE_URL=$(echo "$RESPONSE" | jq -r '.data.issueCreate.issue.url')
    
    echo "✅ Issue created successfully!"
    echo "Issue ID: $ISSUE_ID"
    echo "URL: $ISSUE_URL"
else
    echo "❌ Failed to create issue"
    echo "$RESPONSE" | jq '.data.issueCreate'
fi
```

**Usage Examples**:
```bash
# Basic usage with defaults
./linear-create-issue.sh

# Custom title and description
./linear-create-issue.sh "Fix authentication bug" "Users unable to log in with OAuth"

# Specify team
./linear-create-issue.sh "New feature" "Add dark mode toggle" "ENG"
```

---

## 📚 SDK and Libraries

### JavaScript/TypeScript SDK

#### Installation
```bash
npm install @linear/sdk
```

#### Basic Usage
```typescript
import { LinearClient } from '@linear/sdk'

const linear = new LinearClient({
  apiKey: process.env.LINEAR_API_KEY
})

// Get current user
const me = await linear.viewer
console.log(`Hello ${me.name}!`)

// Create an issue
const issue = await linear.createIssue({
  title: 'New bug report',
  description: 'Detailed description here',
  teamId: 'team-id-here',
  priority: 2
})

console.log(`Created issue: ${issue.identifier}`)

// List issues
const issues = await linear.issues({
  filter: {
    assignee: { id: { eq: me.id } },
    state: { type: { eq: 'started' } }
  }
})

for (const issue of issues.nodes) {
  console.log(`${issue.identifier}: ${issue.title}`)
}
```

#### Advanced SDK Usage
```typescript
// Pagination
const allIssues = []
let hasNextPage = true
let after: string | undefined

while (hasNextPage) {
  const response = await linear.issues({
    first: 50,
    after,
    filter: { team: { key: { eq: 'ENG' } } }
  })
  
  allIssues.push(...response.nodes)
  hasNextPage = response.pageInfo.hasNextPage
  after = response.pageInfo.endCursor
}

// Subscriptions (real-time updates)
const subscription = await linear.issueUpdates()
subscription.on('data', (data) => {
  console.log('Issue updated:', data)
})
```

### Python Integration

#### Basic Python Example
```python
import requests
import json
import os

class LinearClient:
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.endpoint = 'https://api.linear.app/graphql'
        self.headers = {
            'Authorization': api_key,
            'Content-Type': 'application/json'
        }
    
    def query(self, query: str, variables: dict = None):
        payload = {
            'query': query,
            'variables': variables or {}
        }
        
        response = requests.post(
            self.endpoint,
            headers=self.headers,
            data=json.dumps(payload)
        )
        
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception(f'Query failed: {response.status_code}')
    
    def get_user(self):
        query = """
        query {
          viewer {
            id
            name
            email
          }
        }
        """
        return self.query(query)
    
    def create_issue(self, title: str, team_id: str, description: str = None):
        mutation = """
        mutation CreateIssue($input: IssueCreateInput!) {
          issueCreate(input: $input) {
            success
            issue {
              id
              identifier
              title
              url
            }
          }
        }
        """
        
        variables = {
            'input': {
                'title': title,
                'teamId': team_id,
                'description': description
            }
        }
        
        return self.query(mutation, variables)

# Usage
linear = LinearClient(os.environ.get('LINEAR_API_KEY'))
user = linear.get_user()
print(f"Current user: {user['data']['viewer']['name']}")

# Create issue
result = linear.create_issue(
    title="Python API test",
    team_id="team-id-here",
    description="Created via Python SDK"
)
print(f"Created issue: {result['data']['issueCreate']['issue']['identifier']}")
```

---

## 🔗 Webhooks & Events

### Webhook Overview
Linear supports webhooks to notify your application of events in real-time, enabling reactive automation and integration workflows.

### Setting Up Webhooks

#### Configuration Process
1. Go to **Settings** → **API** → **Webhooks**
2. Click **"Create webhook"**
3. **Set endpoint URL**: Your server's webhook receiver
4. **Choose events**: Select which events to receive
5. **Configure authentication**: Optional secret for verification
6. **Test webhook**: Verify delivery works

#### Supported Event Types
| Event | Trigger | Use Cases |
|-------|---------|-----------|
| `Issue` | Created, updated, deleted | Sync external systems |
| `Comment` | Added, updated, deleted | Chat notifications |
| `Project` | Status changes | Progress reporting |
| `Cycle` | Started, completed | Sprint automation |
| `User` | Team changes | Access management |

### Webhook Payload Structure

#### Example Issue Event
```json
{
  "action": "create",
  "type": "Issue",
  "createdAt": "2024-01-01T00:00:00.000Z",
  "data": {
    "id": "issue-id-here",
    "identifier": "ENG-123",
    "title": "New bug report",
    "description": "Issue description",
    "priority": 2,
    "state": {
      "id": "state-id",
      "name": "Todo",
      "type": "unstarted"
    },
    "team": {
      "id": "team-id",
      "name": "Engineering",
      "key": "ENG"
    },
    "assignee": {
      "id": "user-id",
      "name": "John Doe",
      "email": "john@company.com"
    },
    "createdAt": "2024-01-01T00:00:00.000Z",
    "updatedAt": "2024-01-01T00:00:00.000Z",
    "url": "https://linear.app/company/issue/ENG-123"
  }
}
```

### Webhook Security

#### Signature Verification
```javascript
const crypto = require('crypto')

function verifyWebhookSignature(payload, signature, secret) {
  const hmac = crypto.createHmac('sha256', secret)
  hmac.update(payload, 'utf8')
  const expectedSignature = hmac.digest('hex')
  
  return crypto.timingSafeEqual(
    Buffer.from(signature, 'hex'),
    Buffer.from(expectedSignature, 'hex')
  )
}

// Express.js webhook handler
app.post('/webhook', (req, res) => {
  const signature = req.headers['linear-signature']
  const payload = JSON.stringify(req.body)
  
  if (!verifyWebhookSignature(payload, signature, process.env.WEBHOOK_SECRET)) {
    return res.status(401).send('Invalid signature')
  }
  
  // Process webhook event
  const event = req.body
  console.log(`Received ${event.type} event: ${event.action}`)
  
  res.status(200).send('OK')
})
```

### Common Webhook Use Cases

#### 1. Slack Notifications
```javascript
// Send issue updates to Slack
app.post('/webhook/slack', (req, res) => {
  const event = req.body
  
  if (event.type === 'Issue' && event.action === 'create') {
    const issue = event.data
    const message = {
      text: `New issue created: ${issue.identifier}`,
      attachments: [{
        title: issue.title,
        title_link: issue.url,
        fields: [
          { title: 'Team', value: issue.team.name, short: true },
          { title: 'Priority', value: issue.priority, short: true }
        ]
      }]
    }
    
    // Send to Slack webhook URL
    axios.post(process.env.SLACK_WEBHOOK_URL, message)
  }
  
  res.status(200).send('OK')
})
```

#### 2. External System Sync
```javascript
// Sync issues with external CRM
app.post('/webhook/crm-sync', (req, res) => {
  const event = req.body
  
  if (event.type === 'Issue') {
    const issue = event.data
    
    // Update external CRM
    updateCRMTicket({
      externalId: issue.id,
      status: issue.state.name,
      assignee: issue.assignee?.email,
      lastUpdated: issue.updatedAt
    })
  }
  
  res.status(200).send('OK')
})
```

---

## ⚡ Rate Limits & Best Practices

### API Rate Limits

#### Current Limits
- **Request limit**: 2000 requests per hour per API key
- **Complexity limit**: 10000 complexity points per hour
- **Burst limit**: 60 requests per minute
- **Concurrent connections**: 10 simultaneous requests

#### Rate Limit Headers
```bash
# Monitor these response headers
X-RateLimit-Requests-Remaining: 1850
X-RateLimit-Requests-Reset: 1640995200
X-RateLimit-Complexity-Remaining: 8500
X-RateLimit-Complexity-Reset: 1640995200
```

### Best Practices

#### 1. Efficient Queries
```graphql
# Use fragments for repeated fields
fragment IssueFields on Issue {
  id
  identifier
  title
  state { name type }
  assignee { name email }
}

query GetIssues {
  issues(first: 10) {
    nodes {
      ...IssueFields
    }
  }
}
```

#### 2. Pagination Implementation
```javascript
async function getAllIssues(linear) {
  const allIssues = []
  let hasNextPage = true
  let after = null
  
  while (hasNextPage) {
    const response = await linear.issues({
      first: 50,
      after,
      filter: { team: { key: { eq: 'ENG' } } }
    })
    
    allIssues.push(...response.nodes)
    hasNextPage = response.pageInfo.hasNextPage
    after = response.pageInfo.endCursor
    
    // Small delay to respect rate limits
    await new Promise(resolve => setTimeout(resolve, 100))
  }
  
  return allIssues
}
```

#### 3. Error Handling
```javascript
async function makeLinearRequest(query, variables = {}) {
  try {
    const response = await fetch('https://api.linear.app/graphql', {
      method: 'POST',
      headers: {
        'Authorization': process.env.LINEAR_API_KEY,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ query, variables })
    })
    
    if (response.status === 429) {
      // Rate limited - wait and retry
      const resetTime = response.headers.get('X-RateLimit-Requests-Reset')
      const waitTime = (resetTime * 1000) - Date.now()
      await new Promise(resolve => setTimeout(resolve, waitTime))
      return makeLinearRequest(query, variables)
    }
    
    const data = await response.json()
    
    if (data.errors) {
      throw new Error(`GraphQL errors: ${JSON.stringify(data.errors)}`)
    }
    
    return data.data
  } catch (error) {
    console.error('Linear API request failed:', error)
    throw error
  }
}
```

#### 4. Caching Strategies
```javascript
// Simple in-memory cache for teams/users
const cache = new Map()

async function getCachedTeams(linear) {
  if (cache.has('teams')) {
    return cache.get('teams')
  }
  
  const teams = await linear.teams()
  cache.set('teams', teams, { ttl: 300000 }) // 5 minutes
  return teams
}
```

---

## 🔧 Troubleshooting

### Common Issues

#### 1. Authentication Errors
**Error**: "Authentication required"
```bash
# Check API key format
echo $LINEAR_API_KEY
# Should start with "lin_api_"

# Test API key
curl -H "Authorization: $LINEAR_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"query":"{ viewer { name } }"}' \
     https://api.linear.app/graphql
```

**Solutions**:
- Verify API key is correctly set
- Check Authorization header format (no "Bearer" prefix for Linear)
- Ensure API key hasn't been revoked
- Confirm user permissions

#### 2. Rate Limit Issues
**Error**: HTTP 429 "Rate limit exceeded"
```javascript
// Implement exponential backoff
async function withRetry(apiCall, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await apiCall()
    } catch (error) {
      if (error.status === 429 && i < maxRetries - 1) {
        const delay = Math.pow(2, i) * 1000 // Exponential backoff
        await new Promise(resolve => setTimeout(resolve, delay))
        continue
      }
      throw error
    }
  }
}
```

#### 3. GraphQL Schema Errors
**Error**: "Field not found" or "Unknown argument"
```bash
# Check current schema
curl -H "Authorization: $LINEAR_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"query":"{ __schema { queryType { fields { name } } } }"}' \
     https://api.linear.app/graphql
```

**Solutions**:
- Use GraphQL introspection to explore schema
- Check API documentation for field names
- Verify Linear API version compatibility

#### 4. CLI Authentication Issues

**Common Symptoms:**
- CLI returns "Authentication required, not authenticated"
- API calls work but CLI commands fail
- Multiple CLI installations causing conflicts

**Troubleshooting Steps:**

**Step 1: Check for conflicting aliases**
```bash
# Look for problematic aliases
alias | grep -i linear

# Remove problematic alias if found
sed -i '' '/^alias linear="lin"$/d' ~/.zshrc
unalias linear
```

**Step 2: Verify API key works with direct calls**
```bash
# Test API key directly
curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "query { viewer { id name email } }"}' \
  https://api.linear.app/graphql
```

**Step 3: Check for multiple CLI installations**
```bash
# Find all Linear CLI installations
which lin
npm list -g | grep linear
brew list | grep linear

# Clean up conflicting packages
npm uninstall -g @linear/cli linear-cli
brew uninstall linear-linear
```

**Step 4: Reset CLI configuration**
```bash
# Clear CLI configuration
rm -rf ~/.config/linear/

# Reconfigure with fresh API key
mkdir -p ~/.config/linear
echo '{"apiKey": "your-api-key"}' > ~/.config/linear/config.json

# Test configuration
curl -H "Authorization: $(cat ~/.config/linear/config.json | jq -r .apiKey)" \
     -H "Content-Type: application/json" \
     -d '{"query":"{ viewer { name } }"}' \
     https://api.linear.app/graphql
```

**Step 5: Alternative - Use custom shell script**
If CLI continues to have issues, use the custom shell script provided earlier in this document for reliable API access.

### Debug Mode

#### Enable Detailed Logging
```bash
# For Linear CLI
DEBUG=linear:* linear issues list

# For custom scripts
export LINEAR_DEBUG=true
~/linear-cli.sh user
```

#### API Response Debugging
```javascript
// Log full API responses
const debugLinear = async (query, variables) => {
  console.log('Query:', query)
  console.log('Variables:', variables)
  
  const response = await fetch('https://api.linear.app/graphql', {
    method: 'POST',
    headers: {
      'Authorization': process.env.LINEAR_API_KEY,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ query, variables })
  })
  
  const data = await response.json()
  console.log('Response:', JSON.stringify(data, null, 2))
  return data
}
```

### Performance Optimization

#### Query Optimization
```graphql
# Avoid over-fetching
query GetIssuesList {
  issues(first: 10) {
    nodes {
      id
      identifier
      title
      # Only request fields you need
    }
  }
}

# Use specific filters
query GetMyActiveIssues {
  issues(
    filter: {
      assignee: { id: { eq: "user-id" } }
      state: { type: { eq: "started" } }
    }
  ) {
    nodes {
      id
      title
    }
  }
}
```

## 📚 Resources

### Documentation and Tools
- **GraphQL Playground**: [Linear API Explorer](https://studio.apollographql.com/public/Linear-API)
- **Official Documentation**: [developers.linear.app](https://developers.linear.app)
- **SDK Documentation**: [GitHub - Linear SDK](https://github.com/linear/linear)
- **Community Examples**: [Linear Examples Repository](https://github.com/linear/linear/tree/master/examples)
- **Status Page**: [status.linear.app](https://status.linear.app)

### Development Resources
- **TypeScript Types**: Full type definitions included in SDK
- **GraphQL Schema**: Available via introspection
- **Postman Collection**: Import Linear API endpoints
- **VSCode Extension**: GraphQL syntax highlighting and validation

## 🔗 Related Guides

- **[Integrations](integrations.md)** - Connect Linear with external tools
- **[Workspace Management](workspace-management.md)** - Admin settings and permissions
- **[Issues Management](issues-management.md)** - Work item organization and tracking
- **[Projects & Cycles](projects-cycles.md)** - Planning and project management
- **[Getting Started](getting-started.md)** - Basic Linear setup and concepts

---

*Linear's API and CLI tools unlock powerful automation and integration possibilities. Master these tools to build custom workflows, automate repetitive tasks, and integrate Linear seamlessly into your development stack.*