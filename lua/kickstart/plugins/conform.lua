-- kickstart/plugins/conform.lua
return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local lsp_mode = (ft == 'c' or ft == 'cpp') and 'never' or 'fallback'
        return { timeout_ms = 500, lsp_format = lsp_mode, stop_after_first = true }
      end,
      formatters_by_ft = {
        lua        = { 'stylua' },
        python     = { 'isort', 'black' },
        -- plain list; no flags here
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        css        = { 'prettierd', 'prettier' },
        html       = { 'prettierd', 'prettier' },
        markdown   = { 'prettierd', 'prettier' },
        nix        = { 'alejandra' },
        rust       = { 'rustfmt' }, -- use rustfmt; LSP is fallback-gated above
      },
      -- one-off override: make Prettier bail out after first success
      formatters = {
        prettier = { inherit = false, stop_after_first = true },
      },
    },
  },
}
