---@type LazySpec
return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      -- disable copilot.vim's own <Tab> map; nvim-cmp's mapping (below) handles
      -- Copilot accept so the two plugins don't fight over the same key
      vim.g.copilot_no_tab_map = true
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
    -- AstroNvim v6 default completion engine (replaces nvim-cmp). Core already
    -- binds <Up>/<Down> to select_prev/select_next, so candidate selection
    -- stays off <Tab>; we only override <Tab> to prioritize Copilot accept.
    "saghen/blink.cmp",
    dependencies = { "github/copilot.vim" },
    opts = function(_, opts)
      opts.keymap["<Tab>"] = {
        function(_)
          local copilot_keys = vim.fn["copilot#Accept"]()
          if copilot_keys ~= "" and type(copilot_keys) == "string" then
            vim.api.nvim_feedkeys(copilot_keys, "i", true)
            return true
          end
        end,
        "snippet_forward",
        "fallback",
      }
    end,
  },
}
