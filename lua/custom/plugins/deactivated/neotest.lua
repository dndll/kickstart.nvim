return {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      "vim-test/vim-test",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust"),
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "rust", "vim", "lua", "javascript", "typescript" },
          }),
        },
        output = { enabled = true, open_on_run = true },
        summary = { enabled = true },
      })
    end,
    cmd = { "Neotest", "NeotestRun", "NeotestOutput" },
    event = "BufRead",
  }