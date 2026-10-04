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

local function executable(name, fallback)
	local path = vim.fn.exepath(name)
	if path ~= "" then
		return path
	end
	return vim.fn.expand(fallback or name)
end

local function arduino_cli_config()
	local candidates = {
		vim.fn.expand("~/Library/Arduino15/arduino-cli.yaml"),
		vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
	}

	if vim.env.LOCALAPPDATA then
		table.insert(candidates, vim.fs.joinpath(vim.env.LOCALAPPDATA, "Arduino15", "arduino-cli.yaml"))
	end

	for _, path in ipairs(candidates) do
		if vim.fn.filereadable(path) == 1 then
			return path
		end
	end
end

local function arduino_fqbn(root_dir)
	local sketch_config = vim.fs.joinpath(root_dir, "sketch.yaml")
	if vim.fn.filereadable(sketch_config) == 1 then
		for _, line in ipairs(vim.fn.readfile(sketch_config)) do
			local fqbn = line:match([[^%s*default_fqbn:%s*["']?([^%s"'#]+)]])
			if fqbn then
				return fqbn
			end
		end
	end

	local fqbn_file = vim.fs.joinpath(root_dir, ".arduino-fqbn")
	if vim.fn.filereadable(fqbn_file) == 1 then
		local lines = vim.fn.readfile(fqbn_file, "", 1)
		if lines[1] and vim.trim(lines[1]) ~= "" then
			return vim.trim(lines[1])
		end
	end

	return vim.g.arduino_fqbn or vim.env.ARDUINO_FQBN or "esp32:esp32:esp32"
end

local function arduino_fallback_flags()
	local flags = {
		"-x",
		"c++",
		"-std=gnu++2a",
		"-DARDUINO=10607",
		"-DARDUINO_ARCH_ESP32",
		"-DARDUINO_ESP32_DEV",
		"-DARDUINO_USB_CDC_ON_BOOT=0",
		"-DARDUINO_USB_MODE=0",
		'-DARDUINO_BOARD="ESP32_DEV"',
		'-DARDUINO_VARIANT="esp32"',
	}
	local base = vim.fn.expand("~/Library/Arduino15/packages/esp32/hardware/esp32")
	local versions = vim.fn.glob(vim.fs.joinpath(base, "*"), false, true)
	local platform = versions[#versions]
	if not platform or platform == "" then
		return flags
	end

	local include_dirs = {
		vim.fs.joinpath(platform, "cores", "esp32"),
		vim.fs.joinpath(platform, "variants", "esp32"),
		vim.fs.joinpath(platform, "system"),
	}
	for _, dir in ipairs(vim.fn.glob(vim.fs.joinpath(platform, "libraries", "*", "src"), false, true)) do
		table.insert(include_dirs, dir)
	end

	-- ESP32 Arduino's public headers depend on the matching ESP-IDF headers.
	-- Without these paths clangd partially parses Arduino.h, which makes
	-- inherited Print methods such as Serial.printf look missing.
	local tools_root = vim.fs.joinpath(vim.fn.expand("~/Library/Arduino15/packages/esp32/tools"))
	local libs_versions = vim.fn.glob(vim.fs.joinpath(tools_root, "esp32-libs", "*"), false, true)
	local libs_root = libs_versions[#libs_versions]
	if libs_root and libs_root ~= "" then
		table.insert(include_dirs, vim.fs.joinpath(libs_root, "include"))
		for _, dir in ipairs(vim.fn.glob(vim.fs.joinpath(libs_root, "**", "include"), false, true)) do
			if vim.fn.isdirectory(dir) == 1 then
				table.insert(include_dirs, dir)
			end
		end
		for _, dir in ipairs(vim.fn.glob(vim.fs.joinpath(libs_root, "*", "include"), false, true)) do
			if vim.fn.isdirectory(dir) == 1 then
				table.insert(include_dirs, dir)
			end
		end
		for _, file in ipairs(vim.fn.glob(vim.fs.joinpath(libs_root, "**", "FreeRTOSConfig.h"), false, true)) do
			table.insert(include_dirs, vim.fs.dirname(file))
		end
		for _, file in ipairs(vim.fn.glob(vim.fs.joinpath(libs_root, "**", "sdkconfig.h"), false, true)) do
			table.insert(include_dirs, vim.fs.dirname(file))
		end
	end
	for _, dir in ipairs(include_dirs) do
		table.insert(flags, "-isystem")
		table.insert(flags, dir)
	end
	table.insert(flags, "-include")
	table.insert(flags, vim.fs.joinpath(platform, "cores", "esp32", "Arduino.h"))
	return flags
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	priority = 1000,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local ok, installed_parsers = pcall(require("nvim-treesitter").get_installed, "parsers")
		if not ok or not vim.tbl_contains(installed_parsers, "arduino") then
			vim.treesitter.language.register("cpp", "arduino")
		end

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

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
				"--header-insertion=never",
			},
			capabilities = capabilities,
		})

		vim.lsp.config("arduino_fast_clangd", {
			cmd = {
				vim.fs.joinpath(vim.fn.stdpath("config"), "bin", "arduino-clangd"),
				"--background-index=false",
				"--completion-style=detailed",
				"--header-insertion=iwyu",
			},
			cmd_env = {
				NVIM_ARDUINO_CLANGD = executable("clangd"),
				NVIM_ARDUINO_CLANGD_HOME = vim.fn.stdpath("config"),
			},
			filetypes = { "arduino", "ino" },
			root_dir = function(bufnr, on_dir)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local root = vim.fs.root(filename, { "sketch.yaml", ".arduino-fqbn", ".git" })
				on_dir(root or vim.fs.dirname(filename))
			end,
			init_options = {
				fallbackFlags = arduino_fallback_flags(),
			},
			capabilities = capabilities,
		})

		vim.lsp.config("arduino_language_server", {
			cmd = function(dispatchers, config)
				local nvim_config = vim.fn.stdpath("config")
				local cmd = {
					executable("arduino-language-server", "~/go/bin/arduino-language-server"),
					"-cli",
					executable("arduino-cli"),
					"-clangd",
					vim.fs.joinpath(nvim_config, "bin", "arduino-clangd"),
					"-fqbn",
					arduino_fqbn(config.root_dir),
					"-skip-libraries-discovery-on-rebuild",
					"-jobs",
					"0",
				}
				local cli_config = arduino_cli_config()
				if cli_config then
					vim.list_extend(cmd, { "-cli-config", cli_config })
				end
				return vim.lsp.rpc.start(cmd, dispatchers, {
					cwd = config.root_dir,
					env = {
						NVIM_ARDUINO_CLANGD = executable("clangd"),
						NVIM_ARDUINO_CLANGD_HOME = nvim_config,
					},
				})
			end,
			filetypes = { "arduino", "ino" },
			root_dir = function(bufnr, on_dir)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local root = vim.fs.root(filename, { "sketch.yaml", ".arduino-fqbn" })
				on_dir(root or vim.fs.dirname(filename))
			end,
			flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 500,
			},
			on_init = function(client)
				client.server_capabilities.documentHighlightProvider = false
			end,
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
			"arduino_fast_clangd",
		})

		-- インラインヒントを有効化
		vim.lsp.inlay_hint.enable(true)
	end,
}
