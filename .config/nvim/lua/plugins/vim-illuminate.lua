return {
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				filetype_overrides = {
					arduino = {
						providers = { "regex" },
					},
				},
			})
		end,
	},
}
