return {
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = {
					exclude = { "arduino_language_server" },
				},
				ensure_installed = {
					"bashls",
					"clangd",
					"cssls",
					"dockerls",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"pyright",
					"rust_analyzer",
					"taplo",
					"ts_ls",
					"yamlls",
				},
			})
		end,
	},
}
