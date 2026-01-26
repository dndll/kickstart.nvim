-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'options'
require 'autocommands'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'

local b16 = require('base16-colorscheme')
b16.with_config({
  telescope = true,
  telescope_borders = true,
  indentblankline = true,
  notify = true,
  ts_rainbow = true,
  cmp = true,
  illuminate = true,
  lsp_semantic = true,
  mini_completion = true,
  neotree = true,
  dapui = true,
})
b16.setup({
  -- Base16 core (gray ramp)
  base00 = '#000000', -- background
  base01 = '#0d0d0d', -- +1
  base02 = '#1a1a1a', -- +2   (cursor line, selection bg fallback)
  base03 = '#333333', -- comments
  base04 = '#7a7a7a', -- statuslines/secondary fg
  base05 = '#dad9c7', -- default fg (your foreground)
  base06 = '#e8e8e8', -- lighter fg
  base07 = '#ffffff', -- lightest

  -- Accent colours (straight from your list)
  base08 = '#f6188f', -- red
  base09 = '#f85a21', -- orange
  base0A = '#fdf834', -- yellow
  base0B = '#1ebb2b', -- green
  base0C = '#12c3e2', -- cyan
  base0D = '#2186ec', -- blue
  base0E = '#f841a0', -- magenta / pink
  base0F = '#f97137', -- brown/extra (bright orange)
})

vim.api.nvim_set_hl(0, 'Cursor', { fg = '#dad9c7', bg = '#19cde6' })
vim.api.nvim_set_hl(0, 'Visual', { fg = '#000000', bg = '#19cde6' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#19cde6', bold = true })
-- vim.cmd('colorscheme base16-ayu-dark')
-- require('avante_lib').load()

local rocks_config = {
  rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}
vim.g.rocks_nvim = rocks_config

local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
  -- Remove the dylib and dll paths if you do not need macos or windows support
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
-- vim: ts=2 sts=2 sw=2 et