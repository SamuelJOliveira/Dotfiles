return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    -- Space should never accept a completion
    opts.keymap = opts.keymap or {}
    opts.keymap["<Space>"] = { "fallback" }
    opts.keymap["<CR>"] = { "fallback" }

    -- Remove friendly-snippets (snippets source), keep lsp/path/buffer
    opts.sources = opts.sources or {}
    opts.sources.default = { "lsp", "path", "buffer" }
  end,
}
