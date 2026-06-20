#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BLUE='\033[1;34m'; GREEN='\033[1;32m'; YELLOW='\033[1;33m'; RESET='\033[0m'
step()  { echo -e "\n${BLUE}→ $1${RESET}"; }
ok()    { echo -e "  ${GREEN}✓ $1${RESET}"; }
warn()  { echo -e "  ${YELLOW}⚠ $1${RESET}"; }

# ── 1. Dependências ──────────────────────────────────────────────────────
step "Verificando dependências..."
if ! command -v stow &>/dev/null; then
  warn "Stow não encontrado. Instalando..."
  sudo pacman -S --noconfirm stow
fi
ok "Stow disponível"

# ── 2. Pacotes e seus alvos ──────────────────────────────────────────────
declare -A TARGETS=(
  [bash]="$HOME/.bashrc $HOME/.bash_profile"
  [kitty]="$HOME/.config/kitty"
  [nvim]="$HOME/.config/nvim"
  [sway]="$HOME/.config/sway"
  [starship]="$HOME/.config/starship.toml"
  [tmux]="$HOME/.tmux.conf $HOME/.tmux.colors.conf"
  [waybar]="$HOME/.config/waybar"
)

PACKAGES=(bash kitty nvim sway starship tmux waybar)

# ── 3. Remove conflitos ─────────────────────────────────────────────────
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
      warn "Backup: $path -> ${path}.bak"
      mv "$path" "${path}.bak"
    fi
  done
done

# ── 4. Aplica o Stow ────────────────────────────────────────────────────
step "Aplicando symlinks com Stow..."
cd "$DOTFILES"

for pkg in "${PACKAGES[@]}"; do
  stow --restow "$pkg" && ok "$pkg" || warn "$pkg falhou — verifique manualmente"
done

# ── 5. Recarrega em runtime ─────────────────────────────────────────────
step "Recarregando configurações em runtime..."

source "$HOME/.bashrc" 2>/dev/null \
  && ok "bashrc recarregado" \
  || warn "bashrc: rode 'source ~/.bashrc' manualmente"

if command -v tmux &>/dev/null && tmux info &>/dev/null 2>&1; then
  tmux source-file "$HOME/.tmux.conf" 2>/dev/null \
    && ok "tmux recarregado" \
    || warn "tmux: recarregue com 'tmux source-file ~/.tmux.conf'"
else
  warn "tmux: nenhuma sessão ativa"
fi

if pgrep -x waybar &>/dev/null; then
  pkill -x waybar; sleep 0.5
  waybar &>/dev/null & disown
  ok "Waybar reiniciado"
else
  warn "Waybar: será aplicado no próximo início"
fi

if command -v swaymsg &>/dev/null && swaymsg -t get_version &>/dev/null 2>&1; then
  swaymsg reload && ok "Sway recarregado" \
    || warn "Sway: rode 'swaymsg reload' manualmente"
else
  warn "Sway: será aplicado no próximo início"
fi

echo -e "\n${GREEN}✓ Dotfiles aplicados com sucesso!${RESET}"
echo ""
echo "Pacotes recomendados (pacman/yay):"
echo "  sway waybar kitty tmux neovim starship"
echo "  zoxide fzf ripgrep bob-aur"
echo "  mako swaylock swayidle brightnessctl"
echo "  grim slurp wl-clipboard wmenu"
echo "  inter-font ttf-geist-mono-nerd"
