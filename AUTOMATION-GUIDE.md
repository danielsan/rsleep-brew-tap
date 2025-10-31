# Automation Guide for rsleep Homebrew Tap

This guide explains how to set up automated formula updates in the main rsleep repository.

## Overview

When a new release is created in the main rsleep repository, a GitHub Actions workflow can automatically update the Homebrew formula in this tap repository with the correct version, URLs, and SHA256 checksums.

## Setup Instructions

### 1. Create a Personal Access Token (PAT)

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate a new token with the following permissions:
   - `repo` (full control of private repositories)
   - `workflow` (update GitHub Action workflows)
3. Copy the token value

### 2. Add the PAT as a Secret in the Main Repository

1. Go to the main rsleep repository settings
2. Navigate to Secrets and variables → Actions
3. Create a new repository secret named `TAP_REPO_TOKEN`
4. Paste the PAT token value

### 3. Add the Workflow to the Main Repository

Create a file `.github/workflows/update-homebrew-tap.yml` in the main rsleep repository with the following content:

```yaml
name: Update Homebrew Tap

on:
  release:
    types: [published]
  workflow_dispatch:
    inputs:
      version:
        description: 'Version to update (e.g., v0.1.0)'
        required: true
        type: string

permissions:
  contents: read

jobs:
  update-tap:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout tap repository
        uses: actions/checkout@v4
        with:
          repository: danielsan/rsleep-brew-tap
          token: ${{ secrets.TAP_REPO_TOKEN }}
          path: tap

      - name: Determine version
        id: version
        run: |
          if [ -n "${{ inputs.version }}" ]; then
            VERSION="${{ inputs.version }}"
          else
            VERSION="${{ github.event.release.tag_name }}"
          fi
          echo "version=${VERSION}" >> $GITHUB_OUTPUT
          echo "version_no_v=${VERSION#v}" >> $GITHUB_OUTPUT

      - name: Download release assets and compute checksums
        id: checksums
        run: |
          VERSION="${{ steps.version.outputs.version }}"
          
          # Download and compute SHA256 for x86_64 macOS
          curl -L -o x86_64-darwin.tar.gz \
            "https://github.com/danielsan/rsleep/releases/download/${VERSION}/rsleep-${VERSION}-x86_64-apple-darwin.tar.gz"
          SHA256_X86_64_DARWIN=$(sha256sum x86_64-darwin.tar.gz | awk '{print $1}')
          echo "sha256_x86_64_darwin=${SHA256_X86_64_DARWIN}" >> $GITHUB_OUTPUT
          
          # Download and compute SHA256 for aarch64 macOS
          curl -L -o aarch64-darwin.tar.gz \
            "https://github.com/danielsan/rsleep/releases/download/${VERSION}/rsleep-${VERSION}-aarch64-apple-darwin.tar.gz"
          SHA256_AARCH64_DARWIN=$(sha256sum aarch64-darwin.tar.gz | awk '{print $1}')
          echo "sha256_aarch64_darwin=${SHA256_AARCH64_DARWIN}" >> $GITHUB_OUTPUT
          
          # Download and compute SHA256 for x86_64 Linux
          curl -L -o x86_64-linux.tar.gz \
            "https://github.com/danielsan/rsleep/releases/download/${VERSION}/rsleep-${VERSION}-x86_64-unknown-linux-gnu.tar.gz"
          SHA256_X86_64_LINUX=$(sha256sum x86_64-linux.tar.gz | awk '{print $1}')
          echo "sha256_x86_64_linux=${SHA256_X86_64_LINUX}" >> $GITHUB_OUTPUT

      - name: Update formula
        run: |
          VERSION="${{ steps.version.outputs.version }}"
          VERSION_NO_V="${{ steps.version.outputs.version_no_v }}"
          SHA256_X86_64_DARWIN="${{ steps.checksums.outputs.sha256_x86_64_darwin }}"
          SHA256_AARCH64_DARWIN="${{ steps.checksums.outputs.sha256_aarch64_darwin }}"
          SHA256_X86_64_LINUX="${{ steps.checksums.outputs.sha256_x86_64_linux }}"
          
          cd tap/Formula
          
          # Update version
          sed -i "s/version \".*\"/version \"${VERSION_NO_V}\"/" rsleep.rb
          
          # Update x86_64 macOS URL and SHA256
          sed -i "s|https://github.com/danielsan/rsleep/releases/download/v[0-9.]*/rsleep-v[0-9.]*-x86_64-apple-darwin.tar.gz|https://github.com/danielsan/rsleep/releases/download/${VERSION}/rsleep-${VERSION}-x86_64-apple-darwin.tar.gz|" rsleep.rb
          sed -i "/x86_64-apple-darwin.tar.gz/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA256_X86_64_DARWIN}\"/" rsleep.rb
          
          # Update aarch64 macOS URL and SHA256
          sed -i "s|https://github.com/danielsan/rsleep/releases/download/v[0-9.]*/rsleep-v[0-9.]*-aarch64-apple-darwin.tar.gz|https://github.com/danielsan/rsleep/releases/download/${VERSION}/rsleep-${VERSION}-aarch64-apple-darwin.tar.gz|" rsleep.rb
          sed -i "/aarch64-apple-darwin.tar.gz/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA256_AARCH64_DARWIN}\"/" rsleep.rb
          
          # Update x86_64 Linux URL and SHA256
          sed -i "s|https://github.com/danielsan/rsleep/releases/download/v[0-9.]*/rsleep-v[0-9.]*-x86_64-unknown-linux-gnu.tar.gz|https://github.com/danielsan/rsleep/releases/download/${VERSION}/rsleep-${VERSION}-x86_64-unknown-linux-gnu.tar.gz|" rsleep.rb
          sed -i "/x86_64-unknown-linux-gnu.tar.gz/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA256_X86_64_LINUX}\"/" rsleep.rb

      - name: Commit and push changes
        run: |
          cd tap
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add Formula/rsleep.rb
          git commit -m "Update rsleep formula to ${{ steps.version.outputs.version }}"
          git push

      - name: Create pull request (alternative to direct push)
        if: false  # Set to true if you prefer PR-based updates
        uses: peter-evans/create-pull-request@v6
        with:
          token: ${{ secrets.TAP_REPO_TOKEN }}
          path: tap
          commit-message: "Update rsleep formula to ${{ steps.version.outputs.version }}"
          title: "Update rsleep formula to ${{ steps.version.outputs.version }}"
          body: |
            Automated update of rsleep formula to version ${{ steps.version.outputs.version }}.
            
            This PR updates:
            - Formula version
            - Release URLs for all platforms
            - SHA256 checksums for all platforms
            
            **Checksums:**
            - x86_64 macOS: ${{ steps.checksums.outputs.sha256_x86_64_darwin }}
            - aarch64 macOS: ${{ steps.checksums.outputs.sha256_aarch64_darwin }}
            - x86_64 Linux: ${{ steps.checksums.outputs.sha256_x86_64_linux }}
          branch: update-formula-${{ steps.version.outputs.version }}
          delete-branch: true
```

