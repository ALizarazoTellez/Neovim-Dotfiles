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

		cmp.setup({
			enabled = true,

			--[[
			  Completion mode:
				1. If the autocomplete window is not present, the <Tab> key will launch it, but will not choose any options.
				2. If the auto-complete window is present, the <Tab> and <S-Tab> keys will toggle between options.
				3. If the auto-complete window is present and an option is selected, the <Enter> key will select an option.
			--]]
			mapping = {
				['<Tab>'] = cmp.mapping.select_next_item(),
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
