return {
	"mbbill/undotree",
	cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide" },

	config = function()
		-- Undo Tree設定
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_ShortIndicators = 1
		vim.g.undotree_SplitWidth = 30
		vim.g.undotree_DiffpanelHeight = 10
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_TreeNodeShape = "●"
		vim.g.undotree_TreeVertShape = "│"
		vim.g.undotree_TreeSplitShape = "╱"
		vim.g.undotree_TreeReturnShape = "╲"

		if vim.fn.has("persistent_undo") == 1 then
			local undo_dir = vim.fn.expand("~/.config/nvim/undodir")
			vim.fn.mkdir(undo_dir, "p")
			vim.opt.undodir = undo_dir
			vim.opt.undofile = true
		end

		vim.opt.undolevels = 1000
		vim.opt.undoreload = 10000
	end,
}
