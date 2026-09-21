return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			require("catppuccin"),
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				path_display = { "truncate" },
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				winblend = 0,
				file_ignore_patterns = {
					".git/",
					"node_modules/",
					".cache/",
					".venv",
					".build",
				},
				mappings = {
					i = {
						["<Esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")
	end,
}
