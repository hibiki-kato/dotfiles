---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "html", "latex", "markdown", "markdown_inline", "typst", "yaml" })
      return opts
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
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require("astronvim.plugins.configs.luasnip")(plugin, opts)
      -- load custom snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    end,
  },
}
