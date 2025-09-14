# Nvim

My neovim config.

## CodeCompanion

### Claude Code

For Claude accounts through anthropic.com, you can use an http adapter with your api key.

For ClaudePro accounts, you need an acp adapter.

Install Zed:

```bash
npm install -g @zed-industries/claude-code-acp
```

Obtain an api key:

```bash
claude setup-token
```

Use direnv to set the token:

```bash
export CLAUDE_CODE_OAUTH_TOKEN="[KEY]"
```
