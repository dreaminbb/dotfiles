return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        input = {
            enabled = true,
        },
        select = {
            enabled = true,
            backend = { "telescope", "builtin" },
            telescope = {
                sorter = nil,
                sorter_opts = {},
            },
            builtin = {
                border = "rounded",
                relative = "cursor",
                width = 80,
                max_width = { 200, 0.8 },
                min_width = { 20, 0.2 },
                height = nil,
                max_height = 0.9,
                min_height = { 10, 0.2 },
                win_options = {
                    winblend = 10,
                },
            },
            format_item_override = {},
            trim_prompt = true,
            get_config = nil,
        },
    },
}
