return {
  "folke/trouble.nvim",
  dependencies = {
    'mfussenegger/nvim-lint',
  },
  config = function()
    require("trouble").setup({ auto_close = true })
  end,
  cmd = "TroubleToggle",
}

