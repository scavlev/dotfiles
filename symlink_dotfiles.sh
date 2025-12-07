#!/bin/bash

# zshrc

[ -f ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/zshrc ~/.zshrc

# zsh plugins (antidote)

[ -f ~/.zsh_plugins.txt ] && [ ! -L ~/.zsh_plugins.txt ] && mv ~/.zsh_plugins.txt ~/.zsh_plugins.txt.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/zsh_plugins.txt ~/.zsh_plugins.txt

# bashrc

[ -f ~/.bashrc ] && [ ! -L ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/bashrc ~/.bashrc

# gitconfig

[ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ] && mv ~/.gitconfig ~/.gitconfig.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/gitconfig ~/.gitconfig

# VSC nemo action

mkdir -p ~/.local/share/nemo/actions
ln -sfn $SCRIPT_LOCATION/dotfiles/nemo/vscode.nemo_action ~/.local/share/nemo/actions/vscode.nemo_action

# k9s plugins

mkdir -p ~/.config/k9s
[ -f ~/.config/k9s/plugins.yaml ] && [ ! -L ~/.config/k9s/plugins.yaml ] && mv ~/.config/k9s/plugins.yaml ~/.config/k9s/plugins.yaml.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/k9s/plugins.yaml ~/.config/k9s/plugins.yaml

# VS Code settings

$SCRIPT_LOCATION/apply_vscode_settings.sh

# Link VSCode KIO service menu
mkdir -p ~/.local/share/kio/servicemenus
ln -sf ~/.dotfiles/dotfiles/kio/vscode.desktop ~/.local/share/kio/servicemenus/vscode.desktop
