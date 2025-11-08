#bin/bash

cd $HOME
ping -c 5 www.baidu.com
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list && apt update && apt upgrade -y

pkg install -y git nmap fzf wget unzip fish eza fd nodejs zoxide tree htop openssh tig bat ripgrep jq yq curl ncdu tmux gdb neofetch oh-my-posh fastfetch gh proot proot-distro zsh
pkg install -y dotnet-sdk-9.0 dotnet-runtime-9.0 dotnet-host-9.0
pkg install -y python python-pip
pkg install -y openjdk-25
pkg install -y lua53 lua53-lpeg
pkg install -y clang
pkg install -y sqlite
pkg install -y golang
pkg install -y rust
pkg install -y php

sleep 5

cd $HOME/Sakurai_Yukino/

mv JetBrainsMonoNerdFont-Italic.ttf font.ttf
mv font.ttf ~/.termux

cd $HOME

sleep 5

pkg install -y build-essential cmake ninja gettext libtool autoconf automake curl doxygen ncurses-utils gperf pkg-config
pkg install -y neovim

sleep 5

git clone https://github.com/LazyVim/starter ~/.config/nvim

sleep 2

pkg install -y cmatrix nyancat fortune cowsay sl ninvaders nethack moon-buggy greed tty-solitaire 

sleep 1
touch .hushlogin

cat <<EOF > .bashrc
fastfetch
exec fish
EOF
