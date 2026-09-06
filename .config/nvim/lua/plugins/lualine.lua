return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Define Catppuccin Mocha colors manually for precise blending
		local mocha = {
			bg = "NONE", -- Force global transparency
			fg = "#cdd6f4",
			yellow = "#f9e2af",
			cyan = "#89dceb",
			green = "#a6e3a1",
			orange = "#fab387",
			magenta = "#cba6f7",
			blue = "#89b4fa",
			red = "#f38ba8",
			gray = "#585b70",
			surface = "#313244",
		}

		-- Custom beautiful Catppuccin theme with high contrast text over transparent bg
		local custom_catppuccin = {
			normal = {
				a = { fg = mocha.blue, bg = mocha.bg, gui = "bold" },
				b = { fg = mocha.fg, bg = mocha.bg },
				c = { fg = mocha.fg, bg = mocha.bg },
			},
			insert = { a = { fg = mocha.green, bg = mocha.bg, gui = "bold" } },
			visual = { a = { fg = mocha.magenta, bg = mocha.bg, gui = "bold" } },
			replace = { a = { fg = mocha.red, bg = mocha.bg, gui = "bold" } },
			command = { a = { fg = mocha.orange, bg = mocha.bg, gui = "bold" } },
			inactive = {
				a = { fg = mocha.gray, bg = mocha.bg },
				b = { fg = mocha.gray, bg = mocha.bg },
				c = { fg = mocha.gray, bg = mocha.bg },
			},
		}

		require("lualine").setup({
			options = {
				theme = custom_catppuccin,
				component_separators = {},
				section_separators = {},
				globalstatus = true,

				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "NvimTree", "neo-tree", "oil" },
					winbar = { "oil" },
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return "  " .. str .. " "
						end, -- Modern icon prefix
					},
				},
				lualine_b = {
					{ "branch", icon = "", color = { fg = mocha.magenta, gui = "bold" } },
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = mocha.green },
							modified = { fg = mocha.orange },
							removed = { fg = mocha.red },
						},
					},
					{
						"filename",
						file_status = true,
						path = 1, -- 1 = Relative path
						symbols = { modified = "   ", readonly = " ", unnamed = "[No Name]" },
						color = { fg = mocha.fg },
					},
					{ "filetype", icon_only = true },
				},
				lualine_c = {
					"%=",

					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "<?>" },
						diagnostics_color = {
							error = { fg = mocha.red },
							warn = { fg = mocha.yellow },
							info = { fg = mocha.cyan },
							hint = { fg = mocha.magenta },
						},
					},
				},
				lualine_y = {
					{ "encoding", color = { fg = mocha.gray } },
				},
				lualine_z = {
					{ "progress", color = { fg = mocha.cyan } },
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
