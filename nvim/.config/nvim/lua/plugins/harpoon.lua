return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    require("harpoon").setup({
      tabline = false,
      global_marks = true,
      save_on_toggle = true,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Adicionar ao Harpoon" })
    vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { desc = "Menu Harpoon" })

    vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon File 1" })
    vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon File 2" })
    vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon File 3" })
    vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon File 4" })
    vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, { desc = "Harpoon File 5" })

    vim.keymap.set("n", "<C-S-P>", ui.nav_prev, { desc = "Harpoon Prev" })
    vim.keymap.set("n", "<C-S-N>", ui.nav_next, { desc = "Harpoon Next" })
  end,
}
