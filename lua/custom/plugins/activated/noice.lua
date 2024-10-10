-- Notification Filtering and Enhancements
return {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        format = {
          filter = {
            icon = "",
            lang = "regex",
            pattern = {
              ":%s*%%s*s:%s*",
              ":%s*%%s*s!%s*",
              ":%s*%%s*s/%s*",
              "%s*s:%s*",
              ":%s*s!%s*",
              ":%s*s/%s*",
            },
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
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
  }