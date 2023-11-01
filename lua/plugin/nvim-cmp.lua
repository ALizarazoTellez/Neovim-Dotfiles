return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-path',
		'dcampos/cmp-snippy',
	},

	config = function()
		local lspkind = require('lspkind')
		local cmp = require 'cmp'

		cmp.setup({
			snippet = {
				expand = function(args)
					require('snippy').expand_snippet(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-1),
				['<C-f>'] = cmp.mapping.scroll_docs(1),
				['<C-l>'] = cmp.mapping.complete(),
				['<C-k>'] = cmp.mapping.abort(),
				['<Tab>'] = cmp.mapping.confirm(
					{ select = false }
				),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'snippy' },
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
	end,
}
