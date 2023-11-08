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
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Auto-commands.
vim.api.nvim_create_autocmd('TermOpen', {
	desc = 'Disable spell checking in terminal',
	callback = function()
		vim.opt_local.spell = false
	end,
})

-- Disable NetRW (replaced by plugin NvimTree).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fast alternative to <Esc> key.
vim.keymap.set('i', 'fj', '<Esc>')
vim.keymap.set('v', 'fj', '<Esc>')
vim.keymap.set('x', 'fj', '<Esc>')
vim.keymap.set('i', 'jf', '<Esc>')
vim.keymap.set('v', 'jf', '<Esc>')
vim.keymap.set('x', 'jf', '<Esc>')


-- In some systems, the symbols `«` and `»` are very stressful of get in the
-- keyboard, make a shortcut to generate them.
vim.keymap.set('i', '"<', '«')
vim.keymap.set('i', '>"', '»')

-- Auto move cursor when the backtick is pressed.
vim.keymap.set('i', '``', '``<Esc>i')

-- Plugin Manager (Load Plugins).
require('lazy-setup')

-- Miscellaneous Configurations (Require Load Plugins).
vim.cmd.colorscheme 'tokyonight'
