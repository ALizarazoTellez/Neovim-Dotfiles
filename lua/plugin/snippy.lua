return {
	'dcampos/nvim-snippy',
	dependencies = {
		'honza/vim-snippets',
	},

	lazy = true,

	opts = {
		mappings = {
			is = {
				-- Most of the autocompletion is done by Nvim-Cmp.
				['<C-J>'] = 'expand_or_advance',
			},
		},
	},

	config = true,
}
