# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in this Homebrew tap or the rsleep formula, please report it responsibly.

### For Tap Repository Issues

If the vulnerability is in the tap repository itself (e.g., in workflows, scripts, or formula logic):

1. **Do NOT** open a public issue
2. Email the maintainer directly at: github@danielsantana.net
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### For rsleep Application Issues

If the vulnerability is in the rsleep application itself:

Please report it to the [main rsleep repository](https://github.com/danielsan/rsleep) following their security policy.

## Security Considerations for Formula

### SHA256 Checksums

This formula uses SHA256 checksums to verify the integrity of downloaded binaries. We:

- Verify checksums for all release artifacts
- Update checksums with each release
- Use HTTPS for all download URLs

### Automation Security

Our automated formula updates:

- Use GitHub Actions with minimal required permissions
- Store sensitive tokens as encrypted secrets
- Only update from verified release artifacts
- Can be configured to use pull requests for review

### Binary Distribution

The formula installs pre-compiled binaries from GitHub Releases:

- Binaries are built by trusted CI/CD pipelines in the main repository
- All releases are tagged and traceable
- Source code is available for audit
- Binaries are served over HTTPS

## Best Practices for Users

When installing from this tap:

1. **Verify the tap source**
   ```bash
   brew tap-info danielsan/rsleep-brew-tap
   ```

2. **Check formula contents before installation**
   ```bash
   brew cat rsleep
   ```

3. **Verify checksums match GitHub releases**
   - Compare SHA256 in formula with release page
   - Releases page: https://github.com/danielsan/rsleep/releases

4. **Keep Homebrew updated**
   ```bash
   brew update
   brew upgrade
   ```

5. **Review formula updates**
   - Check commit history for formula changes
   - Review pull requests before updates reach your system

## Security Updates

Security updates will be:

1. Prioritized and released as quickly as possible
2. Announced in release notes
3. Tagged with security labels in issues/PRs
4. Communicated via GitHub Security Advisories (for critical issues)

## Acknowledgments

We appreciate security researchers who responsibly disclose vulnerabilities and help keep our users safe.

## Contact

For security concerns:
- Email: github@danielsantana.net
- Repository: https://github.com/danielsan/rsleep-brew-tap

For general issues:
- GitHub Issues: https://github.com/danielsan/rsleep-brew-tap/issues

---

This security policy may be updated periodically. Please check back regularly.

Last updated: 2025-10-31
