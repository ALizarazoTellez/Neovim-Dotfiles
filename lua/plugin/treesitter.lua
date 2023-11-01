return {
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	opts = {
		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = {
			-- Go.
			"go",
			"gomod",
			"gosum",
			"gowork",
			-- Kotlin.
			"kotlin",
			-- Web.
			"html",
			"css",
			"javascript",
			-- C.
			"c",
			-- Java.
			"java",
			-- Script.
			"lua",
			-- Vim.
			"vim",
			"vimdoc",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			enable = true,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		incremental_selection = {
			enable = true,

			keymaps = {
				init_selection = "gnn", -- set to `false` to disable one of the mappings
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},

		-- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
		indent = {
			enable = false,
		},
	},

	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end,
}
