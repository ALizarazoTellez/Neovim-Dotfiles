-- Markdown.

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 1

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]]
