-- Python.

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

require('lspconfig').pylsp.setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

vim.cmd [[
  LspStart
]]
