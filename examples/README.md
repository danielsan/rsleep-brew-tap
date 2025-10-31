# Examples Directory

This directory contains example files and templates for the rsleep Homebrew tap.

## Files

### update-homebrew-tap.yml

This is a GitHub Actions workflow file that should be added to the main rsleep repository to enable automated formula updates.

**Installation Location:** `.github/workflows/update-homebrew-tap.yml` in the main rsleep repository

**Purpose:** Automatically updates the Homebrew tap formula when a new release is published.

**Setup Instructions:** See [AUTOMATION-GUIDE.md](../AUTOMATION-GUIDE.md) for detailed setup instructions.

**Features:**
- Automatically triggers on new releases
- Downloads release artifacts
- Computes SHA256 checksums
- Updates formula with new version, URLs, and checksums
- Can be configured for direct push or pull request workflow

## Usage

To use these examples:

1. Copy the workflow file to the appropriate location in the main rsleep repository
2. Follow the setup instructions in AUTOMATION-GUIDE.md
3. Configure GitHub secrets as needed
4. Test the workflow with a manual trigger before relying on automatic updates

## Testing

Before deploying automation:

1. Create a test release in the main repository
2. Manually trigger the workflow
3. Verify the tap repository is updated correctly
4. Test the updated formula: `brew install --build-from-source danielsan/rsleep-brew-tap/rsleep`
5. Verify the installation works as expected

## Customization

The workflow can be customized to:
- Use different branch names
- Require pull request reviews
- Send notifications on success/failure
- Run additional tests before updating
- Support additional platforms

See the workflow comments for customization options.
