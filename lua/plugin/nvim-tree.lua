return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "BufEnter",
	keys = {
		{ "<C-h>", nil, desc = "Toggle Nvim-Tree." },
	},
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})

		local api = require("nvim-tree.api")

		-- open as vsplit on current node
		local function vsplit_preview()
			local node = api.tree.get_node_under_cursor()

			if node.nodes ~= nil then
				-- expand or collapse folder
				api.node.open.edit()
			else
				-- open file as vsplit
				api.node.open.vertical()
			end

			-- Finally refocus on tree if it was lost
			api.tree.focus()
		end

		-- global
		vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

		-- on_attach
		--vim.keymap.set("n", "l", edit_or_open)
		vim.keymap.set("n", "L", vsplit_preview)
		--vim.keymap.set("n", "h", api.tree.close)
		vim.keymap.set("n", "H", api.tree.collapse_all)
	end,

}
