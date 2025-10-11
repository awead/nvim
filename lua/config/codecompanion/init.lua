require("codecompanion").setup({
  adapters = {
    http = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = os.getenv("NVIM_CC_ANTHROPIC_API_KEY"),
          },
        })
      end,
      azure_openai = function()
        return require("codecompanion.adapters").extend("azure_openai", {
          env = {
            api_key = os.getenv("NVIM_CC_AZURE_OPENAPI_KEY"),
            endpoint = os.getenv("NVIM_CC_AZURE_OPENAPI_ENDPOINT"),
          },
          schema = {
            model = {
              default = "gpt-5-mini"
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
      adapter = "azure_openai",
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
      adapter = "azure_openai",
    },
  },
})
