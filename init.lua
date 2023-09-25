-- Neovim.

-- Copyright (C) 2023, Anderson Lizarazo Tellez.

-- Map Leader (Map: <Leader>).
vim.g.mapleader = " "

-- Options.
vim.o.autochdir = true
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 9999
vim.o.shiftwidth = 2
vim.o.sidescrolloff = 9999
vim.o.spell = true
vim.o.spelllang = "es,en,cjk"
vim.o.tabstop = 4
vim.o.wrap = false
vim.o.undofile = true

-- Disable NetRW (Replaced by plugin NvimTree).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugin Manager (Load Plugins).
require('lazy-setup')

-- Miscellaneous Configurations (Require Load Plugins).
vim.cmd.colorscheme 'tokyonight'

-- Go HTML Templates.
local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
	install_info = {
		url = "https://github.com/ngalaiko/tree-sitter-go-template",
		files = { "src/parser.c" }
	},
	filetype = "gotmpl",
	used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
}
