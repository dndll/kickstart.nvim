return {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({ auto_close = true })
      -- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      --   group = lint_augroup,
      --   callback = function()
      --     lint.try_lint()
      --   end,
      -- })
    end,
    cmd = "TroubleToggle",
  }