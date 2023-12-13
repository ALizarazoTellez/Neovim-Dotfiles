return {
	"mickael-menu/zk-nvim",
	dependencies = {
		'neovim/nvim-lspconfig',
	},

	ft = 'markdown',

	keys = {
		{ '<Leader>zn', '<Cmd>ZkNew<Enter>' },
		{ '<Leader>zN', '<Cmd>ZkNotes<Enter>' },
		{ '<Leader>zm', ":ZkMatch<Enter>",                   mode = 'v' },
		{ '<Leader>zn', ':ZkNewFromTitleSelection<Enter>',   mode = 'v' },
		{ '<Leader>zN', ':ZkNewFromContentSelection<Enter>', mode = 'v' },
		{ '<Leader>zi', '<Cmd>ZkInsertLink<Enter>' },
		{ '<Leader>zI', '<Cmd>ZkInsertAtSelection<Enter>' },
		{ '<Leader>zb', '<Cmd>ZkBacklinks<Enter>' },
		{ '<Leader>zl', '<Cmd>ZkLinks<Enter>' },
		{ '<Leader>zt', '<Cmd>ZkTags<Enter>' },
		{ '<Leader>zo', '<Cmd>ZkOrphans<Enter>' },
	},

	opts = {
		-- can be "telescope", "fzf", "fzf_lua" or "select" (`vim.ui.select`)
		-- it's recommended to use "telescope", "fzf" or "fzf_lua"
		picker = "telescope",

		lsp = {
			-- `config` is passed to `vim.lsp.start_client(config)`
			config = {
				cmd = { "zk", "lsp" },
				name = "zk",
				-- on_attach = ...
				-- etc, see `:h vim.lsp.start_client()`
			},

			-- automatically attach buffers in a zk notebook that match the given filetypes
			auto_attach = {
				enabled = true,
				filetypes = { "markdown" },
			},
		},
	},
	config = function(_, opts)
		-- Configure plugin.
		require('zk').setup(opts)

		local zk = require("zk")
		local commands = require("zk.commands")

		commands.add("ZkOrphans", function(options)
			options = vim.tbl_extend("force", { orphan = true }, options or {})
			zk.edit(options, { title = "Zk Orphans" })
		end)
	end,
}
