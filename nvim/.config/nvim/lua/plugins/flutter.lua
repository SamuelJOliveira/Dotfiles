return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      lsp = {
        color_indicator = true,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisServerExceptionsIncremental = true,
        },
      },
      debugger = {
        enabled = true,
        register_configurations = function(_)
          require("dap").configurations.dart = {}
          require("dap.ext.vscode").load_launch_json()
        end,
      },
      widget_guides = { enabled = true },
      closing_tags = { enabled = true }, -- Mostra o comentário no fim do widget
    },
  },
}
