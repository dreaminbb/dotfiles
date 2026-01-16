---@diagnostic disable: undefined-global
-- Neo-tree plugin specification
-- 起動時は dashboard-nvim だけ表示し、必要になった時 (<leader>t) に初めて読み込む構成
-- ポイント:
--  1. event を使わず cmd / keys で遅延ロード
--  2. 最初のバッファ (dashboard / 無名バッファ) では reveal しても意味がないので状況に応じて動作を分岐
--  3. すでに Neo-tree が開いている場合は閉じる (トグル動作)
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" }, -- コマンド実行時にロード
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    -- キーマップで遅延ロード+トグル
    keys = {
        {
            "<leader>t",
            function()
                -- 既にロードされていなければ最初の呼び出しで reveal (読み込み + 表示)
                if not package.loaded["neo-tree"] then
                    -- dashboard で押した場合は単純表示にしておく
                    local ft = vim.bo.filetype
                    if ft == "dashboard" or vim.api.nvim_buf_get_name(0) == "" then
                        vim.cmd("Neotree toggle left")
                    else
                        vim.cmd("Neotree reveal left")
                    end
                    return
                end

                -- 既にロード済み: neo-tree ウィンドウがあれば閉じる / なければ reveal
                local neo_tree_is_open = false
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                    if ft == "neo-tree" then
                        neo_tree_is_open = true
                        break
                    end
                end

                if neo_tree_is_open then
                    vim.cmd("Neotree close")
                else
                    -- 現在のバッファにファイルパスがない (無題 / dashboard 等) 場合は reveal してもフォーカス先がないので toggle
                    local name = vim.api.nvim_buf_get_name(0)
                    local ft = vim.bo.filetype
                    if name == "" or ft == "dashboard" then
                        vim.cmd("Neotree toggle left")
                    else
                        vim.cmd("Neotree reveal left")
                    end
                end
            end,
            desc = "Neo-tree toggle / reveal",
        },
    },

    config = function()
        -- 余計な自動ハイジャックを無効化して起動時干渉を回避
        require("neo-tree").setup({
            -- netrw 乗っ取りで起動直後に表示されるのを防ぎたいので disabled
            filesystem = {
                hijack_netrw_behavior = "disabled",
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = { ".DS_Store" },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = true,
                use_libuv_file_watcher = true,
            },
            default_component_configs = {
                indent = {
                    padding = 0,
                    with_markers = true,
                    indent_size = 2,
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                },
                git_status = {
                    symbols = {
                        added     = "A",
                        modified  = "M",
                        deleted   = "D",
                        renamed   = "R",
                        untracked = "?",
                        ignored   = "I",
                        unstaged  = "",
                        staged    = "S",
                        conflict  = "",
                    },
                },
            },
            window = {
                position = "left",
                width = 32,
                mappings = {
                    ["<space>"] = "toggle_node",
                    ["<cr>"] = "open",
                    ["o"] = "open",
                    ["s"] = "open_split",
                    ["v"] = "open_vsplit",
                    ["C"] = "close_node",
                    ["R"] = "refresh",
                    ["q"] = "close_window",
                },
            },
            source_selector = {
                winbar = false,
                statusline = false,
            },
            enable_diagnostics = true,
            log_level = "warn",
        })

        -- Dashboard 起動直後に勝手に開かないように何も追加 hook しない
        -- 必要なら Dashboard ロード後に自動で開く例:
        -- vim.api.nvim_create_autocmd("User", {
        --   pattern = "DashboardLoaded",
        --   callback = function()
        --     -- vim.defer_fn(function() vim.cmd("Neotree focus left") end, 150)
        --   end,
        -- })
    end,
}
