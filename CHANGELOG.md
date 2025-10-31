# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive README.md with installation, usage, and update instructions
- LICENSE file (MIT License)
- AUTOMATION-GUIDE.md with detailed instructions for automating formula updates
- CONTRIBUTING.md with contribution guidelines
- SECURITY.md with security policy and vulnerability reporting procedures
- CHANGELOG.md to track changes
- Example workflow file for main rsleep repository automation
- Enhanced CI workflow with separate test jobs for macOS and Linux
- Livecheck support in formula for automatic update detection
- Improved test block with functional tests
- Caveats section in formula with usage instructions

### Changed
- Updated formula to version 0.1.0 with actual release URLs and SHA256 checksums
- Replaced placeholder URLs and checksums with v0.1.0 release data
- Improved CI workflow to run on both PRs and pushes to main branch
- Enhanced formula structure with better platform detection
- Updated README with detailed documentation

### Fixed
- Formula now uses correct release URLs from GitHub releases
- SHA256 checksums now match actual release artifacts
- Formula structure now follows Homebrew best practices

## [0.0.0] - Initial State

### Initial Setup
- Basic formula structure with placeholder URLs
- Basic README
- Simple CI workflow for formula linting
- .gitignore file

[Unreleased]: https://github.com/danielsan/rsleep-brew-tap/compare/v0.0.0...HEAD
[0.0.0]: https://github.com/danielsan/rsleep-brew-tap/releases/tag/v0.0.0
