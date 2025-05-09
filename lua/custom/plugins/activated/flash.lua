return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    modes  = {
      char = { enabled = true, autohide = true },
      search = { enabled = true },
      treesitter = { enabled = true },
    },
  },
  keys = {
    { "s", function() require("flash").jump() end,       mode = { "n", "x", "o" } },
    { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" } },
    { "r", function() require("flash").remote() end,     mode = "o" },
  },
}
