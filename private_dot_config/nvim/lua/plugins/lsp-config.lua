return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ansiblels",
          "bashls",
          "gopls",
          "jqls",
          "lua_ls",
          "marksman", -- Markdown
          "taplo",    -- TOML
          "terraformls",
          "tflint",
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.ansiblels.setup({})
      lspconfig.bashls.setup({})
      lspconfig.gopls.setup({})
      lspconfig.jqls.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.marksman.setup({})
      lspconfig.taplo.setup({})
      lspconfig.terraformls.setup({})
      lspconfig.tflint.setup({})
      lspconfig.ts_ls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
