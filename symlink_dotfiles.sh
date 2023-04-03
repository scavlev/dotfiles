#!/bin/bash

# zshrc

[ -f ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/zshrc ~/.zshrc

# bashrc

[ -f ~/.bashrc ] && [ ! -L ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/bashrc ~/.bashrc

# gitconfig

[ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ] && mv ~/.gitconfig ~/.gitconfig.bak
ln -sfn $SCRIPT_LOCATION/dotfiles/gitconfig ~/.gitconfig

# VSC settings

mkdir -p ~/.config/Code/User
vscodeSettingsFile="${HOME}/.config/Code/User/settings.json"
[ -f "$vscodeSettingsFile" ] && [ ! -L "$vscodeSettingsFile" ] && mv "$vscodeSettingsFile" "${vscodeSettingsFile}.bak"
ln -sfn $SCRIPT_LOCATION/dotfiles/settings.json "$vscodeSettingsFile"

# VSC nemo action

mkdir -p ~/.local/share/nemo/actions
ln -sfn $SCRIPT_LOCATION/dotfiles/nemo/vscode.nemo_action ~/.local/share/nemo/actions/vscode.nemo_action
