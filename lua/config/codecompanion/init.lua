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
  prompt_library = {
    ["Summarize"] = {
      strategy = "inline",
      description = "Summarize the selected text",
      opts = {
        short_name = "summarize",
      },
      context = {
        {
          type = "selection",
        },
      },
      prompts = {
        {
          role = "user",
          content = "Summarize the selected text into concise bullet points using markdown formatting.\
                     You can use nested bullet lists when appropriate.\
                     First-level bullet points should begin with an asterix (*).\
                     Sub-bullet lists, or second-level bullet points should be indented by 4 spaces and begin with a dash (-).\
                     Do not use bold, italic, or any other formatting.\
                     Do not capitalize the first word of the bullet point unless it's an ancronym or proper noun.\
                     Do not use periods at the ends of bullet points.",
        },
      },
    },
  },
})
