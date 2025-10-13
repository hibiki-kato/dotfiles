-- ~/.config/nvim/init.lua

-- 基本オプション（最低限）
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true

-- ★ Insertモードで "jj" を ESC に
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- lazy.nvim bootstrap（無ければ自動取得）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン読込
require("lazy").setup("plugins")

-- LuaSnip の最低限キーマップ（Tabで展開/ジャンプ、Shift-Tabで逆ジャンプ）
local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "<Tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    return "<Tab>"
  end
end, {expr=true, silent=true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  else
    return "<S-Tab>"
  end
end, {expr=true, silent=true})