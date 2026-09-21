return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,
	priority = 1000,
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
			size = 20,
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
		})
	end,
}
