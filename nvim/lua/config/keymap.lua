-- マクロ
vim.api.nvim_set_keymap("n", "<C-w>", "<C-w>c", { desc = "Quit", noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<cmd>noh<cr>", { desc = "Quit", noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undo Tree" })

vim.api.nvim_set_keymap("n", "<C-a>", "maggVG", { desc = "Select All" })

-- テレスコープ
vim.api.nvim_set_keymap(
	"n",
	"<leader>,",
	"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
	{ desc = "Switch Buffer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>/",
	"<cmd>Telescope live_grep<cr>",
	{ desc = "Grep (Root Dir)", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>:",
	"<cmd>Telescope command_history<cr>",
	{ desc = "Command History", noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Code Actions", noremap = true, silent = true })

vim.api.nvim_set_keymap( "n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir)", noremap = true, silent = true })

-- Format
vim.keymap.set("n", "<leader>F", function()
	vim.lsp.buf.format({ async = true })
end, opts)

vim.api.nvim_set_keymap(
	"n",
	"<leader>fr",
	"<cmd>Telescope oldfiles<cr>",
	{ desc = "Recent", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>p",
	"<cmd>Telescope registers<cr>",
	{ desc = "Registers", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sa",
	"<cmd>Telescope autocommands<cr>",
	{ desc = "Auto Commands", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sb",
	"<cmd>Telescope current_buffer_fuzzy_find<cr>",
	{ desc = "Buffer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sc",
	"<cmd>Telescope command_history<cr>",
	{ desc = "Command History", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sC",
	"<cmd>Telescope commands<cr>",
	{ desc = "Commands", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	"<cmd>Telescope diagnostics bufnr=0<cr>",
	{ desc = "Document Diagnostics", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sD",
	"<cmd>Telescope diagnostics<cr>",
	{ desc = "Workspace Diagnostics", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>sg",
	"<cmd>Telescope live_grep<cr>",
	{ desc = "Grep (Root Dir)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sh",
	"<cmd>Telescope help_tags<cr>",
	{ desc = "Help Pages", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sH",
	"<cmd>Telescope highlights<cr>",
	{ desc = "Search Highlight Groups", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sk",
	"<cmd>Telescope keymaps<cr>",
	{ desc = "Key Maps", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sM",
	"<cmd>Telescope man_pages<cr>",
	{ desc = "Man Pages", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sm",
	"<cmd>Telescope marks<cr>",
	{ desc = "Jump to Mark", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>so",
	"<cmd>Telescope vim_options<cr>",
	{ desc = "Options", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sR",
	"<cmd>Telescope resume<cr>",
	{ desc = "Resume", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sw",
	"<cmd>Telescope grep_string<cr>",
	{ desc = "Word (Root Dir)", noremap = true, silent = true }
)


-- on_attach: set up keymaps when LSP attaches to buffer
local opts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end, opts)

--前のファイルに戻る
vim.keymap.set("n", "<C-b>", "<C-^>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>b",
	"<cmd>TelescopeBuffersClean<cr>",
	{ desc = "Buffer List", noremap = true, silent = true }
)

-- Window
vim.api.nvim_set_keymap(
	"n",
	"<leader>wh",
	"<cmd>split<cr>",
	{ desc = "Split horizontally", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>wv",
	"<cmd>vsplit<cr>",
	{ desc = "Split vertically", noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>wj", "<cmd>split<cr>", { desc = "Split below", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wk", "<cmd>split<cr>", { desc = "Split above", noremap = true, silent = true })
-- Move lines up and down in visual mode
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "H", "<gv", { desc = "Move selection left", noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "L", ">gv", { desc = "Move selection right", noremap = true, silent = true })

-- Diagnostics/Error navigation (basic fallback)
vim.api.nvim_set_keymap(
	"n",
	"[d",
	"<cmd>lua vim.diagnostic.goto_prev()<cr>",
	{ desc = "Go to previous diagnostic", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"]d",
	"<cmd>lua vim.diagnostic.goto_next()<cr>",
	{ desc = "Go to next diagnostic", noremap = true, silent = true }
)


-- Lazygit
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" , noremap=true , silent=true})
