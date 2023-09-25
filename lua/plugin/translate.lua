return {
	'uga-rosa/translate.nvim',

	opts = {
		default = {
			output = 'insert',
		},
		preset = {
			output = {
				insert = {
					base = 'bottom',
					off = 0,
				},
			},
		},
	},

	keys = {
		{
			'<Leader>t',
			'<Cmd>Translate EN<CR>',
			mode = 'v',
			desc = 'Translate selected text to English language.',
		},
	},
}
