return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },

		config = function(_)
			require("gitsigns").setup({
				-- 他の設定項目...

				on_attach = function(bufnr)
					-- 無視したいファイルタイプを定義
					local ignored_filetypes = { "markdown", "floggraph", "toggleterm" }
					local ft = vim.bo[bufnr].filetype

					-- 現在のバッファのファイルタイプが含まれている場合は false を返して終了
					if vim.tbl_contains(ignored_filetypes, ft) then
						return false
					end

					-- 通常のアタッチ処理やキーマップの設定をここに記述
					local gs = package.loaded.gitsigns
					vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr })
					vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr })
				end,
			})
		end,
	},
}
