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
	config = function()
		local base_path = vim.fn.expand("~/ZettelKasten")

		require("telekasten").setup({
			home = base_path,
			dailies = base_path .. '/Daily/',
			weeklies = base_path .. '/Weekly/',

			templates = base_path .. '/Templates/',
			image_subdir = base_path .. '/Images/',

			template_new_note = base_path .. 'Templates/Notes.md',
			template_new_daily = base_path .. 'Templates/Dailies.md',
			template_new_weekly = base_path .. 'Templates/Weeklies.md',

			filename_space_subst = '_',
			image_link_style = 'wiki',



			new_note_filename = "uuid-title",
			uuid_type = "%Y%m%d%H%M%S",
		})

		vim.api.nvim_set_keymap("n", "<Leader><Leader>", ":Telekasten panel<Enter>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<Leader>zn", ":Telekasten new_note<Enter>", { noremap = true })
		vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
		vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
		vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
		vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
		vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
		vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
		vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

		-- Call insert link automatically when we start typing a link
		vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
	end,
}
