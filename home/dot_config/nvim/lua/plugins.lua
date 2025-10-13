-- ~/.config/nvim/lua/plugins.lua
return {
  -- スニペット本体
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp", -- 省略可（正規表現強化）
    config = function()
      local ls = require("luasnip")
      -- VSCode形式スニペットを読み込む（friendly + 自作）
      require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    end,
    dependencies = {
      -- 有名どころの大量スニペット集（任意）
      "rafamadriz/friendly-snippets",
    },
  },
}