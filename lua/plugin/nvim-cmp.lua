return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-path',
		'dcampos/cmp-snippy',
	},

	event = { "InsertEnter", "CmdlineEnter" },

	config = function()
		local lspkind = require('lspkind')
		local cmp = require('cmp')
		local snippy = require('snippy')

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local mapping_i_s = function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				end
			else
				fallback()
			end
		end


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
			mapping = {
				['<C-b>'] = cmp.mapping.scroll_docs(-1),
				['<C-f>'] = cmp.mapping.scroll_docs(1),
				['<C-l>'] = cmp.mapping.complete(),
				['<C-k>'] = cmp.mapping.abort(),

				['<Tab>'] = cmp.mapping({
					i = mapping_i_s,
					s = mapping_i_s,
					o = function(_)
						if cmp.visible() then
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						else
							cmp.complete()
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							end
						end
					end
				}),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif snippy.can_jump(-1) then
						snippy.previous()
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				--{ name = 'snippy' },
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
