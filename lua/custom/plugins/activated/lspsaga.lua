return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require("lspsaga").setup({
      beacon = { enable = true },
      code_action = {
        extend_gitsigns = false,
        keys = { exec = "<CR>", quit = { "<Esc>", "q" } },
        num_shortcut = true,
        only_in_cursor = true,
        show_server_name = true,
      },
      diagnostic = { border_follow = true, diagnostic_only_current = false, show_code_action = true },
      hover = { open_cmd = "!floorp", open_link = "gx" },
      implement = { enable = false },
      lightbulb = { enable = false, sign = false, virtual_text = true },
      outline = {
        auto_close = true,
        auto_preview = true,
        close_after_jump = true,
        keys = { jump = "e", quit = "q", toggle_or_jump = "o" },
        layout = "float",
        win_position = "right",
      },
      rename = { auto_save = false, keys = { exec = "<CR>", quit = { "<C-k>", "<Esc>" }, select = "x" } },
      scroll_preview = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
      symbol_in_winbar = { enable = true },
      ui = { border = "rounded", code_action = "💡" },
    })

    __lint = require("lint")
    __lint.linters_by_ft = {
      -- javascript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- json = { "jsonlint" },
      lua = { "selene" },
      nix = { "statix" },
      python = { "flake8" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }
  end,
  dependencies = {
    'mfussenegger/nvim-lint',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  }
}

