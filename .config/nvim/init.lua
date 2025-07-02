-- ~/.config/nvim/init.lua

-- Setează calea către lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setează opțiunile de bază
require("core.options")
-- Încarcă și configurează plugin-urile
require("lazy").setup("plugins")
