#!/bin/bash

# Colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
rest='\033[0m'

# Check Dependencies build
check_dependencies_build() {
    local dependencies=("curl" "wget" "git" "golang")

    for dep in "${dependencies[@]}"; do
        if ! dpkg -s "${dep}" &> /dev/null; then
            echo -e "${yellow}${dep} is not installed. Installing...${rest}"
            pkg install "${dep}" -y
        fi
    done
}

# Check Dependencies
check_dependencies() {
    local dependencies=("curl" "openssl-tool" "wget" "unzip")

    for dep in "${dependencies[@]}"; do
        if ! dpkg -s "${dep}" &> /dev/null; then
            echo -e "${yellow}${dep} is not installed. Installing...${rest}"
            pkg install "${dep}" -y
        fi
    done
}

# Build
build() {
    if command -v warp-plus &> /dev/null || command -v usef &> /dev/null; then
        echo -e "${green}warp-plus is already installed.${rest}"
        return
    fi

    echo -e "${green}Installing warp-plus...${rest}"
    pkg update -y && pkg upgrade -y
    check_dependencies_build

    if git clone https://github.com/bepass-org/warp-plus-plus.git &&
        cd warp-plus-plus &&
        go build main.go &&
        chmod +x main &&
        cp main "$PREFIX/bin/usef" &&
        cp main "$PREFIX/bin/warp-plus-plus"; then
        echo -e "${green}warp-plus installed successfully.${rest}"
    else
        echo -e "${red}Error installing WireGuard VPN.${rest}"
    fi
}

# Install
install() {
    if command -v warp-plus &> /dev/null || command -v usef &> /dev/null; then
        echo -e "${green}warp-plus is already installed.${rest}"
        return
    fi

    echo -e "${green}Installing warp-plus...${rest}"
    pkg update -y && pkg upgrade -y
    pacman -Syu openssh = apt update; apt full-upgrade -y; apt install -y openssh
    check_dependencies

    if wget https://github.com/bepass-org/warp-plus-plus/releases/download/v1.1.0/warp-plus-plus-android-arm64.cdb551.zip &&
        unzip warp-plus-plus-android-arm64.cdb551.zip &&
        chmod +x warp-plus-plus &&
        cp warp-plus "$PREFIX/bin/usef" &&
        cp warp-plus "$PREFIX/bin/warp-plus-plua"; then
        rm "README.md" "LICENSE" "warp-plus-plus-android-arm64.cdb551.zip"
        echo "================================================"
        echo -e "${green}warp-plus installed successfully.${rest}"
        socks
    else
        echo -e "${red}Error installing warp-plus.${rest}"
    fi
}

# Install arm
install_arm() {
    if command -v warp-plus &> /dev/null || command -v usef &> /dev/null; then
        echo -e "${green}warp-plus is already installed.${rest}"
        return
    fi

    echo -e "${green}Installing warp-plus...${rest}"
    pkg update -y && pkg upgrade -y
    pacman -Syu openssh = apt update; apt full-upgrade -y; apt install -y openssh
    check_dependencies

    # Determine architecture
    case "$(dpkg --print-architecture)" in
        i386) ARCH="386" ;;
        amd64) ARCH="amd64" ;;
        armhf) ARCH="arm5" ;;
        arm) ARCH="arm7" ;;
        aarch64) ARCH="arm64" ;;
        *) echo -e "${red}Unsupported architecture.${rest}"; return ;;
    esac

    warp-plus_URL="https://github.com/bepass-org/warp-plus-plus/releases/download/v1.1.0/warp-plus-linux-$ARCH.cdb551.zip"

    if wget "$warp-plus_URL" &&
        unzip "warp-plus-linux-$ARCH.cdb551.zip" &&
        chmod +x warp-plus &&
        cp warp-plus "$PREFIX/bin/usef" &&
        cp warp-plus "$PREFIX/bin/warp-plus-plus"; then
        rm "README.md" "LICENSE" "warp-plus-linux-$ARCH.cdb551.zip"
        echo "================================================"
        echo -e "${green}warp-plus installed successfully.${rest}"
        socks
    else
        echo -e "${red}Error installing warp-plus.${rest}"
    fi
}

# Get socks config
socks() {
   echo ""
   echo -e "${yellow}Copy this Config to ${purple}V2ray${green} Or ${purple}Nekobox ${yellow}and Exclude Termux${rest}"
   echo "================================================"
   echo -e "${green}socks://Og==@127.0.0.1:8086#warp-plus_(usef)${rest}"
   echo "or"
   echo -e "${green}Manually create a SOCKS configuration with IP ${purple}127.0.0.1 ${green}and port${purple} 8086..${rest}"
   echo "================================================"
   echo -e "${yellow}To run again, type:${green} warp-plus ${rest}or${green} usef ${rest}or${green} ./warp-plus${rest}"
   echo "================================================"
   echo -e "${green} If you get a 'Bad address' error, run ${yellow}[Arm]${rest}"
   echo ""
}

#Uninstall
uninstall() {
    warp-plus="$PREFIX/bin/warp-plus"
    directory="/data/data/com.termux/files/home/wireguard-go"
    home="/data/data/com.termux/files/home"
    if [ -f "$warp-plus" ]; then
        rm -rf "$directory" "$PREFIX/bin/usef" "wa.py" "$PREFIX/bin/warp-plus" "$home/wgcf-profile.ini" "$home/warp-plus" "$home/stuff" "$home/wgcf-identity.json" > /dev/null 2>&1
        echo -e "${red}Uninstallation completed.${rest}"
    else
        echo -e "${yellow} ____________________________________${rest}"
        echo -e "${red} Not installed.Please Install First.${rest}${yellow}|"
        echo -e "${yellow} ____________________________________${rest}"
    fi
}

# warp-plus to warp-plus plus
warp-plus_plus() {
    if ! command -v python &> /dev/null; then
        echo "Installing Python..."
        pkg install python -y
    fi

    echo -e "${green}Downloading and running${purple} warp-plus+ script...${rest}"
    wget -O wa.py https://raw.githubusercontent.com/Ptechgithub/configs/main/wa.py
    python wa.py
}

# Menu
menu() {
    clear
    echo -e "${green}By --> Peyman * Github.com/Ptechgithub * ${rest}"
    echo ""
    echo -e "${yellow}❤️Github.com/${cyan}bepass-org${yellow}/wireguard-go❤️${rest}"
    echo -e "${purple}*********************************${rest}"
    echo -e "${blue}     ###${cyan} warp-plus in Termux ${blue}###${rest}   ${purple}  * ${rest}"
    echo -e "${purple}*********************************${rest}"
    echo -e "${cyan}1)${rest} ${green}Install warp-plus (vpn)${purple}           * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}2)${rest} ${green}Install warp-plus (vpn) [${yellow}Arm${green}] ${purple}    * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}3)${rest} ${green}Uninstall${rest}${purple}                    * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}4)${rest} ${green}warp-plus to ${purple}warp-plus plus${green} [${yellow}Free GB${green}]${rest}${purple}  * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}5)${rest} ${green}Build (warp-plus)${purple}                 * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${red}0)${rest} ${green}Exit                         ${purple}* ${rest}"
    echo -e "${purple}*********************************${rest}"
}

# Main
menu
read -p "Please enter your selection [0-5]:" choice

case "$choice" in
   1)
        install
        warp-plus
        ;;
    2)
        install_arm
        warp-plus-plus
        ;;
    3)
        uninstall
        ;;
    4)
        warp-plus_plus
        ;;
    5)
        build
        ;;
    0)
        echo -e "${cyan}Exiting...${rest}"
        exit
        ;;
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac