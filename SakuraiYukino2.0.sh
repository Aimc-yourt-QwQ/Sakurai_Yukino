#!/bin/bash

touch ~/.hushlogin
cd $HOME
pkg install oh-my-posh -y
DEBIAN_FRONTEND=noninteractive apt install -yqq bc
rm -rf ~/Sakurai_Yukino/.git

RESET='\e[0m'
BLOCK='█'
SPACE=' '
# (RGB)
R_BLUE=152; G_BLUE=193; B_BLUE=217 
R_PURP=143; G_PURP=97; B_PURP=219
R_PINK=252; G_PINK=144; B_PINK=175
STEPS=40 

# 快捷
C_BLUE="\e[38;2;${R_BLUE};${G_BLUE};${B_BLUE}m"
C_PURP="\e[38;2;${R_PURP};${G_PURP};${B_PURP}m"
C_PINK="\e[38;2;${R_PINK};${G_PINK};${B_PINK}m"
C_WHITE="\e[38;2;240;240;240m" 

# --- 1. 打印渐变色条函数 ---
print_sakura_gradient() {
    local i RATIO R G B COLOR_CODE
    for ((i=0; i<STEPS; i++)); do
        RATIO=$(echo "scale=4; $i / $STEPS" | bc)
        R=$(echo "($R_BLUE * (1 - $RATIO) + $R_PURP * $RATIO) / 1" | bc); R=${R%.*}
        G=$(echo "($G_BLUE * (1 - $RATIO) + $G_PURP * $RATIO) / 1" | bc); G=${G%.*}
        B=$(echo "($B_BLUE * (1 - $RATIO) + $B_PURP * $RATIO) / 1" | bc); B=${B%.*}
        COLOR_CODE="\e[38;2;${R};${G};${B}m"
        echo -n -e "$COLOR_CODE$BLOCK"
    done
    for ((i=0; i<STEPS; i++)); do
        RATIO=$(echo "scale=4; $i / $STEPS" | bc)
        R=$(echo "($R_PURP * (1 - $RATIO) + $R_PINK * $RATIO) / 1" | bc); R=${R%.*}
        G=$(echo "($G_PURP * (1 - $RATIO) + $G_PINK * $RATIO) / 1" | bc); G=${G%.*}
        B=$(echo "($B_PURP * (1 - $RATIO) + $B_PINK * $RATIO) / 1" | bc); B=${B%.*}
        COLOR_CODE="\e[38;2;${R};${G};${B}m"
        echo -n -e "$COLOR_CODE$BLOCK"
    done
    echo -e "$RESET"
}

