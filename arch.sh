#!/bin/bash

#===============================================================================
# Arch Linux System Setup Script
# This script installs and configures essential tools and applications
#===============================================================================

# Determine script location and run dotfiles symlink script
echo "Symlinking dotfiles..."
export SCRIPT_LOCATION=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
$SCRIPT_LOCATION/symlink_dotfiles.sh

#===============================================================================
# Homebrew (Linuxbrew) Setup
#===============================================================================

echo "Configuring Homebrew (Linuxbrew)..."
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# Install Homebrew if not already installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Configure Homebrew
echo "Disabling Homebrew analytics and cleaning up..."
brew analytics off
brew cleanup -s

echo "Installing tools via Homebrew..."
brew install --ignore-dependencies \
  krew \
  kube-ps1 \
  boz/repo/kail \
  velero \
  sdkman/tap/sdkman-cli \
  mise \
  azure-cli \
  cmctl \
  fairwindsops/tap/nova \
  istioctl \
  antidote \
  terragrunt \
  utkuozdemir/pv-migrate/pv-migrate \
  int128/kubelogin/kubelogin \
  k9s

#===============================================================================
# Package Installation (yay)
#===============================================================================

echo "Installing essential packages with yay..."
yay --needed --noconfirm --sync \
  jq \
  yq \
  mc \
  wget \
  httpie \
  htop \
  git \
  docker \
  docker-compose \
  docker-buildx \
  zsh \
  solaar \
  libreoffice-still \
  google-chrome \
  visual-studio-code-bin \
  iso-flag-png \
  baobab \
  plymouth \
  go \
  fzf \
  dive \
  pyenv \
  ansible \
  kubectl \
  helm \
  terraform \
  packer \
  yarn \
  ncdu \
  postman-bin \
  pass \
  mkcert \
  coolercontrol-bin \
  coolercontrold-bin \
  brave-bin

#===============================================================================
# Zsh Configuration
#===============================================================================

echo "Configuring Zsh as default shell if needed..."
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Setting zsh as default shell..."
  sudo chsh -s /bin/zsh $USER
fi

#===============================================================================
# Docker Configuration
#===============================================================================

echo "Configuring Docker group and service..."
sudo groupadd -f docker
sudo usermod -aG docker $USER

# Enable and start Docker service
sudo systemctl enable --now docker.service

#===============================================================================
# Kubernetes Tools
#===============================================================================

echo "Installing Kubernetes tools (kns, ktx)..."
sudo curl -s https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns && \
  sudo chmod +x /usr/local/bin/kns

# Install ktx (Kubernetes context switcher)
sudo curl -s https://raw.githubusercontent.com/blendle/kns/master/bin/ktx -o /usr/local/bin/ktx && \
  sudo chmod +x /usr/local/bin/ktx

#===============================================================================
# Node.js Setup (via mise)
#===============================================================================

echo "Setting up Node.js with mise..."
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
mise use --global node@latest

#===============================================================================
# SDKMAN Setup (Java, Gradle, VisualVM)
#===============================================================================

echo "Configuring SDKMAN and installing Java tools..."
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
source $SDKMAN_DIR/bin/sdkman-init.sh

# Install Java development tools
sdk install java </dev/null
sdk install visualvm </dev/null
sdk install gradle </dev/null

#===============================================================================
# JetBrains Toolbox
#===============================================================================

echo "Checking for JetBrains Toolbox..."
if ! command -v jetbrains-toolbox >/dev/null 2>&1; then
  echo "Installing JetBrains Toolbox..."
  wget -qO- "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA" | \
    sudo tar -xz --strip-components=1 -C /usr/local/bin
fi

#===============================================================================
# VS Code Extensions
#===============================================================================

echo "Installing VS Code extensions..."

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
  --install-extension golang.go \
  --install-extension ms-playwright.playwright \
  --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
