return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"neovim-treesitter/treesitter-parser-registry",
	},
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"dockerfile",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"python",
				"regex",
				"rust",
				"sql",
				"toml",
				"typescript",
				"vimdoc",
				"yaml",
				"swift",
			},
		})
	end,
}
