-- Go.

vim.opt_local.shiftwidth = 3
vim.opt_local.tabstop = 3

require('lspconfig').gopls.setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
}

vim.cmd [[
  LspStart
]]
