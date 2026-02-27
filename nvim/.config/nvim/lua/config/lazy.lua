local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 1. Carrega o core do LazyVim
    { "LazyVim/LazyVim",                                import = "lazyvim.plugins" },

    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" }, -- Útil para configs de TS/Web
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.dart" },

    -- 2. Carrega os EXTRAS oficiais (Ordem correta: antes da sua pasta 'plugins')
    { import = "lazyvim.plugins.extras.lang.clangd" },
    -- Se quiser adicionar outros no futuro (json, docker, etc), coloque aqui embaixo.
    { import = "lazyvim.plugins.extras.coding.blink" },
    -- 3. Carrega suas customizações (Oil, desabilitar Neo-tree, etc)
    { import = "plugins" },
  },
  defaults = {
    -- Plugins em lua/plugins/ serão carregados imediatamente por padrão
    lazy = false,
    version = false, -- usa o commit mais recente
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
