return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
				transparent_background = true,
				term_colors = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					mason = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					telescope = true,
					treesitter = true,
					lualine = true,
					indent_blankline = {
						enabled = true,
					},
					notify = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
