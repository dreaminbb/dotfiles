return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({

			require("catppuccin").setup({
				options = {
					theme = "catppuccin",
					component_separators = {},
					section_separators = {},
					globalstatus = true,

					disabled_filetypes = {
						statusline = { "oil" },
						winbar = { "oil" },
					},
				},
			}),
			sections = {
				lualine_a = {
					{ "mode" },
				},
				lualine_b = {
					{ "branch", icon = "" },
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
					{
						"filename",
						file_status = true,
						path = 1, -- 1 = Relative path
						separator = "",
					},
					{ "filetype", icon_only = true },
				},
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "<?>" },
					},
				},

				lualine_x = {

					{ "encoding" },
					{ "progress" },
				},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
