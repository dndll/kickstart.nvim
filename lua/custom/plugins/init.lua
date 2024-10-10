-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  
  -- {
  --   "windwp/nvim-ts-autotag",
  --   config = function()
  --     require("nvim-ts-autotag").setup({})
  --   end,
  -- },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({})
    end,
  },

  -- UI Enhancements
  
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        -- Your dressing.nvim configuration here
        input = {
          enabled = true,
          default_prompt = "Input",
          trim_prompt = true,
          title_pos = "left",
          insert_only = true,
          start_in_insert = true,
          border = "rounded",
          relative = "cursor",
          prefer_width = 40,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          win_options = {
            wrap = false,
            list = true,
            listchars = "precedes:…,extends:…",
            sidescrolloff = 0,
          },
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
        },
        select = {
          enabled = true,
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
          trim_prompt = true,
          -- Additional select configurations
        },
      })
    end,
    event = "VeryLazy",
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({ timeout = 200 })
    end,
    event = "InsertEnter",
  },

  -- {
  --   "folke/persistence.nvim",
  --   config = function()
  --     require("persistence").setup({})
  --   end,
  --   event = "BufReadPre",
  -- },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          names = true,
          RRGGBB = true,
          RRGGBBAA = true,
          mode = "foreground",
        },
      })
      vim.cmd([[highlight ColorColumn ctermbg=gray30]])
    end,
    event = "BufRead",
  },

 
  -- Completion and Snippets
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function()
  --     require("luasnip").config.setup({
  --       enable_autosnippets = true,
  --       store_selection_keys = "<Tab>",
  --     })
  --     require("luasnip.loaders.from_vscode").lazy_load({
  --       paths = "/nix/store/g55n9z6d6lk7hrq3a09qq2w2kh6zq9vy-vimplugin-friendly-snippets-2024-07-15",
  --     })
  --   end,
  --   dependencies = { "rafamadriz/friendly-snippets" },
  --   event = "InsertEnter",
  -- },

  -- LSP and Diagnostics
  --[[ {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local border = "rounded"

      -- Configure hover and signature help with borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        float = { border = border },
      })

      -- LSP window default options
      require("lspconfig.ui.windows").default_options = {
        border = border,
      }

      -- Example LSP server configurations
      lspconfig.solidity_ls_nomicfoundation.setup({})
      -- lspconfig.rust_analyzer.setup({})
      -- Add other LSP servers as needed
    end,
    event = { "BufReadPre", "BufNewFile" },
  }, ]]

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup({
        logger = { float_precision = 0.01, level = vim.log.levels.WARN },
  notification = {
    configs = { default = require("fidget.notification").default_config },
    filter = vim.log.levels.INFO,
    history_size = 128,
    override_vim_notify = true,
    poll_rate = 10,
    redirect = function(msg, level, opts)
      if opts and opts.on_open then
        return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
      end
    end,
    view = { group_separator = "---", group_separator_hl = "Comment", icon_separator = " ", stack_upwards = true },
    window = {
      align = "bottom",
      border = "none",
      max_height = 0,
      max_width = 0,
      normal_hl = "Comment",
      relative = "editor",
      winblend = 0,
      x_padding = 1,
      y_padding = 0,
      zindex = 45,
    },
  },
  progress = {
    clear_on_detach = function(client_id)
      local client = vim.lsp.get_client_by_id(client_id)
      return client and client.name or nil
    end,
    display = {
      done_icon = "✔",
      done_style = "Constant",
      done_ttl = 3,
      format_annote = function(msg)
        return msg.title
      end,
      format_group_name = function(group)
        return tostring(group)
      end,
      format_message = require("fidget.progress.display").default_format_message,
      group_style = "Title",
      icon_style = "Question",
      overrides = { rust_analyzer = { name = "rust-analyzer" } },
      priority = 30,
      progress_icon = { pattern = "dots", period = 1 },
      progress_style = "WarningMsg",
      progress_ttl = math.huge,
      render_limit = 16,
      skip_history = true,
    },
    ignore_done_already = false,
    ignore_empty_message = false,
    lsp = { progress_ringbuf_size = 0 },
    notification_group = function(msg)
      return msg.lsp_client.name
    end,
    poll_rate = 0,
    suppress_on_insert = true,
  }
      })
    end,
    event = "LspAttach",
  },


  -- Additional Plugins
  

  {
    "sidebar-nvim/sidebar.nvim",
    config = function()
      require("sidebar-nvim").setup({
        disable_default_keybindings = false,
        open = false,
        side = "left",
        initial_width = 32,
        hide_statusline = false,
        update_interval = 1000,
        sections = { "diagnostics", "git", "containers" },
        section_separator = { "", "-----", "" },
        section_title_separator = { "" },
        containers = {
          attach_shell = "/bin/sh",
          show_all = true,
          interval = 5000,
        },
        datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
        todos = { ignored_paths = {} },
        git = {
          icon = "",
        },
      })
    end,
    keys = { { "<leader>bs", "<cmd>SidebarNvimToggle<cr>", desc = "Toggle Sidebar" } },
    cmd = { "SidebarNvimToggle", "SidebarNvimOpen", "SidebarNvimFocus", "SidebarNvimUpdate" },
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    event = "VeryLazy",
  },

  

  {
    "declancm/cinnamon.nvim",
    config = function()
      require("cinnamon").setup()
    end,
    event = "BufRead",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        exclude = {
          buftypes = { "terminal", "nofile" },
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
        indent = { char = "│" },
        scope = { enabled = true, show_start = true },
      })
    end,
    event = "BufRead",
  },
  -- Search Enhancements
  -- {
  --   "gelguy/wilder.nvim",
  --   config = function()
  --     local wilder = require("wilder")
  --     wilder.setup({ modes = { ":", "/", "?" } })

  --     local __wilderOptions = {
  --       pipeline = {
  --         wilder.branch(
  --           wilder.python_file_finder_pipeline({
  --             file_command = function(ctx, arg)
  --               if string.find(arg, ".") ~= nil then
  --                 return { "fd", "-tf", "-H" }
  --               else
  --                 return { "fd", "-tf" }
  --               end
  --             end,
  --             dir_command = { "fd", "-td" },
  --             filters = { "cpsm_filter" },
  --           }),
  --           wilder.substitute_pipeline({
  --             pipeline = wilder.python_search_pipeline({
  --               skip_cmdtype_check = 1,
  --               pattern = wilder.python_fuzzy_pattern({
  --                 start_at_boundary = 0,
  --               }),
  --             }),
  --           }),
  --           wilder.cmdline_pipeline({
  --             language = "python",
  --             fuzzy = 1,
  --           }),
  --           {
  --             wilder.check(function(ctx, x)
  --               return x == ""
  --             end),
  --             wilder.history(),
  --           },
  --           wilder.python_search_pipeline({
  --             pattern = wilder.python_fuzzy_pattern({
  --               start_at_boundary = 0,
  --             }),
  --           })
  --         ),
  --       },
  --     }

  --     for key, value in pairs(__wilderOptions) do
  --       wilder.set_option(key, value)
  --     end
  --   end,
  --   event = "CmdlineEnter",
  -- },

  

  -- AI and ChatGPT Integration
  {
    "altermo/ultimate-autopair.nvim",
    config = function()
      require("ultimate-autopair").setup()
    end,
    event = "InsertEnter",
  },
  

  }
  