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
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- on_attach: set up keymaps when LSP attaches to buffer
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end

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
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                -- Specific server configurations
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
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
                        on_attach = on_attach,
                    })
                end,

                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
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
