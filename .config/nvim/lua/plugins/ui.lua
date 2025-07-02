-- ~/.config/nvim/lua/plugins/ui.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end
  },
  {
    "catppuccin/nvim",
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },
}
