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
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    }
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
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup({
  --       filetypes = { "*" },
  --       user_default_options = {
  --         RGB = true,
  --         RRGGBB = true,
  --         RRGGBBAA = true,
  --         names = true,
  --         RRGGBB = true,
  --         RRGGBBAA = true,
  --         mode = "foreground",
  --       },
  --     })
  --     vim.cmd([[highlight ColorColumn ctermbg=gray30]])
  --   end,
  --   event = "BufRead",
  -- },


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

  {
    "altermo/ultimate-autopair.nvim",
    event = "InsertEnter",
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      -- disable autopair in the command line: https://github.com/altermo/ultimate-autopair.nvim/issues/8
      cmap = false,
      extensions = {
        cond = {
          -- disable in comments
          -- https://github.com/altermo/ultimate-autopair.nvim/blob/6fd0d6aa976a97dd6f1bed4d46be1b437613a52f/Q%26A.md?plain=1#L26
          cond = {
            function(fn) return not fn.in_node "comment" end,
          },
        },
        -- get fly mode working on strings:
        -- https://github.com/altermo/ultimate-autopair.nvim/issues/33
        fly = {
          nofilter = true,
        },
      },
      config_internal_pairs = {
        { '"', '"', fly = true },
        { "'", "'", fly = true },
      },
    },
    specs = {
      {
        "windwp/nvim-autopairs",
        optional = true,
        enabled = false,
      },
    },
  },
}
