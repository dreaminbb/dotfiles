return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			globalstatus = true, -- ←これがポイント
			section_separators = { "", "" },
			component_separators = { "", "" },
		},
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = "",
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"filename",
						path = 1, -- 相対パス
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = "[No Name]",
						},
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_x = {
					"encoding",
					"filetype",
					{
						function()
							local icons = {
								unix = "", -- Linux/Unix
								mac = "", -- macOS
								dos = "", -- Windows
							}
							return icons[vim.bo.fileformat] or ""
						end,
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
