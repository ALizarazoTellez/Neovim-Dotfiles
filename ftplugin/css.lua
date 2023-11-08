-- CSS.

require('lspconfig').stylelint_lsp.setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	settings = {
		stylelintplus = {
			autoFixOnFormat = true,
		},
	},
}

vim.cmd [[
  LspStart
]]
