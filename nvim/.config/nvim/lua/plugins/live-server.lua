return {
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server", -- Instala o binário globalmente se não tiver
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
    keys = {
      { "<leader>ls", "<cmd>LiveServerStart<cr>", desc = "Start Live Server" },
      { "<leader>lS", "<cmd>LiveServerStop<cr>",  desc = "Stop Live Server" },
    },
  },
}
