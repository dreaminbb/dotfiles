return {
	"rcarriga/nvim-notify",
	event = "VimEnter",
	lazy = false,
	config = function()
		local notify = require("notify")

		local function get_bg()
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "Normal" })
			if ok and hl and hl.bg then
				return string.format("#%06x", hl.bg)
			end
			return "#000000"
		end

		notify.setup({
			background_colour = get_bg(),
			stages = "fade",
			timeout = 1500,
			fps = 60,
			render = "default",
			top_down = false,
			level = vim.log.levels.INFO,
		})

		-- Replace default vim.notify so all plugins use nvim-notify immediately
		vim.notify = notify

		-- keep background in sync when colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				notify.setup({ background_colour = get_bg() })
			end,
		})

		-- quick test command
		vim.api.nvim_create_user_command("NotifyTest", function()
			vim.notify("nvim-notify ready", vim.log.levels.INFO, { title = "Notify" })
		end, {})
		
	-- 			-- link nvim-notify highlight groups to existing ones
			-- vim.schedule(function()
			-- 	vim.cmd([[
			-- 		hi! link NotifyINFOBorder FloatBorder
			-- 		hi! link NotifyWARNBorder FloatBorder
			-- 		hi! link NotifyERRORBorder FloatBorder
			-- 		hi! link NotifyDEBUGBorder FloatBorder
			-- 		hi! link NotifyTRACEBorder FloatBorder
			-- 		hi! link NotifyINFOTitle Title
			-- 		hi! link NotifyWARNTitle Title
			-- 		hi! link NotifyERRORTitle Title
			-- 		hi! link NotifyDEBUGTitle Title
			-- 		hi! link NotifyTRACETitle Title
			-- 	]])
			-- end)
	
	end,
	dependencies = { "nvim-telescope/telescope.nvim" },
	priority = 1000, -- colorschemeより後に読み込むよう調整
}
