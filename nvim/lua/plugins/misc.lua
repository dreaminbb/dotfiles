return {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { -- Adds
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    { "MunifTanjim/nui.nvim" },

    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {        -- set to setup table
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = true, -- "Name" codes like Blue
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes: foreground, background
            mode = "background", -- Set the display mode.
        },
    },

    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                    javascript = { "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt", "vim" },
                enable_check_bracket_line = false,
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            if cmp then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false, -- Auto close on trailing </
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = true,
                    },
                    ["javascript"] = {
                        enable_close = true,
                    },
                    ["typescript"] = {
                        enable_close = true,
                    },
                    ["javascriptreact"] = {
                        enable_close = true,
                    },
                    ["typescriptreact"] = {
                        enable_close = true,
                    },
                },
            })
        end,
    },

    {
        "mattn/emmet-vim",
        ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        config = function()
            vim.g.user_emmet_mode = "n" -- only enable normal mode functions
            vim.g.user_emmet_leader_key = "<C-z>"
            vim.g.user_emmet_settings = {
                variables = { lang = "ja" },
                html = {
                    default_attributes = {
                        option = { value = nil },
                        textarea = { id = nil, name = nil, cols = 10, rows = 10 },
                    },
                    snippets = {
                        ["html:5"] = "<!DOCTYPE html>\n"
                            .. '<html lang="ja">\n'
                            .. "<head>\n"
                            .. '\t<meta charset="UTF-8">\n'
                            .. '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
                            .. "\t<title>${1}</title>\n"
                            .. "</head>\n"
                            .. "<body>\n\t${2}\n</body>\n"
                            .. "</html>",
                    },
                },
            }
        end,
    },
}
