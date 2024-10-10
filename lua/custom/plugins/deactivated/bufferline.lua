return {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          offsets = { { filetype = "neo-tree", text = "Neo-tree", text_align = "left" } },
          separator_style = "thick",
        },
      })
    end,
  }