return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",

	keys = {
		{ '<Leader>np', '<Cmd>NoNeckPain<Enter>', desc = 'Toggle NoNeckPain plugin.' },
	},

	opts = {
		buffers = {
			wo = {
				fillchars = "eob: ",
			},
		},
	},
}
