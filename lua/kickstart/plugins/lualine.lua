return     {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "ayu_dark", -- Adjust theme as needed
          section_separators = "",
          component_separators = "",
        },
        sections = {
          left = { "mode", "branch" },
          middle = { "filename", "lsp_name" },
          right = { "filetype", "progress" },
        },
      })
    end,
  }