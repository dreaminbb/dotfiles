return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = function()
      if vim.fn.executable("make") == 1 then
        return "make install_jsregexp"
      end
      return nil
    end,
    lazy = true,
  },
}
