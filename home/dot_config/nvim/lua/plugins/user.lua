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
        "<Tab>",
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
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "github/copilot.vim", "L3MON4D3/LuaSnip" },
    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        local copilot_keys = vim.fn["copilot#Accept"]()
        if copilot_keys ~= "" and type(copilot_keys) == "string" then
          vim.api.nvim_feedkeys(copilot_keys, "i", true)
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })
    end,
  },
}
