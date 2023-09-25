return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-vsnip',
		{
			'hrsh7th/vim-vsnip',
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
	},
	config = function()
		local lspkind = require('lspkind')
		local cmp = require 'cmp'

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'vsnip' }, -- For vsnip users.
			}, {
				{ name = 'buffer' },
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol_text',
					maxwidth = 50,
					ellipsis_char = '...',
					before = function(_, vim_item)
						return vim_item
					end
				})
			}
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			}),
			enabled = function()
				-- Set of commands where cmp will be disabled
				local disabled = {
					read = true,
				}
				-- Get first word of cmdline
				local cmd = vim.fn.getcmdline():match("%S+")
				-- Return true if cmd isn't disabled
				-- else call/return cmp.close(), which returns false
				return not disabled[cmd] or cmp.close()
			end,
		})

		vim.cmd [[
		  " NOTE: You can use other key to expand snippet.

		  " Expand
		  imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
		  smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

		  " Expand or jump
		  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
		  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

		  " Jump forward or backward
		  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
		  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
		  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
		  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

		  " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
		  " See https://github.com/hrsh7th/vim-vsnip/pull/50
		  nmap        s   <Plug>(vsnip-select-text)
		  xmap        s   <Plug>(vsnip-select-text)
		  nmap        S   <Plug>(vsnip-cut-text)
		  xmap        S   <Plug>(vsnip-cut-text)
		  ]]
	end,
}
