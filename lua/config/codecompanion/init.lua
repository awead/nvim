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
            -- ANTHROPIC_API_KEY = os.getenv("NVIM_CC_ANTHROPIC_API_KEY"),
          },
        })
      end
    },
    http = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = os.getenv("NVIM_CC_ANTHROPIC_API_KEY"),
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
      adapter = "anthropic",
      keymaps = {
        options = {
          modes = { n = "?" },
          callback = function()
            require("which-key").show({ global = false })
          end,
          description = "Codecompanion Keymaps",
          hide = true,
        },
      },
    },
    inline = {
      adapter = "anthropic",
    },
  },
})
