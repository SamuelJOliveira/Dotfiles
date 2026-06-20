# Dotfiles

Arch Linux dotfiles gerenciadas com [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

| Componente | Ferramenta |
|------------|------------|
| WM | Sway (Wayland) |
| Terminal | Kitty |
| Shell | Bash + Starship |
| Editor | Neovim (Lazy.nvim) |
| Multiplexer | Tmux |
| Bar | Waybar |
| Notifications | Mako |

## Instalação

```bash
git clone https://github.com/SamuelJOliveira/Dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Estrutura

Cada diretório raiz é um pacote Stow que espelha `$HOME`:

```
bash/           -> ~/.bashrc, ~/.bash_profile
kitty/          -> ~/.config/kitty/
nvim/           -> ~/.config/nvim/
sway/           -> ~/.config/sway/
starship/       -> ~/.config/starship.toml
tmux/           -> ~/.tmux.conf, ~/.tmux.colors.conf
waybar/         -> ~/.config/waybar/
```

## Pacotes necessários

```bash
sudo pacman -S sway waybar kitty tmux neovim starship zoxide fzf ripgrep stow
sudo pacman -S mako swaylock swayidle brightnessctl grim slurp wl-clipboard wmenu
yay -S bob-aur
```
