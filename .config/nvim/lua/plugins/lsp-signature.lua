return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    bind = true, -- Leagă automat triggerele default
    handler_opts = {
      border = "rounded" -- O bordură estetică pentru fereastra de ajutor
    }
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}
