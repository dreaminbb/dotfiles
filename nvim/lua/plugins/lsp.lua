return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Setup Mason first
        require("mason").setup()

        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Capabilities with completion support


        -- Setup Mason-lspconfig with handlers
        mason_lspconfig.setup({
            ensure_installed = {
                "ts_ls",
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "gopls",
                "clangd",
                "cssls",
                "html",
                "jsonls",
                "bashls",
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                -- Specific server configurations
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                },
                            },
                        },
                    })
                end,

                ["ts_ls"] = function()
                    lspconfig.ts_ls.setup({
                        capabilities = capabilities,
                    })
                end,

                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                    })
                end,

                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                procMacro = {
                                    enable = true,
                                },
                            },
                        },
                    })
                end,
            },
        })

        -- Configure diagnostics display
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 4,
            },
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
            },
        })

        -- Configure LSP handlers
        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    end,
}
