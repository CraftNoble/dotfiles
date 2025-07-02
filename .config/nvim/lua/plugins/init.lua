-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- Tema de culori - trebuie încărcată prima
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  -- Bara de stare
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },

  -- File explorer
  { "nvim-tree/nvim-tree.lua" },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Sintaxă avansată
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- =========== GRUPUL LSP (AICI ESTE CHEIA) ===========
  {
    "williamboman/mason.nvim",
    config = function()
      -- Acest 'config' asigură că Mason este gata de utilizare
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- Asigură-te că se încarcă după mason
    dependencies = { "williamboman/mason.nvim" },
  },
  { "neovim/nvim-lspconfig" },
  -- =======================================================


  -- Auto-completare
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
}
