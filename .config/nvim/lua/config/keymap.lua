vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
local map = vim.keymap.set

local function toggle_quickfix()
	local qf = vim.fn.getqflist({ winid = 0 })
	if qf.winid ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

local function tmux_navigate(direction)
	return function()
		vim.cmd("TmuxNavigate" .. direction)
	end
end

map("n", "<Esc><Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
map("n", "<C-h>", tmux_navigate("Left"), { desc = "Move left" })
map("n", "<C-j>", tmux_navigate("Down"), { desc = "Move down" })
map("n", "<C-k>", tmux_navigate("Up"), { desc = "Move up" })
map("n", "<C-l>", tmux_navigate("Right"), { desc = "Move right" })

map("n", "<leader>q", toggle_quickfix, { desc = "Toggle quickfix" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
map("v", "H", "<gv", { desc = "Move selection left" })
map("v", "L", ">gv", { desc = "Move selection right" })
map("v", "<leader>p", '"_dP', { desc = "Paste over selection without losing yank", silent = true })

map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "open OIl", silent = true })
