---
title: "Doppler Documentation"
description: "Comprehensive documentation for Doppler, the SecretOps platform for managing application secrets and configuration"
category: "documentation"
type: "index"
tags: ["doppler", "secrets", "documentation", "secops"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler Documentation

Comprehensive documentation for Doppler, the SecretOps platform for managing application secrets and configuration.

## 📚 Documentation Structure

### Core Concepts
- **[Overview](./core-concepts/overview.md)** - Introduction to Doppler and its key features
- **[Getting Started](./core-concepts/getting-started.md)** - Quick start guide for new users
- **[Project Organization](./core-concepts/project-organization.md)** - Best practices for structuring projects and environments
- **[Access Control](./core-concepts/access-control.md)** - Understanding permissions and security

### CLI Setup
- **[Installation](./cli-setup/installation.md)** - Platform-specific installation instructions
- **[CLI Commands](./cli-setup/cli-commands.md)** - Complete command reference
- **[TUI Guide](./cli-setup/tui-guide.md)** - Interactive terminal interface guide
- **[Advanced Features](./cli-setup/advanced-features.md)** - Auto-restart, multiple workplaces, and more

### Secrets Management
- **[Secrets Basics](./secrets-management/secrets-basics.md)** - Understanding secrets and naming conventions
- **[Accessing Secrets](./secrets-management/accessing-secrets.md)** - Methods for retrieving secrets in applications
- **[Importing Secrets](./secrets-management/importing-secrets.md)** - Migration guides from other systems
- **[Secret Injection](./secrets-management/secret-injection.md)** - Template-based configuration generation

## 🚀 Quick Start

```bash
# Install Doppler CLI
brew install dopplerhq/cli/doppler  # macOS
# or
curl -Ls https://cli.doppler.com/install.sh | sh  # Linux

# Authenticate
doppler login

# Setup your project
doppler setup

# Run your application with secrets
doppler run -- npm start
```

## 🔑 Key Features

- **Centralized Secrets Management** - Single source of truth for all environments
- **Version Control** - Track changes and rollback when needed
- **Access Control** - Fine-grained permissions per project and environment
- **Real-time Sync** - Automatic secret updates across all integrations
- **Audit Logging** - Complete visibility into who changed what and when
- **Multiple Integrations** - Works with Docker, Kubernetes, CI/CD, and more

## 📖 Common Use Cases

### Local Development
```bash
doppler run -- npm run dev
```

### Docker Integration
```dockerfile
RUN doppler run -- npm start
```

### CI/CD Pipeline
```yaml
env:
  DOPPLER_TOKEN: ${{ secrets.DOPPLER_TOKEN }}
run: doppler run -- npm test
```

### Kubernetes Deployment
```bash
kubectl apply -f <(doppler secrets substitute k8s-manifest.yaml)
```

## 🛠️ Advanced Topics

- **Multi-Workplace Management** - Working with multiple organizations
- **Automatic Restart** - Auto-reload on secret changes
- **Template Injection** - Dynamic configuration file generation
- **Secret Referencing** - Cross-project and cross-environment references

## 📞 Support

- **Documentation**: [docs.doppler.com](https://docs.doppler.com)
- **Community Forum**: [community.doppler.com](https://community.doppler.com)
- **Support Portal**: [support.doppler.com](https://support.doppler.com)
- **Status Page**: [status.doppler.com](https://status.doppler.com)

## 🔄 Migration Guides

Migrating from:
- AWS Secrets Manager
- HashiCorp Vault
- Heroku Config Vars
- Kubernetes Secrets
- .env files

See [Importing Secrets](./secrets-management/importing-secrets.md) for detailed migration instructions.

---

*This documentation was extracted and compiled from official Doppler documentation sources.*