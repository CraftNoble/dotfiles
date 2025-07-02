-- ~/.config/nvim/lua/plugins/treesitter.lua (sau similar)
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "bash", "lua", "vim", "vimdoc", "javascript", "html", "css" }, -- Adaugă 'bash'
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
