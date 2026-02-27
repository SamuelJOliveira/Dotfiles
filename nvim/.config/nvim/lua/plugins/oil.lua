return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Alteração 1: Definimos lazy como false para o plugin carregar no boot e capturar diretórios
  lazy = false,
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil (File Explorer)" },
  },
  opts = {
    -- Alteração 2: Garante que ele substitua o explorador padrão (netrw)
    default_file_explorer = true,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = true,
    },
    columns = {
      "icon",
    },
    float = {
      max_width = 0.3,
      max_height = 0.6,
      border = "rounded",
    },
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = true,
      case_insensitive = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },
  },
}
