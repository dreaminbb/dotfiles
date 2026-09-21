return {
	"zbirenbaum/copilot.lua",
	requires = {
		"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	},
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			filetypes = {
				markdown = true, -- overrides default
				terraform = false, -- disallow specific filetype
				sh = function()
					if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
						return false
					end
					return true
				end,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-l>",
					next = "<C-n>",
					previous = "<C-p>",
					accept_word = false,
					accept_line = false,
					toggle_auto_trigger = false,
				},
			},
		})
	end,
}
