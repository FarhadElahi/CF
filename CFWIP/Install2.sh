#!/bin/bash

#colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
rest='\033[0m'

case "$(uname -m)" in
	x86_64 | x64 | amd64 )
	    cpu=amd64
	;;
	i386 | i686 )
        cpu=386
	;;
	armv8 | armv8l | arm64 | aarch64 )
        cpu=arm64
	;;
	armv7l )
        cpu=arm
	;;
	* )
	echo "The current architecture is $(uname -m), not supported"
	exit
	;;
esac

cfwarpIP() {
    if [[ ! -f "$PREFIX/bin/warpendpoint" ]]; then
        echo "Downloading warpendpoint program"
        if [[ -n $cpu ]]; then
            curl -L -o warpendpoint -# --retry 2 https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/$cpu
            cp warpendpoint $PREFIX/bin
            chmod +x $PREFIX/bin/warpendpoint
        fi
    fi
}

endipv4(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
			n=$[$n+1]
		fi
	done
}

endipv6(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
	done
}

generate() {
    if ! command -v wgcf &>/dev/null; then
        echo -e "${green}Downloading The Required File..."
        if [[ "$(uname -o)" == "Android" ]]; then
			if ! command -v curl &>/dev/null; then
			    pkg install curl -y
			fi
            if [[ -n $cpu ]]; then
                curl -o "$PREFIX/bin/wgcf" -L "https://github.com/FarhadElahi/CF/main/CFWIP/wgcf"
                chmod +x "$PREFIX/bin/wgcf"
            fi
        else
            curl -L -o wgcf -# --retry 2 "https://github.com/ViRb3/wgcf/releases/download/v2.2.22/wgcf_2.2.22_linux_$cpu"
            cp wgcf "$PREFIX/usr/local/bin"
            chmod +x "$PREFIX/usr/local/bin/wgcf"
        fi
    fi
    echo -e "${green}            Generating WireGuard Config Please Wait...${rest}"
    echo ""
    rm wgcf-account.toml >/dev/null 2>&1
    wgcf register --accept-tos
    wgcf generate
  
    if [ -f wgcf-profile.conf ]; then
        show
    else
        echo -e "${red}wgcf-profile.conf not found in current path or failed to install${rest}"
    fi
}

v2ray() {
  urlencode() {
    local string="$1"
    local length="${#string}"
    local urlencoded=""
    for (( i = 0; i < length; i++ )); do
      local c="${string:$i:1}"
      case $c in
        [a-zA-Z0-9.~_-]) urlencoded+="$c" ;;
        *) printf -v hex "%02X" "'$c"
           urlencoded+="%${hex: -2}"
      esac
    done
    echo "$urlencoded"
  }

  PrivateKey=$(awk -F' = ' '/PrivateKey/{print $2}' wgcf-profile.conf)
  Address=$(awk -F' = ' '/Address/{print $2}' wgcf-profile.conf | tr '\n' ',' | sed 's/,$//;s/,/, /g')
  PublicKey=$(awk -F' = ' '/PublicKey/{print $2}' wgcf-profile.conf)
  MTU=$(awk -F' = ' '/MTU/{print $2}' wgcf-profile.conf)
  
  WireguardURL="wireguard://$(urlencode "$PrivateKey")@$Endip_v46?address=$(urlencode "$Address")&publickey=$(urlencode "$PublicKey")&mtu=$(urlencode "$MTU")#WARP"

  echo $WireguardURL
}

