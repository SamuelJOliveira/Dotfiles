return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "html-lsp",                   -- LSP para HTML
        "css-lsp",                    -- LSP para CSS
        "typescript-language-server", -- LSP para TS (v2)
        "emmet-ls",                   -- O Emmet como servidor de linguagem
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "html", "css" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
        emmet_ls = {
          filetypes = {
            "html", "typescriptreact", "javascriptreact",
            "css", "sass", "scss", "less", "eruby"
          },
        },
      },
    },
  },
}
