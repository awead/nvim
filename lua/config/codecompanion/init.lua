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
    ["Debugger"] = {
      interaction = "chat",
      description = "Echo back all context information",
      opts = {
        alias = "debug",
        auto_submit = true,
        stop_context_insertion = false,
      },
      prompts = {
        {
          role = "system",
          content = "You assist with debugging. You echo back exactly what you received without making any modifications to its content."
        },
        {
          role = "user",
          content = function(tbl)
            if type(tbl) ~= "table" then
              error("table_to_string expects a table, got " .. type(tbl))
            end

            local parts = {}
            for k, v in pairs(tbl) do
              parts[#parts + 1] = tostring(k) .. "=" .. tostring(v)
            end

            return table.concat(parts, "\n")
          end,
        },
      },
    },
    ["Summarize"] = {
      interaction = "inline",
      description = "Summarize the selected text",
      opts = {
        alias = "summarize",
        auto_submit = true,
        modes = { "v" },
        placement = "replace",
        stop_context_insertion = true,
      },
      prompts = {
        {
          role = "system",
          content = "Summarize text into concise bullet points using markdown formatting.\
                     You can use nested bullet lists when appropriate.\
                     First-level bullet points should begin with an asterix (*).\
                     Sub-bullet lists, or second-level bullet points should be indented by 4 spaces and begin with a dash (-).\
                     Do not use bold, italic, or any other formatting.\
                     Do not capitalize the first word of the bullet point unless it's an ancronym or proper noun.\
                     Do not use periods at the ends of bullet points.",
        },
        {
          role = "user",
          content = function(context)
            return context.code
          end,
        },
      },
    },
  },
})
