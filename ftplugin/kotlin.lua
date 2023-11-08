-- Kotlin.

require('lspconfig').kotlin_language_server.setup {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

vim.cmd [[
  LspStart
]]
