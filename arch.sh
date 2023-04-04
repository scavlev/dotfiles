#!/bin/bash

export SCRIPT_LOCATION=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

$SCRIPT_LOCATION/symlink_dotfiles.sh

yay --needed --noconfirm --sync \
  jq \
  wget \
  httpie \
  htop \
  git \
  docker \
  docker-compose \
  zsh \
  solaar \
  libreoffice-still \
  google-chrome \
  visual-studio-code-bin \
  plank

# Linuxbrew

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

command -v brew >/dev/null 2>&1 || {
  echo >&2 "Installing Homebrew"
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

brew analytics off
brew cleanup -s

brew install \
  git \
  fzf \
  dive \
  kubernetes-cli \
  helm \
  awscli \
  krew \
  k9s \
  kube-ps1 \
  boz/repo/kail \
  velero \
  yarn \
  pyenv \
  ansible \
  packer \
  terraform \
  terragrunt \
  go \
  sdkman/tap/sdkman-cli \
  asdf \
  azure-cli \
  yq \
  cmctl

brew remove --ignore-dependencies -f \
  pkg-config

# Zsh

sudo chsh -s /bin/zsh $USER

echo "skip_global_compinit=1" >~/.zshenv

bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions pull || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting pull || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sdkman pull || git clone --depth 1 https://github.com/matthieusb/zsh-sdkman.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sdkman

# Docker

sudo groupadd -f docker
sudo usermod -aG docker $USER

sudo systemctl enable --now docker.service

# Kube

sudo curl -s https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns && sudo chmod +x $_
sudo curl -s https://raw.githubusercontent.com/blendle/kns/master/bin/ktx -o /usr/local/bin/ktx && sudo chmod +x $_

# Node

source $(brew --prefix asdf)/libexec/asdf.sh

rm -f ~/.asdf/shims/*
asdf reshim

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest
npm install -g npm

# Sdkman

export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
source $SDKMAN_DIR/bin/sdkman-init.sh

sdk install java </dev/null
sdk install visualvm </dev/null
sdk install gradle </dev/null

# JetBrains toolbox

command -v jetbrains-toolbox >/dev/null 2>&1 || {
  wget -qO- "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA" | sudo tar -xz --strip-components=1 -C /usr/local/bin
}

# Vscode plugins

code --force \
  --install-extension editorconfig.editorconfig \
  --install-extension formulahendry.auto-rename-tag \
  --install-extension dbaeumer.vscode-eslint \
  --install-extension eamodio.gitlens \
  --install-extension ritwickdey.liveserver \
  --install-extension esbenp.prettier-vscode \
  --install-extension foxundermoon.shell-format \
  --install-extension ms-azuretools.vscode-docker \
  --install-extension ms-vscode-remote.remote-containers \
  --install-extension hashicorp.terraform \
  --install-extension wix.vscode-import-cost \
  --install-extension pkief.material-icon-theme \
  --install-extension formulahendry.code-runner \
  --install-extension formulahendry.terminal \
  --install-extension mike-co.import-sorter \
  --install-extension golang.go
