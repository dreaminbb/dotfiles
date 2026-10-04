return {
	"blackhat-7/vellum.nvim",
	ft = "markdown",
	keys = { { "<leader>mp", "<cmd>Vellum<cr>", desc = "Markdown preview" } },
	config = function(_)
		require("vellum").setup({
			-- markdownファイルを開いた際に自動でプレビューを開くかどうか
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					require("vellum").open()
				end,
			}),
		})
	end,
}
