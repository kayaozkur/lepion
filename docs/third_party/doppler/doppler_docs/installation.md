---
title: "Doppler CLI Installation Guide"
description: "Complete guide for installing the Doppler CLI across different platforms"
category: "installation"
type: "guide"
tags: ["doppler", "cli", "installation", "setup"]
date: 2024-06-19
author: "Doppler Team"
version: "1.0"
---

# Doppler CLI Installation Guide

## System Requirements

- **Operating Systems**: macOS, Windows, Linux (all major distributions)
- **Prerequisites**: 
  - Internet connection for downloading
  - Administrative privileges for installation
  - GnuPG (for some platforms)

## Installation Methods

### macOS

#### Using Homebrew (Recommended)
```bash
# Install GnuPG (prerequisite)
brew install gnupg

# Install Doppler CLI
brew install dopplerhq/cli/doppler
```

#### Manual Installation
```bash
# Download and install the latest release
curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh | sh
```

### Windows

#### Using Windows Package Manager (winget) - Recommended
```bash
winget install doppler.doppler
```

#### Using Scoop
```bash
# Add Doppler bucket
scoop bucket add doppler https://github.com/DopplerHQ/scoop-doppler.git

# Install Doppler
scoop install doppler
```

#### Using PowerShell
```powershell
# Run as Administrator
iwr -useb https://cli.doppler.com/install.ps1 | iex
```

### Linux

#### Debian/Ubuntu (apt)
```bash
# Install prerequisites
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# Add Doppler's GPG key
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg

# Add repository
echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list

# Install Doppler
sudo apt-get update && sudo apt-get install doppler
```

#### RedHat/CentOS/Fedora (yum/dnf)
```bash
# Add Doppler's GPG key
sudo rpm --import 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key'

# Add repository
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/config.rpm.txt' | sudo tee /etc/yum.repos.d/doppler-cli.repo

# Install Doppler
sudo yum install doppler

# Or for Fedora/newer systems
sudo dnf install doppler
```

#### Alpine Linux
```bash
# Add Doppler's signing key
wget -q -t3 'https://packages.doppler.com/public/cli/rsa.8004D9FF50437357.key' -O /etc/apk/keys/[email protected]

# Add repository
echo 'https://packages.doppler.com/public/cli/alpine/any-version/main' | tee -a /etc/apk/repositories

# Install Doppler
apk add doppler
```

#### Arch Linux (AUR)
```bash
# Using yay
yay -S doppler-cli

# Using paru
paru -S doppler-cli
```

### Docker

```dockerfile
# Add to your Dockerfile
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
    apt-get update && apt-get install -y doppler
```

## Verification

After installation, verify Doppler is installed correctly:

```bash
# Check version
doppler --version

# View help
doppler --help
```

## Post-Installation Setup

### 1. Authenticate the CLI
```bash
doppler login
```

### 2. Configure Shell Completion (Optional)

#### Bash
```bash
# Add to ~/.bashrc or ~/.bash_profile
source <(doppler completion bash)
```

#### Zsh
```bash
# Add to ~/.zshrc
source <(doppler completion zsh)
```

#### Fish
```bash
# Add to ~/.config/fish/config.fish
doppler completion fish | source
```

### 3. Configure Global Settings (Optional)
```bash
# Set default output format
doppler configure set output json

# Enable analytics (optional)
doppler configure set analytics true
```

## Updating Doppler CLI

### macOS (Homebrew)
```bash
brew upgrade doppler
```

### Windows (winget)
```bash
winget upgrade doppler.doppler
```

### Linux (apt)
```bash
sudo apt-get update && sudo apt-get upgrade doppler
```

### Manual Update
```bash
doppler update
```

## Troubleshooting Installation

### Common Issues

1. **Permission Denied**
   - Ensure you're using `sudo` where required
   - Check file permissions in installation directory

2. **GPG Key Errors**
   - Ensure GnuPG is installed
   - Try downloading the key manually

3. **Repository Not Found**
   - Verify your distribution is supported
   - Check network connectivity

4. **Command Not Found**
   - Add Doppler to your PATH
   - Restart your terminal session

### Getting Help

- Check installation logs: `doppler configure get install_log`
- Visit [Doppler Community](https://community.doppler.com)
- Contact support: [support.doppler.com](https://support.doppler.com)

## Uninstallation

### macOS (Homebrew)
```bash
brew uninstall doppler
```

### Windows (winget)
```bash
winget uninstall doppler.doppler
```

### Linux (apt)
```bash
sudo apt-get remove doppler
```

### Manual Removal
```bash
# Remove binary
sudo rm /usr/local/bin/doppler

# Remove configuration
rm -rf ~/.doppler
```