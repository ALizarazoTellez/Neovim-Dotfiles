return {
	'dcampos/nvim-snippy',
	dependencies = {
		'honza/vim-snippets',
	},

	opts = {
		mappings = {
			is = {
				-- Check Nvim-Cmp plugin.
				['<C-j>'] = 'expand_or_advance',
			},
			nx = {
				['<leader>x'] = 'cut_text',
			},
		},
	},

	config = true,
}
