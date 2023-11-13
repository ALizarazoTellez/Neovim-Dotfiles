
vim.opt_local.viewoptions:remove('options')

local telekasten_au = vim.api.nvim_create_augroup('telekasten_au', {
  clear = true,
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  group = telekasten_au,
  pattern = '*.md',
  command = 'mkview',
  desc = 'Save custom folds on file close.',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = telekasten_au,
  pattern = '*.md',
  command = 'silent! loadview',
  desc = 'Restore custom folds on file opening.',
})
