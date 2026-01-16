vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.opt.spell = false
vim.o.relativenumber = true
vim.opt.hidden = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度
vim.opt.showcmd = false
--transparent
-- Enable break indent
vim.opt.breakindent = true
vim.opt.cmdheight = 1
-- Save undo history
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.laststatus = 3
vim.opt.list = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.updatetime = 200
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 300

vim.g.lazyvim_rust_diagnostics = "bacon-ls"

vim.opt.cursorline = true

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

vim.opt.clipboard:append({ "unnamedplus" })
