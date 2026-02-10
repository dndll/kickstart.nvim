return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      'windwp/nvim-ts-autotag',
    },
    config = function()
      -- New nvim-treesitter API (0.11+) - requires tree-sitter CLI
      local ts = require('nvim-treesitter')
      ts.setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
        ensure_installed = {
          'lua', 'python', 'rust', 'typescript', 'tsx', 'vimdoc',
          'html', 'css', 'nix', 'markdown', 'bash', 'json', 'yaml',
          'toml', 'zig',
        },
        auto_install = true,
      })

      -- Enable treesitter highlighting for all buffers with a parser
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- Create user commands for convenience
      vim.api.nvim_create_user_command('TsInstall', function(opts)
        ts.install(opts.fargs)
      end, { nargs = '+', desc = 'Install treesitter parsers' })

      vim.api.nvim_create_user_command('TsUpdate', function(opts)
        if #opts.fargs > 0 then
          ts.update(opts.fargs)
        else
          ts.update()
        end
      end, { nargs = '*', desc = 'Update treesitter parsers' })

      vim.api.nvim_create_user_command('TsUninstall', function(opts)
        ts.uninstall(opts.fargs)
      end, { nargs = '+', desc = 'Uninstall treesitter parsers' })

      -- Configure ts-context-commentstring
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })

      -- Configure autotag
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
