return {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        background_colour = "#000000",
        fps = 60,
        render = "default",
        timeout = 2000,
        top_down = true,
      })
    end,
    event = "VeryLazy",
  }
