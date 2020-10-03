# My Linux configuration

## Neovim

I use [CoC](https://github.com/neoclide/coc.nvim) plugin for developing C++.
[Clangd](https://github.com/clangd/clangd) language server is used for
code autocompletion and jumping to definitions etc.

1. Install [vim-plug](https://github.com/junegunn/vim-plug).
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
2. Install [Node](https://nodejs.org/en/download/).
3. Start Neovim, type :PlugInstall
4. Restart Neovim and type :CocUpdate

## i3

There is not much added to the default configuration.
1. amixer is used for volume control.
2. xbacklight is used for screen backlight control.

## Polybar

Modified version of theme [Polybar-4](https://github.com/adi1090x/polybar-themes#-polybar-4).
Fonts need to be installed from the theme first.

```bash
git clone https://github.com/adi1090x/polybar-themes

cd polybar-themes/polybar-4

cp -r fonts/* ~/.local/share/fonts

fc-cache -v
```

## Tmux

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
2. Install [Tmux Themepack](https://github.com/jimeh/tmux-themepack).
```bash
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
```
3. Run tmux and type Ctrl-b + I (uppercase I).

## Alacritty

I use [Alacritty](https://github.com/alacritty/alacritty) as terminal emulator.

## Other stuff

1. Oh My ZSH. I use zsh and [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh).
```bash
# Install link
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Keyboard fine tuning for better typing experience with Neovim.
```bash
# Set faster typing rate
xset r rate 300 50

# Swap ESC and capslock
setxkbmap -option "caps:swapescape"
```

