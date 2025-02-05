return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
          lsp_fallback = true,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        nix = { "alejandra" },
        rust = { "rustfmt", lsp_format = 'fallback' },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

-- Additional Tools
-- {
--   "stevearc/conform.nvim",
--   config = function()
--     require("conform").setup({
--       formatters_by_ft = {
--         css = { { "prettierd", "prettier" } },
--         html = { { "prettierd", "prettier" } },
--         java = { "google-java-format" },
--         javascript = { { "prettierd", "prettier" } },
--         javascriptreact = { { "prettierd", "prettier" } },
--         lua = { "stylua" },
--         markdown = { { "prettierd", "prettier" } },
--         nix = { "alejandra" },
--         python = { "black" },
--         rust = { "rustfmt" },
--         typescript = { { "prettierd", "prettier" } },
--         typescriptreact = { { "prettierd", "prettier" } },
--       },
--       notify_on_error = true,
--       format_on_save = function(bufnr)
--         if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
--           return
--         end
--         return { timeout_ms = 500, lsp_fallback = true }
--       end,
--     })
--   end,
--   event = "BufWritePost",
-- },
