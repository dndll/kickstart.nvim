return {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("codeium").setup({
    --     api = { host = "server.codeium.com", port = "443" },
    --     bin_path = vim.fn.stdpath("cache") .. "/codeium/bin",
    --     config_path = vim.fn.stdpath("cache") .. "/codeium/config.json",
    --     enable_chat = true,
        enable_index_service = true,
        enable_local_search = true,
    --   workspace_root = 'use_lsp',
        idle_delay = 10,
    --     tools = {
    --       curl = "/nix/store/6r0bn0dkvlvhicyvair205s07m92dpaz-curl-8.9.1-bin/bin/curl",
    --       gzip = "/nix/store/164s7a7yscnicprzrr78bvk45d77a3yg-gzip-1.13/bin/gzip",
    --       uname = "/nix/store/0kg70swgpg45ipcz3pr2siidq9fn6d77-coreutils-9.5/bin/uname",
    --       uuidgen = "/nix/store/f3mrhapkqr1lds8x58fh6rwm1lwh8y8c-util-linux-2.39.4-bin/bin/uuidgen",
    --     },
      })
    end,
  }
