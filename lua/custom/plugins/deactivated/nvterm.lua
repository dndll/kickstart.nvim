{
    "NvChad/nvterm",
    config = function()
      require("neocord").setup({
        auto_update = true,
        client_id = "1157438221865717891",
        debounce_timeout = 10,
        editing_text = "Editing...",
        enable_line_number = true,
        file_explorer_text = "Browsing...",
        git_commit_text = "Committing changes...",
        global_timer = true,
        line_number_text = "Line %s out of %s",
        logo = "https://repository-images.githubusercontent.com/325421844/ecb73f47-cb89-4ee0-a0fd-9743c2f3569a",
        logo_tooltip = "NixVim",
        main_image = "logo",
        plugin_manager_text = "Managing plugins...",
        reading_text = "Reading...",
        show_time = true,
        terminal_text = "Using Terminal...",
        workspace_text = "Working on %s",
      })
    end,
  }