## Usage

### Automatic Updates

Once the workflow is set up, it will automatically run when:
- A new release is published in the main rsleep repository
- The workflow is manually triggered with a specific version

### Manual Trigger

To manually trigger the workflow:

1. Go to the Actions tab in the main rsleep repository
2. Select "Update Homebrew Tap" workflow
3. Click "Run workflow"
4. Enter the version (e.g., `v0.1.0`)
5. Click "Run workflow"

## Choosing Between Direct Push and Pull Requests

The workflow can be configured to either:

1. **Direct Push** (default): Automatically commits and pushes changes directly to the main branch
   - Faster updates
   - Suitable for trusted automated updates
   - Used automatically when triggered by release events

2. **Pull Request**: Creates a PR for review before merging
   - Allows manual review of changes
   - More suitable for critical repositories
   - Can be enabled by setting `use_pull_request` to `true` when manually triggering the workflow

## Troubleshooting

### Permission Errors

If you encounter permission errors:
- Verify the PAT has the correct permissions
- Check that the secret is named `TAP_REPO_TOKEN`
- Ensure the token hasn't expired

### Formula Update Failures

If the formula update fails:
- Check that the release assets exist with the expected naming convention
- Verify the URLs are accessible
- Review the workflow logs for specific error messages

### SHA256 Mismatch

If checksums don't match:
- The workflow always downloads fresh copies from the release
- Wait a few minutes after release creation for assets to be fully uploaded
- Manually verify the checksums match the GitHub release assets

## Security Considerations

- Store the PAT securely as a GitHub secret
- Use the minimum required permissions for the PAT
- Regularly rotate the PAT (recommended: every 90 days)
- Consider using GitHub App authentication for production use
- Review automated commits before they reach users

## Testing

To test the automation:

1. Create a test release in the main repository
2. Monitor the workflow execution
3. Verify the tap repository is updated correctly
4. Test the updated formula: `brew install --build-from-source danielsan/rsleep-brew-tap/rsleep`
