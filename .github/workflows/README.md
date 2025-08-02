# Claude Code GitHub Integration Setup

This repository has been configured with the Claude Code GitHub Integration, which allows automated code changes and PR reviews using Claude AI.

## How it Works

1. **For Issues**: Create an issue with the `claude-code` label, and Claude will automatically process it and create a PR with the requested changes.

2. **For PR Reviews**: Comment on a PR starting with `Review:` followed by your feedback, and Claude will review and suggest changes.

## Required Setup

### 1. GitHub Secrets

You need to configure the following secrets in your GitHub repository settings:

#### Option A: Using AWS Bedrock (Recommended)
- `BEDROCK_AWS_ACCESS_KEY_ID`: Your AWS access key ID with Bedrock permissions
- `BEDROCK_AWS_SECRET_ACCESS_KEY`: Your AWS secret access key

#### Option B: Using Anthropic API Directly
- `ANTHROPIC_API_KEY`: Your Anthropic API key

### 2. Configuration

The workflow is configured in `.github/workflows/claude-code.yml`. By default, it uses AWS Bedrock. To switch to Anthropic API:

1. Comment out the Bedrock configuration lines
2. Uncomment the Anthropic API configuration lines

## Usage

### Creating Issues for Claude

1. Create a new issue in your repository
2. Add the `claude-code` label
3. Describe what you want Claude to implement
4. Claude will automatically process the issue and create a PR

### Getting PR Reviews

1. Open a pull request
2. Comment starting with `Review:` followed by specific feedback
3. Claude will analyze the PR and provide suggestions

## Troubleshooting

- Ensure all required secrets are properly configured
- Check the Actions tab for workflow run logs
- Verify the `claude-code` label exists in your repository

## More Information

For more details, visit: https://github.com/nicholaslee119/claude-code-github-action