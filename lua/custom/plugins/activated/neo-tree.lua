-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  
}


-- require("neo-tree").setup({
--   buffers = { bind_to_cwd = false, follow_current_file = { enabled = true } },
--   close_if_last_window = true,
--   document_symbols = { custom_kinds = {} },
--   enable_diagnostics = true,
--   enable_git_status = true,
--   enable_modified_markers = true,
--   enable_refresh_on_write = true,
--   popup_border_style = "rounded",
--   window = { auto_expand_width = false, height = 15, mappings = { ["<space>"] = "none" }, width = 40 },
-- })
