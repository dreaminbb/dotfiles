return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"neovim-treesitter/treesitter-parser-registry",
		},
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
		end,
	},
}
