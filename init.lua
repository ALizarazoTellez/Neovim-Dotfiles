-- Neovim.
-- Neo's.

-- Copyright (C) 2023, Anderson Lizarazo Tellez.

-- Map Leader (Map: <Leader>).
vim.g.mapleader = " "

-- Options.
vim.o.autochdir = false
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

-- Disable NetRW (Replaced by plugin NvimTree).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


function GetPrevChar()
	local line_text = vim.api.nvim_get_current_line()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	if cur_pos[2] == 0 then
		return nil
	end
	local prev_char = line_text:sub(cur_pos[2], cur_pos[2])
	return prev_char
end

function BeforeIsChar(char)
	local ch = GetPrevChar()
	if ch == char then
		return true
	end

	return false
end

function NonDistractingImap(prev, char, exec)
	return function()
		if BeforeIsChar(prev) then
			vim.api.nvim_input(exec)
			return
		end

		-- I can't just insert the character, otherwise this function will be called infinite times.
		vim.api.nvim_input(" <Esc>r" .. char .. "a")
	end
end

-- Fast alternative to <Esc> key.
vim.keymap.set('i', 'f', NonDistractingImap('j', 'f', '<Esc>xh'))
vim.keymap.set('i', 'j', NonDistractingImap('f', 'j', '<Esc>xh'))

-- In some systems, the symbols `«` and `»` are very stressful of get in the
-- keyboard, make a shortcut to generate them.
vim.keymap.set('i', '<', NonDistractingImap('"', '<lt>', '<Esc>r«a'))
vim.keymap.set('i', '"', NonDistractingImap('>', '"', '<Esc>r»a'))

-- Auto move cursor when the backtick is pressed.
vim.keymap.set('i', '``', '``<Esc>i')

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
