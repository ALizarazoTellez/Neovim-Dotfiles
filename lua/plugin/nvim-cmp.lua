return {
	'hrsh7th/nvim-cmp',

	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
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

					cmp.complete()
				end,
				['<S-Tab>'] = cmp.mapping.select_prev_item(),
				['<Enter>'] = cmp.mapping.confirm({ select = false }),
			},

			completion = {
				-- It must be a very precise suggestion to launch the autocomplete.
				keyword_length = 3,
			},

			formatting = {
				expandable_indicator = true,
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
			}),
		})
	end,
}
