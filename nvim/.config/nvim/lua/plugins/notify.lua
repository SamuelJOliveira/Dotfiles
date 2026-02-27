return {
  "rcarriga/nvim-notify",
  opts = {
    timeout = 3000,
    render = "wrapped-default",
    stages = "fade",
    max_width = 50,
    background_colour = "#000000",
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    -- Isso faz com que o Neovim use o nvim-notify para todas as mensagens do sistema
    vim.notify = notify
  end,
}
