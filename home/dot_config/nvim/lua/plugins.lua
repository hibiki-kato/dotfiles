-- ~/.config/nvim/lua/plugins.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "html",
        "latex",
        "markdown",
        "markdown_inline",
        "typst",
        "yaml",
      },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      local install = require("nvim-treesitter.install")
      install.ts_generate_args = { "generate", "--abi", vim.treesitter.language_version }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },

  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set(
        "i",
        "<C-J>",
        'copilot#Accept("\\<CR>")',
        { expr = true, replace_keycodes = false, silent = true }
      )
    end,
  },

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
