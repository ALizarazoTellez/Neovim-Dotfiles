return {
	'renerocksai/telekasten.nvim',
	dependencies = {
		"renerocksai/calendar-vim",
		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				"BurntSushi/ripgrep",
				"nvim-lua/plenary.nvim",
			},
		},
	},
	ft = { "telekasten", "markdown" },
	keys = {
		{ '<Leader><Leader>', nil },
		{ '<Leader>zn',       nil },
		{ '<Leader>zI',       nil },
		{ '<Leader>zb',       nil },
		{ '<Leader>zc',       nil },
		{ '<Leader>zd',       nil },
		{ '<Leader>zf',       nil },
		{ '<Leader>zg',       nil },
		{ '<Leader>zl',       nil },
		{ '<Leader>zz',       nil },
		{ '<Leader>zp',       nil },
	},
	config = function()
		local base_path = vim.fn.expand("~/ZettelKasten")

		require("telekasten").setup({
			home = base_path,
			dailies = base_path .. '/Daily/',
			weeklies = base_path .. '/Weekly/',

			templates = base_path .. '/Templates/',
			image_subdir = base_path .. '/Images/',

			template_new_note = base_path .. '/Templates/Notes.md',
			template_new_daily = base_path .. '/Templates/Dailies.md',
			template_new_weekly = base_path .. '/Templates/Weeklies.md',

			filename_space_subst = '_',
			image_link_style = 'wiki',

			new_note_filename = "uuid-title",
			uuid_type = "%Y%m%d%H%M%S",

			calendar_opts = {
				calendar_monday = 0,
			},
		})

		vim.keymap.set('n', '<Leader><Leader>', '<Cmd>Telekasten panel<Enter>')
		vim.keymap.set('n', '<Leader>zn', '<Cmd>Telekasten new_note<Enter>')
		vim.keymap.set('n', '<Leader>zl', '<cmd>Telekasten insert_link<CR>')
		vim.keymap.set('n', '<Leader>zf', '<cmd>Telekasten find_notes<CR>')
		vim.keymap.set('n', '<Leader>zg', '<cmd>Telekasten search_notes<CR>')
		vim.keymap.set('n', '<Leader>zd', '<cmd>Telekasten goto_today<CR>')
		vim.keymap.set('n', '<Leader>zz', '<cmd>Telekasten follow_link<CR>')
		vim.keymap.set('n', '<Leader>zc', '<cmd>Telekasten show_calendar<CR>')
		vim.keymap.set('n', '<Leader>zb', '<cmd>Telekasten show_backlinks<CR>')
		vim.keymap.set('n', '<Leader>zI', '<cmd>Telekasten insert_img_link<CR>')
		vim.keymap.set('n', '<Leader>zp', '<cmd>Glow<CR>')
	end,
}
