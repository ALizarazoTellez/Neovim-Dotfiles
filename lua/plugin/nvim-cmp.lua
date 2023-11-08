return {
	'hrsh7th/nvim-cmp',

	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'dcampos/cmp-snippy',
	},

	event = { "InsertEnter", "CmdlineEnter" },

	config = function()
		local cmp = require('cmp')
		local snippy = require('snippy')

		-- Helpers.
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			enabled = true,

			--[[
			  Completion mode:
				- If the autocomplete window is not present, the <Tab> key will launch it, but will not choose any options.
				- If the auto-complete window is present, the <Tab> and <S-Tab> keys will toggle between options.
				* If the auto-complete window is present and an option is selected, the <Enter> key will select an option.
			--]]
			mapping = {
				['<Tab>'] = function(fallback)
					if not has_words_before() then
						fallback()
						return
					end

					if cmp.visible() then
						cmp.select_next_item()
						return
					end

					if snippy.can_jump(1) then
						snippy.next()
						return
					end

					cmp.complete()

					-- If there are only a suggestion use it.
					if #cmp.get_entries() == 1 then
						cmp.confirm({ select = true })
					end
				end,
				['<S-Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif snippy.can_jump(-1) then
						snippy.previous()
					else
						fallback()
					end
				end,

				['<Down>'] = cmp.mapping.select_next_item(),
				['<Up>'] = cmp.mapping.select_prev_item(),

				['<Enter>'] = cmp.mapping.confirm({ select = false }),

				-- List snippets.
				['<C-L>'] = cmp.mapping.complete({
					config = {
						sources = {
							{ name = 'snippy' },
						},
						performance = {
							-- I want see all the snippets.
							max_view_entries = 100,
						},
					},
				}),
			},

			completion = {
				-- It must be a very precise suggestion to launch the autocomplete.
				keyword_length = 3,
			},

			formatting = {
				expandable_indicator = true,
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			view = {
				docs = {
					auto_open = true,
				},
			},

			-- Disable all experimental features.
			experimental = {
				ghost_text = false,
			},

			performance = {
				-- Many options are more distracting than helpful.
				max_view_entries = 14,
			},

			preselect = cmp.PreselectMode.Item,

			-- This function is used to insert text to the buffer, even if it is not a snippet, do not change it unless you know what you are doing.
			snippet = {
				expand = function(args)
					snippy.expand_snippet(args.body)
				end,
			},

			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
			}, {
				{ name = 'buffer' },
			}),
		})
	end,
}
