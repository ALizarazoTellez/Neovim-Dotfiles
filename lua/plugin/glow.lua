return {
	"ellisonleao/glow.nvim",

	cmd = "Glow",

	opts = {
		width = math.ceil(vim.o.columns * 0.7), -- Taken from: source code of this plugin.
		border = 'rounded',
	},
	config = true,
}
