-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`


-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Set up globals {{{
do
  local nixvim_globals = {
    loaded_ts_context_commentstring = false,
    mapleader = " ",
    mkdp_browser = "floorp",
    mkdp_theme = "dark",
    rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              extraArgs = { "--profile", "rust-analyzer" },
              extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
            },
            ["rust-analyzer"] = {
              check = { command = "clippy" },
              checkOnSave = true,
              inlayHints = {
                enable = true,
                otherHintsPrefix = "=> ",
                parameterHintsPrefix = "<- ",
                showParameterNames = true,
              },
              procMacro = { enable = true },
            },
          },
        },
        -- on_attach = function(client, bufnr)
        --   return _M.lspOnAttach(client, bufnr)
        -- end,
      },
      tools = { float_win_config = { auto_focus = true, open_split = "vertical" } },
    },
    skip_ts_context_commentstring_module = true,
    undotree_autoOpenDiff = true,
    undotree_focusOnToggle = true,
  }

  for k, v in pairs(nixvim_globals) do
    vim.g[k] = v
  end
end

-- Set up options {{{
do
  local nixvim_options = {
    backup = false,
    breakindent = true,
    cmdheight = 2,
    colorcolumn = "80",
    completeopt = { "menuone", "noselect", "noinsert" },
    cursorline = true,
    encoding = "utf-8",
    expandtab = true,
    fileencoding = "utf-8",
    foldcolumn = "0",
    foldenable = true,
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevel = 99,
    foldlevelstart = 99,
    foldmethod = "expr",
    formatexpr = "v:lua.require'conform'.formatexpr()",
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --vimgrep",
    guicursor = {
      "n-v-c:block",
      "i-ci-ve:block",
      "r-cr:hor20",
      "o:hor50",
      "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
      "sm:block-blinkwait175-blinkoff150-blinkon175",
    },
    hlsearch = true,
    ignorecase = true,
    incsearch = true,
    inccommand = 'split',
    laststatus = 3,
    list = true,
    listchars = "eol:↲,tab:|->,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣",
    mouse = "a",
    number = true,
    pumheight = 0,
    relativenumber = true,
    scrolloff = 8,
    shiftwidth = 2,
    showmode = false,
    showtabline = 2,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    softtabstop = 2,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    timeoutlen = 50,
    undofile = true,
    updatetime = 50,
    wrap = false,
  }

  for k, v in pairs(nixvim_options) do
    vim.opt[k] = v
  end
end
-- local notify = require("notify")

-- local function show_notification(message, level)
--   notify(message, level, { title = "conform.nvim" })
-- end

function ToggleLineNumber()
  if vim.wo.number then
    vim.wo.number = false
    show_notification("Line numbers disabled", "info")
  else
    vim.wo.number = true
    vim.wo.relativenumber = false
    show_notification("Line numbers enabled", "info")
  end
end

function ToggleRelativeLineNumber()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    show_notification("Relative line numbers disabled", "info")
  else
    vim.wo.relativenumber = true
    vim.wo.number = false
    show_notification("Relative line numbers enabled", "info")
  end
end

function ToggleWrap()
  if vim.wo.wrap then
    vim.wo.wrap = false
    show_notification("Wrap disabled", "info")
  else
    vim.wo.wrap = true
    vim.wo.number = false
    show_notification("Wrap enabled", "info")
  end
end

-- Keymaps for Toggle Functions
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>lua ToggleLineNumber()<CR>', { noremap = true, silent = true, desc = "Toggle Line Numbers" })
vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>lua ToggleRelativeLineNumber()<CR>', { noremap = true, silent = true, desc = "Toggle Relative Line Numbers" })
vim.api.nvim_set_keymap('n', '<leader>tw', '<cmd>lua ToggleWrap()<CR>', { noremap = true, silent = true, desc = "Toggle Wrap" })

if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    vim.lsp.inlay_hint.enable(true)
  end, { desc = "Toggle Inlay Hints" })
end

kind_icons = {
  Text = "󰊄",
  Method = "",
  Function = "󰡱",
  Constructor = "",
  Field = "",
  Variable = "󱀍",
  Class = "",
  Interface = "",
  Module = "󰕳",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}