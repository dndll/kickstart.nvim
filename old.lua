-- Nixvim's internal module table
-- Can be used to share code throughout init.lua
local _M = {}

-- Ignore the user lua configuration
-- vim.opt.runtimepath:remove(vim.fn.stdpath("config")) -- ~/.config/nvim
-- vim.opt.runtimepath:remove(vim.fn.stdpath("config") .. "/after") -- ~/.config/nvim/after
-- vim.opt.runtimepath:remove(vim.fn.stdpath("data") .. "/site") -- ~/.local/share/nvim/site




require("nvim-ts-autotag").setup({})
require("trouble").setup({ auto_close = true })
require("treesitter-context").setup({})

vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))
require("nvim-treesitter.configs").setup({
  indent = { enable = true },
  parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
})




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

require("hop").setup({ keys = "fjdkslaghqwerioputy" })
require("dressing").setup({})
require("better_escape").setup({ timeout = 200 })
require("auto-save").setup({})
require("persistence").setup({})
require("colorizer").setup({
  filetypes = nil,
  user_default_options = nil,
  buftypes = nil,
})
vim.notify = require("notify")
require("notify").setup({ background_colour = "#000000", fps = 60, render = "default", timeout = 500, top_down = true })


require("conform").setup({
  
})


wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

local __wilderOptions = {
  pipeline = {
    wilder.branch(
      wilder.python_file_finder_pipeline({
        file_command = function(ctx, arg)
          if string.find(arg, ".") ~= nil then
            return { "fd", "-tf", "-H" }
          else
            return { "fd", "-tf" }
          end
        end,
        dir_command = { "fd", "-td" },
        filters = { "cpsm_filter" },
      }),
      wilder.substitute_pipeline({
        pipeline = wilder.python_search_pipeline({
          skip_cmdtype_check = 1,
          pattern = wilder.python_fuzzy_pattern({
            start_at_boundary = 0,
          }),
        }),
      }),
      wilder.cmdline_pipeline({
        language = "python",
        fuzzy = 1,
      }),
      {
        wilder.check(function(ctx, x)
          return x == ""
        end),
        wilder.history(),
      },
      wilder.python_search_pipeline({
        pattern = wilder.python_fuzzy_pattern({
          start_at_boundary = 0,
        }),
      })
    ),
  },
}
for key, value in pairs(__wilderOptions) do
  wilder.set_option(key, value)
end

require("noice").setup({
  format = {
    filter = {
      icon = "",
      lang = "regex",
      pattern = { ":%s*%%s*s:%s*", ":%s*%%s*s!%s*", ":%s*%%s*s/%s*", "%s*s:%s*", ":%s*s!%s*", ":%s*s/%s*" },
    },
    replace = {
      icon = "󱞪",
      lang = "regex",
      pattern = {
        ":%s*%%s*s:%w*:%s*",
        ":%s*%%s*s!%w*!%s*",
        ":%s*%%s*s/%w*/%s*",
        "%s*s:%w*:%s*",
        ":%s*s!%w*!%s*",
        ":%s*s/%w*/%s*",
      },
    },
  },
  lsp = { message = { enabled = true }, progress = { enabled = false, view = "mini" } },
  messages = { enabled = true },
  notify = { enabled = false },
  popupmenu = { backend = "nui", enabled = true },
})


require("luasnip").config.setup({ enable_autosnippets = true, store_selection_keys = "<Tab>" })
require("luasnip.loaders.from_vscode").lazy_load({
  paths = "/nix/store/g55n9z6d6lk7hrq3a09qq2w2kh6zq9vy-vimplugin-friendly-snippets-2024-07-15",
})



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
  },
})

require("diffview").setup({ use_icons = true })

require("dap").configurations = {
  java = {
    { hostName = "127.0.0.1", name = "Debug (Attach) - Remote", port = 5005, request = "launch", type = "java" },
  },
}
local __dap_signs = {
  DapBreakpoint = { text = "●", texthl = "DapBreakpoint" },
  DapBreakpointCondition = { text = "●", texthl = "DapBreakpointCondition" },
  DapLogPoint = { text = "◆", texthl = "DapLogPoint" },
}
for sign_name, sign in pairs(__dap_signs) do
  vim.fn.sign_define(sign_name, sign)
end
require("nvim-dap-virtual-text").setup({})
require("dapui").setup({ floating = { mappings = { close = { "<ESC>", "q" } } } })
require("dap-python").setup("/nix/store/g10slrx4c91lzip4hyii5r570nllcn67-python3-3.12.5-env/bin/python3", {})


require("ultimate-autopair").setup()

local sidebar = require("sidebar-nvim")
sidebar.setup({
  disable_default_keybindings = 0,
  bindings = nil,
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
  ["git"] = {
    icon = "", -- 
  },
})
cmd =
    {
      "SidebarNvimToggle",
      "SidebarNvimOpen",
      "SidebarNvimFocus",
      "SidebarNvimUpdate",
    },
    require("nvim-surround").setup()

require("neotest").setup({
  adapters = {
    require("rustaceanvim.neotest"),
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "rust", "vim", "lua", "javascript", "typescript" },
    }),
  },
  output = { enabled = true, open_on_run = true },
  summary = { enabled = true },
})

require("neodev").setup({
  library = { plugins = { "neotest" }, types = true },
})

local notify = require("notify")
local filtered_message = { "No information available" }

