return {
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
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
        },
      })
    end,
  },
}
