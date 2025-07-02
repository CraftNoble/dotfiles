return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
   config = function()
    -- Configurează iconițele și modul de afișare pentru erori/avertismente
    vim.diagnostic.config({
        virtual_text = true, -- Arată eroarea pe linia respectivă
        signs = true,
        underline = true,
        update_in_insert = false,
    })

-- Schimbă iconițele dacă dorești (necesită Nerd Fonts)
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    -- Importuri necesare
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    -- Funcția care va fi apelată la atașarea unui client LSP
    -- Aici pui toate keymap-urile specifice LSP
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
      nmap("gd", vim.lsp.buf.definition, "Go to Definition")
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      -- Adaugă aici alte mapări de taste după preferință
    end

    -- Setează serverele de limbaj pe care le va gestiona mason-lspconfig
    mason_lspconfig.setup({
      ensure_installed = { "pyright" }, -- Adaugă aici și alte LSP-uri, ex: "lua_ls", "bashls"
    })

    -- Configurează pyright (sau alt server)
    lspconfig.pyright.setup({
      on_attach = on_attach,
      settings = {
        python = {
          pythonPath = "/usr/bin/python", -- Sau calea către interpretorul tău dintr-un venv
        },
      },
    })
  end,
}
