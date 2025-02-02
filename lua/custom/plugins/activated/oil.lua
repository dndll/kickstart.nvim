return {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        deleteToTrash = true,
        float = { border = "rounded", maxHeight = 0, maxWidth = 0, padding = 2, winOptions = { winblend = 0 } },
        keymaps = {
          ["-"] = "actions.parent",
          ["<C-\\>"] = "actions.select_vsplit",
          ["<C-c>"] = "actions.close",
          ["<C-enter>"] = "actions.select_split",
          ["<C-p>"] = "actions.preview",
          ["<C-r>"] = "actions.refresh",
          ["<C-t>"] = "actions.select_tab",
          ["<CR>"] = "actions.select",
          _ = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["g."] = "actions.toggle_hidden",
          ["g?"] = "actions.show_help",
          gs = "actions.change_sort",
          gx = "actions.open_external",
          q = "actions.close",
          ["~"] = "actions.tcd",
        },
        preview = { border = "rounded" },
        useDefaultKeymaps = true,
        viewOptions = { showHidden = true },
      })
    end,
  }
