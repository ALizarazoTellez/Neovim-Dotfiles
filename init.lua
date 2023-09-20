-- Neovim.

-- Copyright (C) 2023, Anderson Lizarazo Tellez.

vim.g.mapleader = " "

-- Options.
vim.o.autochdir = true

-- Plugin Manager (Lazy.nvim).
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Latest stable release.
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins.
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-fugitive",
})

-- Plugins Configuration.
require("tokyonight").setup({
	style = "night",
})
vim.cmd[[colorscheme tokyonight]]

require("lualine").setup()
