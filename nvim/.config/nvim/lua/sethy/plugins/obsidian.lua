return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        keys = {
            { "<leader>od", "<cmd>Obsidian today<CR>", desc = "Open daily note" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = function()
            return require("sethy.obsidian").opts()
        end,
    },
}
