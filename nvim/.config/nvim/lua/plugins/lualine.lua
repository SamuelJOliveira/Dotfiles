return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_c, {
      function()
        return vim.bo.modified and "●" or ""
      end,
      color = { fg = "#f38ba8" },
    })
  end,
}
