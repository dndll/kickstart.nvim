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
                layout = "normal",
                win_position = "right",
            },
            rename = { auto_save = false, keys = { exec = "<CR>", quit = { "<C-k>", "<Esc>" }, select = "x" } },
            scroll_preview = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
            symbol_in_winbar = { enable = true },
            ui = { border = "rounded", code_action = "💡" },
        })

        local lint = require('lint')
        local clippy = lint.linters.clippy -- grab default definition
        -- -- 1) pass the flag explicitly …
        clippy.args = vim.list_extend(clippy.args or {}, { '--target-dir', 'target/analyzer' })
        -- -- 2) … or force the environment variable (cargo prefers this)
        -- clippy.env = vim.tbl_extend('force', clippy.env or {}, {
        --     CARGO_TARGET_DIR = 'target/analyzer',
        -- })

        lint.linters_by_ft = {
            lua             = { 'selene' },
            nix             = { 'statix' },
            solidity        = { 'solhint' },
            python          = { 'flake8' },
            rust            = { 'clippy' },
            typescript      = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            javascript      = { 'eslint_d' },
            json            = { 'jsonlint' }
        }
        local lint_au = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd(
            { 'BufEnter', 'BufWritePost', 'InsertLeave' },
            { group = lint_au, callback = function() lint.try_lint() end }
        )
    end,
    dependencies = {
        'mfussenegger/nvim-lint',
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    }
}
