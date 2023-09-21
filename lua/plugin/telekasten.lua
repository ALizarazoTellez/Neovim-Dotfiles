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
		function getZettelkasten()
			return vim.fn.expand("~/ZettelKasten")
		end

		require("telekasten").setup({
			home = getZettelkasten(),

			new_note_filename = "uuid-title",
			uuid_type = "%Y%m%d%H%M%S",
		})

		vim.api.nvim_set_keymap("n", "<Leader><Leader>", ":Telekasten panel<Enter>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<Leader>zn", ":Telekasten new_note<Enter>", { noremap = true })
	end,
}
