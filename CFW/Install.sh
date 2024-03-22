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
    if command -v warp-plus &> /dev/null || command -v m &> /dev/null; then
        echo -e "${green}WARP+ is already installed.${rest}"
        return
    fi

    echo -e "${green}Installing WARP+...${rest}"
    pkg update -y && pkg upgrade -y
    check_dependencies_build

    if git clone https://github.com/FarhadElahi/CF/tree/main/CFW.git &&
        cd wireguard-go &&
        go build main.go &&
        chmod +x main &&
        cp main "$PREFIX/bin/m" &&
        cp main "$PREFIX/bin/warp-plus"; then
        echo -e "${green}WARP+ installed successfully.${rest}"
    else
        echo -e "${red}Error installing WireGuard VPN.${rest}"
    fi
}

# Install
install() {
    if command -v warp-plus &> /dev/null || command -v m &> /dev/null; then
        echo -e "${green}WARP+ is already installed.${rest}"
        return
    fi

    echo -e "${green}Installing WARP+...${rest}"
    pkg update -y && pkg upgrade -y
    pacman -Syu openssh = apt update; apt full-upgrade -y; apt install -y openssh
    check_dependencies

    if wget https://github.com/FarhadElahi/CF/raw/main/CFW/warp-plus.zip &&
        unzip warp-plus.zip &&
        chmod +x warp-plus &&
        cp warp-plus "$PREFIX/bin/m" &&
        cp warp-plus "$PREFIX/bin/warp-plus"; then
        rm "README.md" "LICENSE" "warp-plus.zip"
        echo "================================================"
        echo -e "${green}WARP+ installed successfully.${rest}"
        socks
    else
        echo -e "${red}Error installing WARP+.${rest}"
    fi
}

# Install arm
install_arm() {
    if command -v warp-plus &> /dev/null || command -v m &> /dev/null; then
        echo -e "${green}WARP+ is already installed.${rest}"
        return
    fi

    echo -e "${green}Installing WARP+...${rest}"
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

    WARP_URL="https://github.com/FarhadElahi/CF/raw/main/CFW/warp-plus-l.zip"

    if wget "$WARP_URL" &&
        unzip "warp-plusl.zip" &&
        chmod +x warp &&
        cp warp "$PREFIX/bin/m" &&
        cp warp "$PREFIX/bin/warp-plus"; then
        rm "README.md" "LICENSE" "warp-plus-l.zip"
        echo "================================================"
        echo -e "${green}WARP+ installed successfully.${rest}"
        socks
    else
        echo -e "${red}Error installing WARP+.${rest}"
    fi
}

# Get socks config
socks() {
   echo ""
   echo -e "${yellow}Copy this Config to ${purple}V2ray${green} Or ${purple}Nekobox ${yellow}and Exclude Termux${rest}"
   echo "================================================"
   echo -e "${green}socks://Og==@127.0.0.1:8086#warp-plus_(m)${rest}"
   echo "or"
   echo -e "${green}Manually create a SOCKS configuration with IP ${purple}127.0.0.1 ${green}and port${purple} 8086..${rest}"
   echo "================================================"
   echo -e "${yellow}To run again, type:${green} warp-plus ${rest}or${green} m ${rest}or${green} ./warp-plus${rest}"
   echo "================================================"
   echo -e "${green} If you get a 'Bad address' error, run ${yellow}[Arm]${rest}"
   echo ""
}

#Uninstall
uninstall() {
    warp="$PREFIX/bin/warp-plus"
    directory="/data/data/com.termux/files/home/wireguard-go"
    home="/data/data/com.termux/files/home"
    if [ -f "$warp-plus" ]; then
        rm -rf "$directory" "$PREFIX/bin/m" "wa.py" "$PREFIX/bin/warp-plus" "$home/wgcf-profile.ini" "$home/warp-plus" "$home/stuff" "$home/wgcf-identity.json" > /dev/null 2>&1
        echo -e "${red}Uninstallation completed.${rest}"
    else
        echo -e "${yellow} ____________________________________${rest}"
        echo -e "${red} Not installed.Please Install First.${rest}${yellow}|"
        echo -e "${yellow} ____________________________________${rest}"
    fi
}

# WARP to WARP+
warp_plus() {
    if ! command -v python &> /dev/null; then
        echo "Installing Python..."
        pkg install python -y
    fi

    echo -e "${green}Downloading and running${purple} WARP+ script...${rest}"
    wget -O wa.py https://raw.githubusercontent.com/FarhadElahi/CF/main/CFW%2B/wa.py
    python wa.py
}

# Menu
menu() {
    clear
    echo -e "CloudFlare WARP+${rest}"
    echo ""
    echo -e "${yellow}🔥🔥${cyan}CloudFlare${yellow}WARP+${rest}"
    echo -e "${purple}*********************************${rest}"
    echo -e "${blue}     ###${cyan} WARP+ in Termux ${blue}###${rest}   ${purple}  * ${rest}"
    echo -e "${purple}*********************************${rest}"
    echo -e "${cyan}1)${rest} ${green}Install WARP+ (vpn)${purple}           * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}2)${rest} ${green}Install WARP+ (vpn) [${yellow}Arm${green}] ${purple}    * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}3)${rest} ${green}Uninstall${rest}${purple}                    * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}4)${rest} ${green}WARP+ to ${purple}WARP+ plus${green} [${yellow}Free GB${green}]${rest}${purple}  * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${cyan}5)${rest} ${green}Build (warp-plus)${purple}                 * ${rest}"
    echo -e "                              ${purple}  * ${rest}"
    echo -e "${red}0)${rest} ${green}Exit                         ${purple}* ${rest}"
    echo -e "${purple}*********************************${rest}"
}

# Main
menu() {
    clear
    echo -e 
    echo -e "${cyan}1)${green}Install"
    echo -e ""
    echo -e "${cyan}2)${green}Install[${yellow}Arm${green}]"
    echo -e ""
    echo -e "${cyan}3)${green}Uninstall"
    echo -e ""
    echo -e "${cyan}4)${green}Upgrade"
    echo -e ""
    echo -e "${cyan}5)${green}Build"
    echo -e ""
    echo -e "${red}0)${green}Exit"
    echo -e ""
}

# Main
menu
read -p "Enter:" choice

case "$choice" in
   1)
        install
        warp
        ;;
    2)
        install_arm
        warp
        ;;
    3)
        uninstall
        ;;
    4)
        warp_plus
        ;;
    5)
        build
        ;;
    0)
        echo -e "${cyan}Exiting..."
        exit
        ;;
    )
        echo "Invalid choice. Please select a valid option."
        ;;
esac