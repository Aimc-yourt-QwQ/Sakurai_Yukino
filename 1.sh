#bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

cd "$HOME"
ping -c 3 www.baidu.com >/dev/null && echo "✓ 网络 OK" || { echo "✗ 没网，退出"; exit 1; }

sed -i '/^deb.*termux.*stable main/s/^/# &/' "$PREFIX/etc/apt/sources.list"
grep -q 'mirrors.tuna.tsinghua.edu.cn' "$PREFIX/etc/apt/sources.list" || \
echo 'deb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main' >> "$PREFIX/etc/apt/sources.list"

apt update -qq
apt -o DPkg::Options::="--force-confnew" upgrade -y -qq

apt install -y -qq git nmap fzf wget unzip fish eza fd nodejs zoxide tree htop openssh tig bat ripgrep jq yq curl ncdu tmux gdb neofetch oh-my-posh fastfetch gh proot proot-distro zsh
apt install -y -qq dotnet-sdk-9.0 dotnet-runtime-9.0 dotnet-host-9.0
apt install -y -qq python python-pip
apt install -y -qq openjdk-25
apt install -y -qq lua53 lua53-lpeg
apt install -y -qq clang sqlite golang rust php

apt install -y -qq cmatrix nyancat fortune cowsay sl ninvaders nethack moon-buggy greed tty-solitaire

apt install -y -qq build-essential cmake ninja gettext libtool autoconf automake doxygen ncurses-utils gperf pkg-config
apt install -y -qq neovim
[ -d ~/.config/nvim ] && rm -rf ~/.config/nvim
git clone --depth 1 https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo ">>>> 配置字体..."
if [ -d "$HOME/Sakurai_Yukino" ]; then
    mv "$HOME/Sakurai_Yukino/JetBrainsMonoNerdFont-Italic.ttf" "$HOME/.termux/font.ttf"
fi

touch ~/.hushlogin
cat > ~/.bashrc <<'EOF'
fastfetch
exec fish
EOF

neofetch
