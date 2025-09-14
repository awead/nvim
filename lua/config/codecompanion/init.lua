require("codecompanion").setup({
  adapters = {
    -- Configures an acp adapter for use with ClaudePro
    -- I've seen:
    --   require("codecompanion.adapters.acp")
    -- as an alternative.
    acp = {
      claude_code_acp = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN"),
          },
        })
      end
    },
    -- This is too slow to be useful (for now)
    http = {
      codellama = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "codellama", 
          opts = {
          },
          schema = {
            model = {
              default = "codellama",
            },
            think = {
              default = false,
            },
            keep_alive = {
              default = "5m",
            },
          },
        })
      end,
    },
  },
  opts = {
    log_level = "DEBUG",
  },
  strategies = {
    chat = {
      adapter = "claude_code_acp",
    },
  },
})
