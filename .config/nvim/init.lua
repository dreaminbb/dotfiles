vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = true,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	install = {
		colorscheme = { "catppuccin" },
	},
	ui = {
		border = "rounded",
		icons = {
			cmd = "",
			config = "",
			event = "",
			ft = "󰈙",
			init = "󰆧",
			keys = "",
			plugin = "󰏖",
			runtime = "󰑴",
			require = "󰄖",
			source = "󰈙",
			start = "",
			task = "󰄉",
			lazy = "󰆤",
		},
	},
})
require("config.options")
require("config.keymap")
require("config.autocmds")