# $1: 文本行
# $2: 总长度 
print_sakura_gradient_line() {
    local TEXT="$1"
    local LENGTH=${#TEXT}
    local MAX_LENGTH="$2"
    local i R G B COLOR_CODE RATIO

    local MID_POINT=$(echo "scale=0; $MAX_LENGTH / 2" | bc)

    for ((i=0; i<LENGTH; i++)); do
        local CHAR="${TEXT:i:1}"
        
        # 跳过空格
        if [[ "$CHAR" == " " ]]; then
            echo -n "$SPACE"
            continue
        fi

        # 计算当前字符在整个艺术字中的相对位置 (0到1)
        # 使用当前字符的索引 i
        RATIO=$(echo "scale=4; $i / $MAX_LENGTH" | bc)
        
        if (( i < MID_POINT )); then
            # 第一段渐变：蓝 -> 紫
            local SUB_RATIO=$(echo "scale=4; $i / $MID_POINT" | bc) # 0.0 -> 1.0
            R=$(echo "($R_BLUE * (1 - $SUB_RATIO) + $R_PURP * $SUB_RATIO) / 1" | bc); R=${R%.*}
            G=$(echo "($G_BLUE * (1 - $SUB_RATIO) + $G_PURP * $SUB_RATIO) / 1" | bc); G=${G%.*}
            B=$(echo "($B_BLUE * (1 - $SUB_RATIO) + $B_PURP * $SUB_RATIO) / 1" | bc); B=${B%.*}
        else
            # 第二段渐变：紫 -> 粉
            local SUB_RATIO=$(echo "scale=4; ($i - $MID_POINT) / ($MAX_LENGTH - $MID_POINT)" | bc) # 0.0 -> 1.0
            R=$(echo "($R_PURP * (1 - $SUB_RATIO) + $R_PINK * $SUB_RATIO) / 1" | bc); R=${R%.*}
            G=$(echo "($G_PURP * (1 - $SUB_RATIO) + $G_PINK * $SUB_RATIO) / 1" | bc); G=${G%.*}
            B=$(echo "($B_PURP * (1 - $SUB_RATIO) + $B_PINK * $SUB_RATIO) / 1" | bc); B=${B%.*}
        fi

        COLOR_CODE="\e[38;2;${R};${G};${B}m"
        echo -n -e "$COLOR_CODE$CHAR"
    done
    echo -n -e "$RESET"
}

print_sakura_art() {

    local ART_LINES=(
        "  __,                         __   _                      __     __"
        " (          /               o( /  /       /  o              )   /  )"
        "  \`.  __,  /<  , , _   __, ,  (__/   , , /< ,  _ _   __ .--'   /  /"
        "(___)(_/(_/ |_(_/_/ (_(_/(_(_  _/_  (_/_/ |_(_/ / /_(_)(__   o(__/"
        "                              //"
        "                             (/"
    )

    echo
    
    local MAX_LEN=0
    for line in "${ART_LINES[@]}"; do
        (( ${#line} > MAX_LEN )) && MAX_LEN=${#line}
    done

    for line in "${ART_LINES[@]}"; do
        print_sakura_gradient_line "$line" "$MAX_LEN"
        echo
    done

    echo -e "\n${C_PURP}$PADDING_RIGHT ${C_BLUE}S a k u r a i ${C_PURP}Y u k i n o ${C_PINK}2 . 0 ${C_PURP}${RESET}"
    echo
}


show_menu() {
    clear 
    print_sakura_art 
    
    echo -e " ${C_BLUE}Q)${RESET} $C_PURP 退出程序 ${RESET}\n"
}

handle_input() {
    local choice_trimmed=$(echo "$1" | tr -d '[:space:]') 
    
    if [ -z "$choice_trimmed" ]; then
        return 0 
    fi

    case "$choice_trimmed" in
        1) 
            DEBIAN_FRONTEND=noninteractive apt install -yqq apt git nmap fzf wget unzip fish eza fd nodejs zoxide tree htop openssh tig bat ripgrep jq yq curl ncdu tmux gdb neofetch fastfetch gh proot proot-distro zsh
            neofetch
            echo -e "${C_BLUE} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        2) 
            DEBIAN_FRONTEND=noninteractive apt install -yqq dotnet-sdk-9.0 dotnet-runtime-9.0 dotnet-host-9.0
            echo -e "${C_PURP} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        3)
            DEBIAN_FRONTEND=noninteractive apt install -yqq python python-pip
            echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        4)
            DEBIAN_FRONTEND=noninteractive apt install -yqq openjdk-25
            echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        5)
            DEBIAN_FRONTEND=noninteractive apt install -yqq lua53 lua53-lpeg
            echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        6)
        DEBIAN_FRONTEND=noninteractive apt install -yqq clang sqlite golang rust php
        echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        0)
        DEBIAN_FRONTEND=noninteractive apt install -yqq cmatrix nyancat fortune cowsay sl ninvaders nethack moon-buggy greed tty-solitaire
        echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        7)
        DEBIAN_FRONTEND=noninteractive apt install -yqq build-essential cmake ninja gettext libtool autoconf automake doxygen ncurses-utils gperf pkg-config
        DEBIAN_FRONTEND=noninteractive apt install -yqq neovim
        [ -d ~/.config/nvim ] && rm -rf ~/.config/nvim
        git clone --depth 1 https://github.com/LazyVim/starter ~/.config/nvim
        rm -rf ~/.config/nvim/.git

        if [ -d "$HOME/Sakurai_Yukino" ]; then
        mv "$HOME/Sakurai_Yukino/JetBrainsMonoNerdFont-Italic.ttf" "$HOME/.termux/font.ttf"
        fi
        
        echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
            sleep 1
            ;;
        8)
cat > ~/.bashrc <<'EOF'
neofetch
exec fish
EOF

echo -e "${C_PINK} Sakurai_Yukino: 完成，输入Q或q退出脚本，重启termux，执行剩下的步骤${RESET}"
             sleep 10
             ;;
         9)
         wget http://ohmyposh.dev/install.sh
         bash install.sh
         echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
             sleep 1
             ;;
         10)
cat > ~/.config/fish/config.fish <<'EOF'
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ""
oh-my-posh init fish --config ~/.cache/oh-my-posh/themes/nordtron.omp.json | source

alias v 'nvim'

EOF

cp $HOME/Sakurai_Yukino/dracula $HOME/.termux/colors.properties

echo -e "${C_PINK} Sakurai_Yukino: 完成${RESET}"
              sleep 1
              ;;
        [Qq])
            echo -e "\n${C_PINK}感谢使用 SakuraiYukino2.0${RESET}"
            exit 0
            ;;
        *)
            echo -e "${C_PINK} 无效命令 '$choice_trimmed' ${RESET}"
            sleep 1
            ;;
    esac
    
}

print_sakura_gradient

sleep 2

while true; do
    show_menu
    
    echo -n -e "${C_BLUE}SYukino ${C_PINK}~ ${C_WHITE}> ${RESET}"
    read -r choice 
    
    handle_input "$choice"
done