show() {
    echo ""
    sleep1
    clear
    if [ -s result.csv ]; then
	    Endip_v46=$(awk 'NR==2 {split($1, arr, ","); print arr[1]}' result.csv)
	    sed -i "s/Endpoint =.*/Endpoint = $Endip_v46/g" wgcf-profile.conf
    else
	    Endip_v46="engage.cloudflareclient.com:2408"
	fi
    echo -e "${green}     ━━━━━─────━━━━━─────━━━━━─────━━━━━─────━━━━━"
    echo ""
    echo -e "${cyan}          ╭─━━━━━━─╮${yellow}             ╭─━━━━━━━━━─╮⁠"
    echo -e "${yellow}             WARP   ${green}─────━━━─────   ${cyan}NekoBox"
    echo -e "${cyan}          ╰─━━━━━━─╯${yellow}             ╰─━━━━━━━━━─╯"
    echo ""
    echo -e "${green}$(cat wgcf-profile.conf)"
    echo ""
    echo -e "     ━━━━━─────━━━━━─────━━━━━─────━━━━━─────━━━━━"
    echo ""
    echo -e "${cyan}          ╭─━━━━━━─╮${yellow}             ╭─━━━━━━━━━─╮⁠"
    echo -e "${yellow}             WARP   ${green}─────━━━─────   ${cyan}v2rayNG"
    echo -e "${cyan}          ╰─━━━━━━─╯${yellow}             ╰─━━━━━━━━━─╯"
    echo ""
    echo -e "${green}$(v2ray)"
    echo ""
    echo -e "     ━━━━━─────━━━━━─────━━━━━─────━━━━━─────━━━━━"
}

endipresult() {
    echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u > ip.txt
    ulimit -n 102400
    chmod +x warpendpoint >/dev/null 2>&1
    if command -v warpendpoint &>/dev/null; then
        warpendpoint
   else
        ./warpendpoint
    fi
    
    clear
    cat result.csv | awk -F, '$3!="timeout ms" {print} ' | sort -t, -nk2 -nk3 | uniq | head -11 | awk -F, '{print "Endpoint "$1" Packet Loss Rate "$2" Average Delay "$3}'
    Endip_v4=$(cat result.csv | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+" | head -n 1)
    Endip_v6=$(cat result.csv | grep -oE "\[.*\]:[0-9]+" | head -n 1)
    delay=$(cat result.csv | grep -oE "[0-9]+ ms|timeout" | head -n 1)
    echo ""
    echo -e "${green}Results Saved in result.csv${rest}"
    echo ""
    if [ "$Endip_v4" ]; then
        echo -e "${yellow}  ╭─━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━─╮"
        echo -e "${blue}     Best IPv4 ${green}───► ${yellow}$Endip_v4 ${green} - $delay"
    elif [ "$Endip_v6" ]; then
        echo -e "${blue}     Best IPv6 ${green}───► ${yellow}$Endip_v6 ${green} - $delay"
    else
        echo -e "${red} No valid IP Addresses Found.${rest}"
    fi
    echo -e "${yellow}  ╰─━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━─╯"
    rm warpendpoint >/dev/null 2>&1
    rm -rf ip.txt
    exit
}

clear
echo -e "${green}    ╭─━━━━━━━━━━━━━━━━━━━─╮⁠"
echo -e "${yellow}      CloudFlare WARP+ IP"
echo -e "${green}    ╰─━━━━━━━━━━━━━━━━━━━─╯"
echo -e "  ${yellow}  ╭─━━━━─╮⁠"
echo -e "  ${cyan}1.  ${green}IPV4"
echo -e "  ${yellow}  ╰─━━━━─╯"
echo -e "  ${yellow}  ╭─━━━━─╮⁠"
echo -e "  ${cyan}2.  ${green}IPV6"
echo -e "  ${yellow}  ╰─━━━━─╯"
echo -e "  ${yellow}  ╭─━━━━─╮⁠"
echo -e "  ${cyan}3.  ${green}WGCF"
echo -e "  ${yellow}  ╰─━━━━─╯"
echo -e "  ${yellow}  ╭─━━━━─╮⁠"
echo -e "  ${cyan}4.  ${red}Exit"
echo -e "  ${yellow}  ╰─━━━━─╯"
echo -e "${cyan}    ╭─━━━━─╮⁠"
echo -en "${cyan}      Enter:"
read -r Enter
case "$Enter" in
    1)
        cfwarpIP
        endipv4
        endipresult
        Endip_v4
        ;;
    2)
        cfwarpIP
        endipv6
        endipresult
        Endip_v6
        ;;
    3)
        generate
        ;;
    4)
        exit
        ;;
    *)
        echo "Invalid Choice. Please Select a Valid Option."
        ;;
esac
