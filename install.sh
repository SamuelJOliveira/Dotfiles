#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Cores ──────────────────────────────────────────────────────────────────
BLUE='\033[1;34m'; GREEN='\033[1;32m'; YELLOW='\033[1;33m'; RESET='\033[0m'
step()  { echo -e "\n${BLUE}→ $1${RESET}"; }
ok()    { echo -e "  ${GREEN}✓ $1${RESET}"; }
warn()  { echo -e "  ${YELLOW}⚠ $1${RESET}"; }

# ── 1. Dependências ────────────────────────────────────────────────────────
step "Verificando dependências..."
if ! command -v stow &>/dev/null; then
  warn "Stow não encontrado. Instalando..."
  sudo pacman -S --noconfirm stow
fi
ok "Stow disponível"

# ── 2. Mapeamento de conflitos por pacote ──────────────────────────────────
# Cada entrada lista os caminhos reais que o stow vai querer ocupar.
# NÃO inclua arquivos que são symlinks de tema do Omarchy (hyprlock.conf, waybar/style.css)

declare -A TARGETS=(
  [ghostty]="$HOME/.config/ghostty"
  [hypr]="$HOME/.config/hypr/hyprland.conf $HOME/.config/hypr/input.conf $HOME/.config/hypr/monitors.conf $HOME/.config/hypr/looknfeel"
  [nvim]="$HOME/.config/nvim"
  [tmux]="$HOME/.config/tmux $HOME/.tmux.conf"
  [waybar]="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"
  [zen]="$HOME/.config/zen/installs.ini $HOME/.config/zen/profiles.ini"
  [bash]="$HOME/.bashrc"
)

PACKAGES=(ghostty hypr nvim tmux waybar zen bash)

# ── 3. Remove conflitos (só se não for já nosso symlink) ──────────────────
step "Verificando e removendo conflitos..."

for pkg in "${PACKAGES[@]}"; do
  for path in ${TARGETS[$pkg]}; do
    if [ -L "$path" ]; then
      target="$(readlink -f "$path" 2>/dev/null || true)"
      if [[ "$target" == "$DOTFILES"* ]]; then
        ok "$path já aponta para dotfiles, pulando"
        continue
      else
        warn "Removendo symlink antigo: $path"
        rm -f "$path"
      fi
    elif [ -e "$path" ]; then
      warn "Removendo arquivo/pasta existente: $path"
      rm -rf "$path"
    fi
  done
done

# ── 4. Aplica o Stow ───────────────────────────────────────────────────────
step "Aplicando symlinks com Stow..."
cd "$DOTFILES"

for pkg in "${PACKAGES[@]}"; do
  stow --restow "$pkg" && ok "$pkg" || warn "$pkg falhou — verifique manualmente"
done

# ── Recria symlinks dependentes do usuário ────────────────────────────────
step "Recriando symlinks do Omarchy no nvim..."
THEME_LINK="$HOME/.config/nvim/lua/plugins/theme.lua"
THEME_TARGET="$HOME/.config/omarchy/current/theme/neovim.lua"

if [ -f "$THEME_TARGET" ]; then
  ln -sf "$THEME_TARGET" "$THEME_LINK"
  ok "theme.lua recriado"
else
  warn "theme.lua: alvo não encontrado em $THEME_TARGET, aplique um tema pelo menu do Omarchy"
fi

# ── 5. Recarrega em runtime ────────────────────────────────────────────────
step "Recarregando configurações em runtime..."

# Bash
# shellcheck disable=SC1090
source "$HOME/.bashrc" 2>/dev/null \
  && ok "bashrc recarregado" \
  || warn "bashrc: rode 'source ~/.bashrc' manualmente"

# Tmux (só se houver sessão ativa)
if command -v tmux &>/dev/null && tmux info &>/dev/null 2>&1; then
  # Determina qual arquivo de config usar (preferência: ~/.config/tmux/tmux.conf)
  TMUX_CONF="$HOME/.config/tmux/tmux.conf"
  [ ! -f "$TMUX_CONF" ] && TMUX_CONF="$HOME/.tmux.conf"
  tmux source-file "$TMUX_CONF" 2>/dev/null \
    && ok "tmux recarregado" \
    || warn "tmux: recarregue com 'tmux source-file $TMUX_CONF'"
else
  warn "tmux: nenhuma sessão ativa"
fi

# Hyprland
if command -v hyprctl &>/dev/null && hyprctl version &>/dev/null 2>&1; then
  hyprctl reload && ok "Hyprland recarregado" \
    || warn "Hyprland: não foi possível recarregar"
else
  warn "Hyprland: rode 'hyprctl reload' quando estiver no ambiente gráfico"
fi

# Waybar
if pgrep -x waybar &>/dev/null; then
  pkill -x waybar; sleep 0.5
  waybar &>/dev/null & disown
  ok "Waybar reiniciado"
else
  warn "Waybar: será aplicado no próximo início"
fi

warn "Ghostty e Zen: precisam ser reiniciados manualmente"

echo -e "\n${GREEN}✓ Dotfiles aplicados com sucesso!${RESET}"
