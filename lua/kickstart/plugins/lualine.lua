return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "ayu_dark", -- Adjust theme as needed
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode", "branch" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "lsp_name" },
        lualine_y = { "filetype" },
        lualine_z = { "progress" },
      },
    })
  end,
}

