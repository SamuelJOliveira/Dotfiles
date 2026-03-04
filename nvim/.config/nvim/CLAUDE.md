# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration built on [LazyVim](https://www.lazyvim.org/). It uses `lazy.nvim` as the plugin manager and is written entirely in Lua.

## Plugin Management

Plugins are loaded in `lua/config/lazy.lua` in this order:
1. LazyVim core (`LazyVim/LazyVim`)
2. Official LazyVim language extras (TypeScript, JSON, Tailwind, Dart, clangd)
3. Official LazyVim coding extras (blink completion)
4. Custom plugins from `lua/plugins/` (auto-imported)

To add a new plugin, create a file in `lua/plugins/` returning a plugin spec table. To add a LazyVim extra, add an `{ import = "lazyvim.plugins.extras...." }` entry in `lazy.lua`.

## Structure

- `init.lua` — Entry point, just `require("config.lazy")`
- `lua/config/` — Core config: `lazy.lua` (plugin manager), `options.lua`, `keymaps.lua`, `autocmds.lua`
- `lua/plugins/` — One file per plugin or feature group; each returns a lazy.nvim spec
- `plugin/after/` — Post-load Lua run after all plugins (used for transparency/highlight overrides)
- `stylua.toml` — Formatting: 2-space indent, 120-char column width

## Key Plugins and Conventions

- **File explorer**: `oil.nvim` (Neo-tree and Bufferline are disabled in `disabled.lua`)
- **Quick navigation**: `harpoon` — `<leader>a` add, `<leader>h` menu, `<leader>1-5` jump
- **Themes**: 13+ colorschemes loaded lazily in `all-themes.lua` (priority 1000)
- **Transparency**: Highlight group overrides live in `plugin/after/transparency.lua`

## Formatting

Format Lua files with:
```
stylua lua/
```

The `stylua.toml` at the repo root defines the style rules used throughout.

## Extending Plugin Options

When overriding LazyVim plugin defaults, prefer extending rather than replacing:

```lua
opts = function(_, opts)
  vim.list_extend(opts.ensure_installed, { "your_parser" })
end
```

## Disabling Plugins

Use `lua/plugins/disabled.lua` to disable built-in LazyVim plugins by returning `{ enabled = false }` specs.

## Language Support

Active language extras:
- **TypeScript/Web**: TypeScript, JSON, Tailwind, html-lsp, css-lsp, emmet-ls (via `web.lua`)
- **C/C++**: clangd extra + clang-format (via `cpp.lua`)
- **Flutter/Dart**: dart extra + flutter-tools (via `flutter.lua`)
