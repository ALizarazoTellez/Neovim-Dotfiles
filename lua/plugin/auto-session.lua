return {
	'rmagatti/auto-session',

	lazy = false,

	keys = {
		{ "<C-s>", nil },
	},

	opts = {
		log_level = "error",
		auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },

		session_lens = {
			load_on_setup = true,
			previewer = false,

			theme_conf = {
				border = true,
			},
		},
	},

	config = function(_, opts)
		require('auto-session').setup(opts)

		vim.keymap.set('n', '<C-s>', require('auto-session.session-lens').search_session, {
			noremap = true,
		})
	end
}
