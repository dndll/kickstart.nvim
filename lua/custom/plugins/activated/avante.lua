return {
  "yetone/avante.nvim",
  config = function()
    require("avante").setup({
      provider = "deepseek",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20240620",
        temperature = 0,
        max_tokens = 4096,
      },
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com/v1",
          model = "deepseek-reasoner",
          api_key_name = "DEEPSEEK_API_KEY",
          -- max_tokens = 16384,
          -- parse_curl_args = function(opts, code_opts)
          --   return {
          --     url = opts.endpoint,
          --     headers = {
          --       ["Accept"] = "application/json",
          --       ["Content-Type"] = "application/json",
          --       ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
          --     },
          --     body = {
          --       model = opts.model,
          --       messages = require("avante.providers").copilot.parse_message(code_opts),
          --       temperature = 0,
          --       max_tokens = 16384,
          --       stream = true,
          --     },
          --   }
          -- end,
          -- parse_response_data = function(data_stream, event_state, opts)
          --   require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
          -- end,
        },
      },
      behaviour = {
        auto_suggestions = true,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<D-l>",
          next = "<D-j>",
          prev = "<D-k>",
          dismiss = "<D-h>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      hints = { enabled = true },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      diff = {
        autojump = true,
        list_opener = "copen",
      },
    })
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      callback = function()
        require("avante_lib").load()
      end,
    })
  end,
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua",      -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- -- required for Windows users
          -- use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
-- require("avante_lib").load()
-- require("avante").setup({
--   ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
--   provider = "deepseek", -- Recommend using Claude
--   claude = {
--     endpoint = "https://api.anthropic.com",
--     model = "claude-3-5-sonnet-20240620",
--     temperature = 0,
--     max_tokens = 4096,
--   },
--   vendors = {
--     ---@type AvanteProvider
--     ["deepseek"] = {
--       endpoint = "https://api.deepseek.com/beta/chat/completions",
--       model = "deepseek-coder",
--       api_key_name = "DEEPSEEK_API_KEY",
--       max_tokens = 8192,
--       parse_curl_args = function(opts, code_opts)
--         return {
--           url = opts.endpoint,
--           headers = {
--             ["Accept"] = "application/json",
--             ["Content-Type"] = "application/json",
--             ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
--           },
--           body = {
--             model = opts.model,
--             messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
--             temperature = 0,
--             max_tokens = 8192,
--             stream = true, -- this will be set by default.
--           },
--         }
--       end,
--       parse_response_data = function(data_stream, event_state, opts)
--         require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
--       end,
--     },
--   },
--   behaviour = {
--     auto_suggestions = true, -- Experimental stage
--     auto_set_highlight_group = true,
--     auto_set_keymaps = true,
--     auto_apply_diff_after_generation = false,
--     support_paste_from_clipboard = true,
--   },
--   mappings = {
--     --- @class AvanteConflictMappings
--     diff = {
--       ours = "qo",
--       theirs = "qt",
--       all_theirs = "qa",
--       both = "qb",
--       cursor = "qc",
--       next = "]x",
--       prev = "[x",
--     },
--     suggestion = {
--       accept = "<D-l>",
--       next = "<D-j>",
--       prev = "<D-k>",
--       dismiss = "<D-h>",
--     },
--     jump = {
--       next = "]]",
--       prev = "[[",
--     },
--     submit = {
--       normal = "<CR>",
--       insert = "<C-s>",
--     },
--   },
--   hints = { enabled = true },
--   windows = {
--     ---@type "right" | "left" | "top" | "bottom"
--     position = "right", -- the position of the sidebar
--     wrap = true,        -- similar to vim.o.wrap
--     width = 30,         -- default % based on available width
--     sidebar_header = {
--       align = "center", -- left, center, right for title
--       rounded = true,
--     },
--   },
--   highlights = {
--     ---@type AvanteConflictHighlights
--     diff = {
--       current = "DiffText",
--       incoming = "DiffAdd",
--     },
--   },
--   --- @class AvanteConflictUserConfig
--   diff = {
--     autojump = true,
--     ---@type string | fun(): any
--     list_opener = "copen",
--   },
-- })
