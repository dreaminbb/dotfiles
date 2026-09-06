return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        format_on_save = function()
          return {
            timeout_ms = 1000,
            lsp_format = "fallback",
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt" },
          sh = { "shfmt" },
          toml = { "taplo" },
        },
      })
    end,
  },
}
