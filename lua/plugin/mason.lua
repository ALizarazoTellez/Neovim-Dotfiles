return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},

		cmd = 'LspInstall',

		config = true,
	},

	{
		"williamboman/mason.nvim",
		lazy = true,
		config = true,
	},
}
