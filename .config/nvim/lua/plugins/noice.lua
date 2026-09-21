return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		routes = {
			{
				-- Filter out "fewer lines", "deleted lines", or "lines yanked" messages
				filter = {
					event = "msg_show",
					any = {
						{ find = "fewer lines" },
						{ find = "deleted" },
						{ find = "lines yanked" },
					},
				},
				opts = { skip = true },
			},
		},
	},
}
