#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="https://github.com/mattilaa/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

INSTALL_ALL=false
DO_NVIM=false
DO_TMUX=false
DO_ZSH=false
DO_ALACRITTY=false
DO_FONTS=false

log() { printf "\n==> %s\n" "$*"; }
warn() { printf "\nWARN: %s\n" "$*" >&2; }

usage() {
  cat <<EOF
Usage:
  ./install-mac.sh --all
  ./install-mac.sh --nvim --tmux --zsh --alacritty --fonts

Options:
  --all
  --nvim
  --tmux
  --zsh
  --alacritty
  --fonts
  -h, --help
EOF
}

for arg in "$@"; do
  case "$arg" in
    --all) INSTALL_ALL=true ;;
    --nvim) DO_NVIM=true ;;
    --tmux) DO_TMUX=true ;;
    --zsh) DO_ZSH=true ;;
    --alacritty) DO_ALACRITTY=true ;;
    --fonts) DO_FONTS=true ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg"; usage; exit 1 ;;
  esac
done

if $INSTALL_ALL; then
  DO_NVIM=true
  DO_TMUX=true
  DO_ZSH=true
  DO_ALACRITTY=true
  DO_FONTS=true
fi

if ! $DO_NVIM && ! $DO_TMUX && ! $DO_ZSH && ! $DO_ALACRITTY && ! $DO_FONTS; then
  usage
  exit 1
fi

backup() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "${target}.backup.$(date +%Y%m%d%H%M%S)"
  fi
}

link_force() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    return
  fi

  backup "$target"
  ln -s "$source" "$target"
}

brew_install() {
  for pkg in "$@"; do
    if brew list "$pkg" >/dev/null 2>&1; then
      log "$pkg already installed"
    else
      brew install "$pkg" || warn "Failed to install formula: $pkg"
    fi
  done
}

brew_cask_install() {
  local cask="$1"
  local app_path="${2:-}"

  if brew list --cask "$cask" >/dev/null 2>&1; then
    log "$cask already installed"
    return
  fi

  if [ -n "$app_path" ] && [ -e "$app_path" ]; then
    warn "$app_path already exists; skipping install for $cask"
    return
  fi

  brew install --cask "$cask" || warn "Failed to install cask: $cask"
}

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

clone_dotfiles() {
  if [ ! -d "$DOTFILES_DIR/.git" ]; then
    log "Cloning dotfiles"
    git clone "$REPO_URL" "$DOTFILES_DIR"
  else
    log "Updating dotfiles"
    git -C "$DOTFILES_DIR" pull --ff-only || warn "Could not update repo; continuing with local copy"
  fi
}

patch_nvim_plugins() {
  local plugins="$DOTFILES_DIR/nvim/config/plugins.vim"
  [ -f "$plugins" ] || return

  if grep -q "nvim-gdb.*UpdateRemotePlugins" "$plugins"; then
    log "Patching broken nvim-gdb install hook"
    cp "$plugins" "$plugins.backup.$(date +%Y%m%d%H%M%S)"

    perl -0pi -e \
      "s/Plug 'sakhnik\\/nvim-gdb', \\{ 'do': ':!\\.\\/install\\.sh \\\\| UpdateRemotePlugins' \\}/Plug 'sakhnik\\/nvim-gdb', { 'do': '.\\/install.sh' }/g" \
      "$plugins"
  fi
}

install_vim_plug() {
  local plug_path="$HOME/.local/share/nvim/site/autoload/plug.vim"

  if [ -f "$plug_path" ]; then
    log "vim-plug already installed"
    return
  fi

  log "Installing vim-plug"
  curl -fLo "$plug_path" \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_nvim_plugins_safely() {
  local tmp_init
  tmp_init="$(mktemp)"

  cat > "$tmp_init" <<EOF
set nocompatible
source $DOTFILES_DIR/nvim/config/plugins.vim
EOF

  log "Installing Neovim plugins"

  nvim --headless -Nu "$tmp_init" \
    '+silent! PlugInstall --sync' \
    '+silent! UpdateRemotePlugins' \
    '+qa!' || warn "Some Neovim plugins failed to install"

  rm -f "$tmp_init"
}

write_valid_alacritty_config() {
  local config_dir="$HOME/.config/alacritty"
  local config="$config_dir/alacritty.toml"

  mkdir -p "$config_dir"

  if [ -e "$config" ] || [ -L "$config" ]; then
    backup "$config"
  fi

  log "Writing valid Alacritty config"

  cat > "$config" <<'EOF'
[general]
live_config_reload = true

[colors]
draw_bold_text_with_bright_colors = true

[colors.primary]
background = "#282828"
foreground = "#ebdbb2"

[colors.normal]
black = "#282828"
red = "#cc241d"
green = "#98971a"
yellow = "#d79921"
blue = "#458588"
magenta = "#b16286"
cyan = "#689d6a"
white = "#a89984"

[colors.bright]
black = "#928374"
red = "#fb4934"
green = "#b8bb26"
yellow = "#fabd2f"
blue = "#83a598"
magenta = "#d3869b"
cyan = "#8ec07c"
white = "#ebdbb2"

[font]
size = 15

[font.normal]
family = "Hack Nerd Font"
style = "Regular"

[font.bold]
family = "Hack Nerd Font"
style = "Bold"

[font.italic]
family = "Hack Nerd Font"
style = "Italic"

[font.bold_italic]
family = "Hack Nerd Font"
style = "Bold Italic"

[font.offset]
y = 6
EOF
}

install_fonts() {
  log "Installing fonts"

  brew_cask_install font-hack-nerd-font
  brew_cask_install font-meslo-lg-nerd-font
  brew_cask_install font-jetbrains-mono-nerd-font
}

install_homebrew
brew update || warn "brew update failed; continuing"
brew_install git curl
clone_dotfiles

if $DO_FONTS; then
  install_fonts
fi

if $DO_NVIM; then
  log "Installing Neovim"

  brew_install neovim node ripgrep fd fzf cmake ninja python

  mkdir -p "$HOME/.config"
  link_force "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

  install_vim_plug
  patch_nvim_plugins
  install_nvim_plugins_safely

  log "Neovim setup complete"
fi

if $DO_TMUX; then
  log "Installing tmux"

  brew_install tmux reattach-to-user-namespace

  if [ -f "$DOTFILES_DIR/.tmux.conf" ]; then
    link_force "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
  fi

  mkdir -p "$HOME/.tmux/plugins"

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi

  if [ ! -d "$HOME/.tmux-themepack" ]; then
    git clone https://github.com/jimeh/tmux-themepack.git "$HOME/.tmux-themepack"
  fi

  log "tmux setup complete"
fi

if $DO_ZSH; then
  log "Installing zsh"

  brew_install zsh

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  log "zsh setup complete"
fi

if $DO_ALACRITTY; then
  log "Installing Alacritty"

  brew_cask_install alacritty "/Applications/Alacritty.app"

  # Do not symlink the broken repo config.
  # Instead, create a valid TOML config using the same font and size.
  write_valid_alacritty_config

  log "Alacritty setup complete"
fi

log "Bootstrap complete"

echo
echo "Recommended next steps:"
echo "  nvim"
echo "  :PlugInstall"
echo
echo "  tmux"
echo "  prefix + I"
