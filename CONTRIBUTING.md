# Contributing to rsleep-brew-tap

Thank you for your interest in contributing to the rsleep Homebrew tap! This document provides guidelines for contributing to this repository.

## How to Contribute

### Reporting Issues

If you encounter a problem with the formula:

1. Check if the issue already exists in the [Issues](https://github.com/danielsan/rsleep-brew-tap/issues) section
2. If not, create a new issue with:
   - A clear, descriptive title
   - Your operating system and version
   - Homebrew version (`brew --version`)
   - Steps to reproduce the issue
   - Expected behavior
   - Actual behavior
   - Any error messages or logs

### Suggesting Enhancements

We welcome suggestions for improvements! Please:

1. Check existing issues and pull requests
2. Create a new issue describing your enhancement
3. Explain why this enhancement would be useful
4. Provide examples if applicable

### Submitting Changes

#### Prerequisites

- A GitHub account
- Git installed on your system
- Homebrew installed on your system
- Basic knowledge of Ruby (for formula editing)

#### Process

1. **Fork the repository**
   ```bash
   # Fork via GitHub UI, then clone your fork
   git clone https://github.com/YOUR-USERNAME/rsleep-brew-tap.git
   cd rsleep-brew-tap
   ```

2. **Create a branch**
   ```bash
   git checkout -b your-feature-branch
   ```

3. **Make your changes**
   - Edit the formula in `Formula/rsleep.rb`
   - Update documentation if needed
   - Follow the existing code style

4. **Test your changes**
   ```bash
   # Test the formula locally
   brew install --build-from-source Formula/rsleep.rb
   brew test Formula/rsleep.rb
   
   # Run the audit
   brew audit --strict --online Formula/rsleep.rb
   
   # Verify the installation works
   rsleep --help
   rsleep 1
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Brief description of your changes"
   ```
   
   Write clear, concise commit messages. For example:
   - `Update rsleep to version 0.2.0`
   - `Fix SHA256 checksum for Linux x86_64`
   - `Add support for Linux ARM64`

6. **Push to your fork**
   ```bash
   git push origin your-feature-branch
   ```

7. **Create a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your fork and branch
   - Fill in the PR template with:
     - Description of changes
     - Motivation for changes
     - Testing performed
     - Related issues (if any)

### Formula Guidelines

When updating the formula:

1. **Version Updates**
   - Update the `version` field
   - Update all URLs to point to the new release
   - Update all SHA256 checksums
   - Test on all supported platforms if possible

2. **Code Style**
   - Use 2-space indentation
   - Follow [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) guidelines
   - Keep the formula simple and maintainable

3. **Testing**
   - Ensure the formula passes `brew audit --strict --online`
   - Test installation on macOS (Intel and Apple Silicon if possible)
   - Test installation on Linux x86_64
   - Verify the test block works correctly

4. **Documentation**
   - Update README.md if installation instructions change
   - Update AUTOMATION-GUIDE.md if automation workflow changes
   - Add comments for complex logic in the formula

### Automated Updates

This tap is designed to be automatically updated when new rsleep releases are published. If you're maintaining the main rsleep repository:

1. Follow the [AUTOMATION-GUIDE.md](AUTOMATION-GUIDE.md) to set up automation
2. Ensure release artifacts follow the naming convention
3. Test the automation workflow before relying on it

### Code Review Process

1. A maintainer will review your PR
2. They may request changes or ask questions
3. Address any feedback by pushing new commits to your branch
4. Once approved, a maintainer will merge your PR

### Community Guidelines

- Be respectful and constructive
- Help others learn and improve
- Focus on the issue, not the person
- Assume good intentions
- Follow the [GitHub Community Guidelines](https://docs.github.com/en/site-policy/github-terms/github-community-guidelines)

## Development Setup

### Local Testing Environment

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap your local repository
brew tap-new danielsan/rsleep-brew-tap
cd $(brew --repository)/Library/Taps/danielsan/homebrew-rsleep-brew-tap

# Copy your formula
cp /path/to/your/rsleep-brew-tap/Formula/rsleep.rb Formula/

# Test the formula
brew install --build-from-source rsleep
brew test rsleep
```

### Useful Commands

```bash
# Audit the formula
brew audit --strict --online Formula/rsleep.rb

# Check formula style
brew style Formula/rsleep.rb

# Install from local formula
brew install --build-from-source Formula/rsleep.rb

# Reinstall to test updates
brew reinstall --build-from-source Formula/rsleep.rb

# Run formula tests
brew test Formula/rsleep.rb

# Uninstall
brew uninstall rsleep

# View formula info
brew info rsleep
```

## Questions?

If you have questions about contributing:

1. Check the [README.md](README.md)
2. Review existing issues and PRs
3. Check [Homebrew documentation](https://docs.brew.sh/)
4. Open a new issue with your question

Thank you for contributing to rsleep-brew-tap!
