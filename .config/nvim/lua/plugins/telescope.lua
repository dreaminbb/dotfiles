return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
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
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "none" })
		end,
	},
}
