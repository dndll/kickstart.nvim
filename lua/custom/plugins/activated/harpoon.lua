return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
    end,
    cmd = { "HarpoonToggle", "HarpoonGoto" },
  }

--   { action = require("harpoon.mark").add_file,        key = "<leader>ha", mode = "n", options = { silent = true } },
--   { action = require("harpoon.ui").toggle_quick_menu, key = "<C-e>",      mode = "n", options = { silent = true } },
--   {
--     action = function()
--       require("harpoon.ui").nav_file(1)
--     end,
--     key = "<leader>hj",
--     mode = "n",
--     options = { silent = true },
--   },
--   {
--     action = function()
--       require("harpoon.ui").nav_file(2)
--     end,
--     key = "<leader>hk",
--     mode = "n",
--     options = { silent = true },
--   },
--   {
--     action = function()
--       require("harpoon.ui").nav_file(3)
--     end,
--     key = "<leader>hl",
--     mode = "n",
--     options = { silent = true },
--   },
--   {
--     action = function()
--       require("harpoon.ui").nav_file(4)
--     end,
--     key = "<leader>hm",
--     mode = "n",
--     options = { silent = true },
--   },