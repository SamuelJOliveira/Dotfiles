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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
