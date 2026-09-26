return {
  {
    "folke/snacks.nvim",
    opts = {
      image = { enabled = false }, -- snacks.image を無効化
    },
  },
  {
    "princejoogie/chafa.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
    config = function()
      require("chafa").setup({
        render = {
          min_padding = 5,
          show_label = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      })

      vim.api.nvim_create_autocmd("BufReadCmd", {
        pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.ico", "*.svg" },
        callback = function(args)
          vim.bo[args.buf].buftype = "nofile"
          vim.bo[args.buf].readonly = true

          vim.schedule(function()
            vim.cmd("ViewImage")
          end)
        end,
      })
    end,
  }
}
