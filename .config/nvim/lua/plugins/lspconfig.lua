local function lsp_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp_lsp.default_capabilities(capabilities)
	end
	return capabilities
end

local function enable_servers(servers)
	for _, server in ipairs(servers) do
		pcall(vim.lsp.enable, server)
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local signs = {
				Error = "",
				Warn = "",
				Hint = "",
				Info = "",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 2,
					prefix = "●",
				},
				float = {
					border = "rounded",
					source = "if_many",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			local capabilities = lsp_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = {
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
					},
				},
			})

			vim.lsp.config("sourcekit", {
				cmd = { "sourcekit-lsp" },
				filetypes = {
					"swift",
					"objective-c",
					"objc",
					"objcpp",
					"c",
					"cpp",
					"cxx",
					"mm",
				},
				root_markers = {
					"Package.swift",
					".git",
				},
				capabilities = capabilities,
			})

			enable_servers({
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"taplo",
				"ts_ls",
				"yamlls",
				"sourcekit",
			})

		end,
	},
}
