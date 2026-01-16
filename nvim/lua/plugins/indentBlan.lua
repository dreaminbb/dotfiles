-- Simplified indent-blankline (ibl) configuration.
-- Removes custom hooks that caused virt_text errors and relies solely on exclude lists
-- to prevent indent guides from appearing on the dashboard and other special buffers.
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- Load fairly early so other plugins can rely on its highlights if needed.
    event = "BufReadPre",
    opts = {
        scope = {
            enabled = true,
            show_start = true,
            show_end = true,
            highlight = "IblScope",
        },
        -- Exclude dashboard and other side panels / special buffers
        exclude = {
            filetypes = {
                "dashboard",
                "neo-tree",
                "Trouble",
                "help",
                "lazy",
                "mason",
                "notify",
            },
            buftypes = {
                "terminal",
                "nofile",
                "prompt",
                "quickfix",
            },
        },
    },
}
