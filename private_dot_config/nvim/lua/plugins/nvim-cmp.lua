return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- text in buffer
    "hrsh7th/cmp-path", -- file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- load vscode style snippets from installed plugins
    -- require("lusansip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["C-Space"] = cmp.mapping.complete(), -- show completion suggestions
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      -- sources for autocompletion. Order matters!
      sources = cmp.config.sources({
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text in buffer
        { name = "path" }, -- file system paths
      }),
    })
  end,
}
