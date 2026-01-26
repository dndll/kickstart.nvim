return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lint = require('lint')

        -- Configure clippy to use separate target dir (avoid locking issues)
        local clippy = lint.linters.clippy
        clippy.args = vim.list_extend(clippy.args or {}, { '--target-dir', 'target/analyzer' })

        -- Only configure linters you have installed
        -- Install via mason: :MasonInstall selene statix flake8 eslint_d jsonlint
        lint.linters_by_ft = {
            -- lua             = { 'selene' },
            -- nix             = { 'statix' },
            -- solidity        = { 'solhint' },
            -- python          = { 'flake8' },
            rust            = { 'clippy' },
            -- typescript      = { 'eslint_d' },
            -- typescriptreact = { 'eslint_d' },
            -- javascript      = { 'eslint_d' },
            -- json            = { 'jsonlint' },
        }

        local lint_au = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_au,
            callback = function()
                -- Silently skip if linter not found
                pcall(lint.try_lint)
            end,
        })
    end,
}
