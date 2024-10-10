return 
    -- Theme
    {
      "Shatur/neovim-ayu",
      config = function()
        require("ayu").setup({})
        require("ayu").colorscheme()
        vim.cmd([[
          let $BAT_THEME = 'ayu'
          colorscheme ayu
        ]])
      end,
    }