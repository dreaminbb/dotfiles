-- telescope設定は元のまま
return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- layout_strategy = "flex",
                -- sorting_strategy = "ascending",
                -- previewer = false,
                -- path_display = { "truncate" },
                -- layout_config = {
                --     prompt_position = "bottom",
                --     width = 0.8,
                --     height = 0.6,
                --     horizontal = { preview_width = 0.45 },
                --     vertical = { preview_height = 0.5 },
                -- },
                file_ignore_patterns = {
                    "^%.:.*",
                    "%.%d+$",
                    "%.tmp$",
                    "%.swp$",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    show_all_buffers = false,
                    mappings = {
                        i = {
                            ["<c-d>"] = "delete_buffer",
                        },
                    },
                },
            },
            extensions = {
                ["ui-select"] = require("telescope.themes").get_dropdown({ previewer = false }),
            },
        })
        telescope.load_extension("ui-select")

        -- カスタムコマンドを作成
        vim.api.nvim_create_user_command("TelescopeBuffersClean", function()
            -- 不要なバッファーを削除
            local buffers = vim.api.nvim_list_bufs()
            for _, buf in ipairs(buffers) do
                if vim.api.nvim_buf_is_valid(buf) then
                    local name = vim.api.nvim_buf_get_name(buf)
                    local filename = vim.fn.fnamemodify(name, ":t")
                    if filename:match("^%.:") or filename:match("%.%d+$") then
                        pcall(vim.api.nvim_buf_delete, buf, { force = true })
                    end
                end
            end
            -- Telescopeを実行
            require("telescope.builtin").buffers()
        end, {})
    end,
}
