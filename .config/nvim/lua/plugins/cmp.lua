-- ~/.config/nvim/lua/plugins/cmp.lua

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Sursa pentru sugestii de la Language Server Protocol (LSP)
    "hrsh7th/cmp-nvim-lsp",

    -- Sursa pentru sugestii din buffer-ul curent (cuvinte deja scrise)
    "hrsh7th/cmp-buffer",

    -- Sursa pentru sugestii de căi din sistemul de fișiere
    "hrsh7th/cmp-path",

    -- Motorul pentru snippets (fragmente de cod reutilizabile)
    "L3MON4D3/LuaSnip",

    -- Sursa pentru a integra snippets în nvim-cmp
    "saadparwaiz1/cmp_luasnip",

    -- (Opțional) Adaugă iconițe sugestiilor (necesită Nerd Fonts)
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    --
    -- SETUP nvim-cmp
    --
    cmp.setup({
      -- Configurează integrarea cu snippets
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- Maparea tastelor pentru a interacționa cu meniul de autocompletare
      mapping = cmp.mapping.preset.insert({
        -- Navigare în meniu
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        -- Scroll prin documentația sugestiei selectate
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Acceptarea sugestiei
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Pornirea manuală a autocompletării
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Ieșire din meniul de autocompletare
        ["<C-e>"] = cmp.mapping.abort(),
      }),

      -- Sursele de unde nvim-cmp își va lua sugestiile, în ordinea priorității
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),

      -- Sortarea sugestiilor pentru a le afișa pe cele mai relevante primele
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,

          -- Funcție personalizată pentru a trimite la final sugestiile "private" (care încep cu _)
          function(entry1, entry2)
            local a = entry1:get_completion_item().label
            local b = entry2:get_completion_item().label
            local a_is_private = string.sub(a, 1, 1) == '_'
            local b_is_private = string.sub(b, 1, 1) == '_'

            if a_is_private and not b_is_private then
              return false -- Trimite sugestia 'a' la final
            elseif not a_is_private and b_is_private then
              return true -- Păstrează sugestia 'a' în față
            end
          end,

          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.recently_used,
        },
      },

      -- Formatarea vizuală a meniului de sugestii
      formatting = {
        -- Adaugă iconițe și etichete pentru a identifica sursa
        format = lspkind.cmp_format({
          mode = "symbol_text", -- Afișează iconița și textul (ex: 󰊕 Function)
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          },
        }),
      },

      -- (Opțional) Funcționalități experimentale
      experimental = {
        -- Afișează text transparent (ghost text) cu sugestia cea mai probabilă
        ghost_text = true,
      },
    })
  end,
}
