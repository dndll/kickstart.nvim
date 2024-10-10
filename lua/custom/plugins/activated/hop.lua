return {
    "smoka7/hop.nvim",
    branch = "master", -- optional but recommended
    config = function()
      require("hop").setup({ keys = "fjdkslaghqwerioputy" })
    end,
    cmd = { "HopWord", "HopPattern", "HopLine", "HopChar2" },
  }