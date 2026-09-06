vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
local map = vim.keymap.set

local function telescope_builtin(name)
	return function()
		local ok, builtin = pcall(require, "telescope.builtin")
		if ok and builtin[name] then
			builtin[name]()
		end
	end
end

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
map("n", "<leader>f", telescope_builtin("find_files"), { desc = "Find files" })
map("n", "<leader>fg", telescope_builtin("live_grep"), { desc = "Live grep" })

-- buffer
map("n", "<leader>b", telescope_builtin("buffers"), { desc = "Find buffers" })
map("n", "<leader>q", toggle_quickfix, { desc = "Toggle quickfix" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "H", "<gv", { desc = "Move selection left" })
map("v", "L", ">gv", { desc = "Move selection right" })
map("v", "<leader>p", '"_dP', { desc = "Paste over selection without losing yank" })

map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "open OIl" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspKeymaps", {}),
	callback = function(event)
		local bufmap = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = event.buf,
				silent = true,
				desc = desc,
			})
		end

		bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
		bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		bufmap("n", "gr", vim.lsp.buf.references, "References")
		bufmap("n", "K", vim.lsp.buf.hover, "Hover")
		bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
		bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		bufmap("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
		bufmap("n", "<leader>F", function()
			vim.lsp.buf.format({ async = true })
		end, "Format buffer")
		bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
		bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
	end,
})