-- Override notify function to filter out messages
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(message, level, opts)
  local merged_opts = vim.tbl_extend("force", {
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    end,
  }, opts or {})

  for _, msg in ipairs(filtered_message) do
    if message == msg then
      return
    end
  end
  return notify(message, level, merged_opts)
end

require("dressing").setup({
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = true,

    -- Default prompt string
    default_prompt = "Input",

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    -- Can be 'left', 'right', or 'center'
    title_pos = "left",

    -- When true, <Esc> will close the modal
    insert_only = true,

    -- When true, input will start in insert mode.
    start_in_insert = true,

    -- These are passed to nvim_open_win
    border = "rounded",
    -- 'editor' and 'win' will default to being centered
    relative = "cursor",

    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    width = nil,
    -- min_width and max_width can be a list of mixed types.
    -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },

    buf_options = {},
    win_options = {
      -- Disable line wrapping
      wrap = false,
      -- Indicator for when text exceeds window
      list = true,
      listchars = "precedes:…,extends:…",
      -- Increase this for more context when text scrolls off the window
      sidescrolloff = 0,
    },

    -- Set to `false` to disable
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

    override = function(conf)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,

    -- see :help dressing_get_config
    get_config = nil,
  },
  select = {
    -- Set to false to disable the vim.ui.select implementation
    enabled = true,

    -- Priority list of preferred vim.select implementations
    backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

    -- Trim trailing `:` from prompt
    trim_prompt = true,

    -- Options for telescope selector
    -- These are passed into the telescope picker directly. Can be used like:
    -- telescope = require('telescope.themes').get_ivy({...})
    telescope = nil,

    -- Options for fzf selector
    fzf = {
      window = {
        width = 0.5,
        height = 0.4,
      },
    },

    -- Options for fzf-lua
    fzf_lua = {
      -- winopts = {
      --   height = 0.5,
      --   width = 0.5,
      -- },
    },

    -- Options for nui Menu
    nui = {
      position = "50%",
      size = nil,
      relative = "editor",
      border = {
        style = "rounded",
      },
      buf_options = {
        swapfile = false,
        filetype = "DressingSelect",
      },
      win_options = {
        winblend = 0,
      },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 10,
    },

    -- Options for built-in selector
    builtin = {
      -- Display numbers for options and set up keymaps
      show_numbers = true,
      -- These are passed to nvim_open_win
      border = "rounded",
      -- 'editor' and 'win' will default to being centered
      relative = "editor",

      buf_options = {},
      win_options = {
        cursorline = true,
        cursorlineopt = "both",
      },

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- the min_ and max_ options can be a list of mixed types.
      -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
      width = nil,
      max_width = { 140, 0.8 },
      min_width = { 40, 0.2 },
      height = nil,
      max_height = 0.9,
      min_height = { 10, 0.2 },

      -- Set to `false` to disable
      mappings = {
        ["<Esc>"] = "Close",
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
      },

      override = function(conf)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
      end,
    },

    -- Used to override format_item. See :help dressing-format
    format_item_override = {},

    -- see :help dressing_get_config
    get_config = nil,
  },
})
local telescope = require("telescope")
telescope.setup({
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
})

require("staline").setup({
  sections = {
    left = { "-mode", " ", "branch" },
    mid = { "lsp_name" },
    right = { "file_name", "line_column" },
  },
  inactive_sections = {
    left = { "-mode", " ", "branch" },
    mid = { "lsp_name" },
    right = { "file_name", "line_column" },
  },
  defaults = {
    left_separator = " ",
    right_separator = "  ",
    branch_symbol = " ",
    mod_symbol = "",
    line_column = "[%l/%L]",
    inactive_color = "#80a6f2", --#303030 is the default
    inactive_bgcolor = "none",
  },
  special_table = {
    lazy = { "Plugins", "💤 " },
    TelescopePrompt = { "Telescope", "  " },
    oil = { "Oil", "󰏇 " },
    lazygit = { "LazyGit", " " },
  },
  mode_icons = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["nov"] = "NORMAL",
    ["noV"] = "NORMAL",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["s"] = "INSERT",
    ["S"] = "INSERT",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL",
    [""] = "VISUAL",
    ["r"] = "REPLACE",
    ["r?"] = "REPLACE",
    ["R"] = "REPLACE",
    ["c"] = "COMMAND",
    ["t"] = "TERMINAL",
  },
})

local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config({
  float = { border = _border },
})

require("lspconfig.ui.windows").default_options = {
  border = _border,
}

local conform = require("conform")
local notify = require("notify")

conform.setup({
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
})

local function show_notification(message, level)
  notify(message, level, { title = "conform.nvim" })
end

vim.api.nvim_create_user_command("FormatToggle", function(args)
  local is_global = not args.bang
  if is_global then
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    if vim.g.disable_autoformat then
      show_notification("Autoformat-on-save disabled globally", "info")
    else
      show_notification("Autoformat-on-save enabled globally", "info")
    end
  else
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    if vim.b.disable_autoformat then
      show_notification("Autoformat-on-save disabled for this buffer", "info")
    else
      show_notification("Autoformat-on-save enabled for this buffer", "info")
    end
  end
end, {
  desc = "Toggle autoformat-on-save",
  bang = true,
})

require("lspconfig").solidity_ls_nomicfoundation.setup({})

require("telescope").load_extension("lazygit")

luasnip = require("luasnip")


local notify = require("notify")





-- }}
