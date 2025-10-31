# rsleep-brew-tap

This repository is a Homebrew tap containing a formula for [rsleep](https://github.com/danielsan/rsleep), a prettier version of the sleep command that shows you something is going on.

## Installation

To install rsleep via Homebrew:

```bash
# Tap this repository
brew tap danielsan/rsleep-brew-tap

# Install rsleep
brew install rsleep
```

Or in a single command:

```bash
brew install danielsan/rsleep-brew-tap/rsleep
```

## Usage

After installation, you can use rsleep just like the regular sleep command:

```bash
rsleep 5s    # Sleep for 5 seconds with a progress indicator
rsleep 2m    # Sleep for 2 minutes
rsleep 1h    # Sleep for 1 hour
```

## Updating the Formula

### Manual Updates

The formula uses prebuilt release archives from GitHub Releases for rsleep. When a new version is released:

1. Download the release artifacts for each platform
2. Compute SHA256 checksums for each tarball
3. Update `Formula/rsleep.rb` with the new version, URLs, and checksums
4. Test the formula locally: `brew install --build-from-source Formula/rsleep.rb`
5. Submit a pull request

### Automated Updates

This tap is designed to be automatically updated when new releases are published in the main rsleep repository. The automation workflow in the main repository:

1. Detects new releases
2. Downloads release artifacts
3. Computes SHA256 checksums
4. Updates the formula in this repository
5. Opens a pull request or commits directly

See the [main rsleep repository](https://github.com/danielsan/rsleep) for details on the release automation workflow.

## Formula Details

The formula supports:
- **macOS**: x86_64 (Intel) and aarch64 (Apple Silicon)
- **Linux**: x86_64

The formula includes:
- Proper version tracking
- Livecheck support for automatic update detection
- Platform-specific binary installation
- Basic functional tests

## Contributing

Contributions are welcome! Please:

1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Test the formula locally
5. Submit a pull request

## CI/CD

This repository includes GitHub Actions workflows for:
- Linting formulas on pull requests
- Running `brew audit` for formula validation

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.

The rsleep software itself is also MIT licensed. See the [main repository](https://github.com/danielsan/rsleep) for details.
