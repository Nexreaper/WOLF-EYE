# 🐺 WOLF EYE

[![Logo](https://i.ibb.co/v4qr77fw/logo.png)](https://ibb.co/v4qr77fw)

**Silent Camera Capture Framework**

> **Nexreaper delivers.**

[![Bash](https://img.shields.io/badge/Bash-4.0+-green?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![PHP](https://img.shields.io/badge/PHP-7.4+-blue?logo=php&logoColor=white)](https://www.php.net/)
[![License](https://img.shields.io/badge/License-MIT-red.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](CONTRIBUTING.md)

---

## 📷 Overview

**WOLF EYE** is a modular, Bash-based camera phishing framework designed for security awareness and authorized penetration testing. It automates the deployment of a local PHP server, serves realistic social engineering templates, and utilizes Cloudflare's encrypted tunneling to capture target data remotely.

> ⚠️ **Disclaimer:** This tool is developed for **educational purposes and authorized penetration testing only**. The developers (Nexreaper & Wolf Intelligence) are not responsible for any misuse or damage caused by this program.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎯 **5 Social Engineering Templates** | YouTube Live TV, Birthday Wish, Secret Message, Fake Instagram Followers, AI Chatbot |
| 🔒 **Cloudflare Encrypted Tunnel** | Secure public link via `cloudflared` – no port forwarding required |
| 📸 **Silent Camera Capture** | Captures high‑quality images from the target's webcam |
| 🧩 **Modular Architecture** | Clean separation of core logic, templates, and utilities |
| 📱 **Cross‑Platform** | Works on Kali Linux, Parrot OS, Ubuntu, Debian, macOS, and Termux |
| ⚡ **Auto‑Dependency Installation** | Automatically checks and installs required packages |
| 🎨 **Modern UI** | Color‑coded terminal interface with progress indicators |

---

## 🔧 Prerequisites

- **Bash** 4.0+
- **PHP** 7.4+
- **curl**, **wget**, **jq**
- **cloudflared** – [Installation Guide](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-local-tunnel/)

---

## 📦 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Nexreaper/WOLF-EYE.git
cd WOLF-EYE
```

### 2. Make the Script Executable

```bash
chmod +x evel.sh
```

### 3. Install Dependencies (Auto‑handled on first run)

The script will automatically check for and install missing dependencies. Alternatively, install them manually:

```bash
# Debian/Ubuntu/Kali
sudo apt install php curl wget jq cloudflared lolcat

# macOS (Homebrew)
brew install php curl wget jq cloudflared lolcat

# Termux
pkg install php curl wget jq cloudflared lolcat
```

---

## 🚀 Usage

### Interactive Mode

```bash
./evel.sh
```

You'll be presented with a menu to select a template:

```
    <<------ Select a Template ------>>

    [1] YouTube Live TV
    [2] Birthday Wish
    [3] Secret Message
    [4] Fake Instagram Followers
    [5] Chatting Bot (Fake AI)
    [6] Exit
```

Select a template and follow the on‑screen instructions. Once the Cloudflare tunnel is established, share the generated link with your target.

### Command‑Line Mode (Advanced)

```bash
./evel.sh --template <template_name>
```

---

## 📂 Project Structure

```
wolf-eye/
├── evel.sh                 # Main entry point
├── lib/                    # Core libraries
│   ├── banners.sh          # Banner display
│   ├── capture_data.sh     # Data capture logic
│   ├── check_net.sh        # Network checks
│   ├── dis_detect.sh       # Distribution detection
│   ├── others.sh           # Utility functions
│   ├── pkage_check.sh      # Package validation
│   ├── setup_files.sh      # File setup
│   ├── tunnel.sh           # Cloudflare tunneling
│   └── update.sh           # Update checker
├── templates/              # Social engineering templates
│   ├── youtube/            # YouTube Live TV
│   ├── birthday/           # Birthday Wish
│   ├── secret/             # Secret Message
│   ├── instagram/          # Fake Instagram Followers
│   └── chatbot/            # AI Chatbot
└── captured_imgs/          # Captured images (auto‑created)
```

---

## 🛡️ How It Works

1. **Template Selection** – Choose a social engineering template.
2. **PHP Server** – A local PHP server serves the template.
3. **Cloudflare Tunnel** – `cloudflared` creates a secure public HTTPS link.
4. **Link Delivery** – Share the link with the target.
5. **Camera Access** – The target is prompted to allow camera access.
6. **Silent Capture** – An image is captured and sent back to your server.
7. **Storage** – Images are saved in `captured_imgs/` with timestamps.

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| `cloudflared` not found | Install it: `sudo apt install cloudflared` or [download](https://github.com/cloudflare/cloudflared/releases) |
| PHP server fails to start | Ensure PHP is installed: `php -v` |
| Tunnel link not generated | Check your internet connection and firewall |
| No images captured | Ensure the target grants camera permission |
| `lib/` folder missing | Re‑clone the repository |

---

## 📊 Live Status

The script displays real‑time status updates:

```
[+] Local server: http://127.0.0.1:9090
[*] Starting Cloudflared...
[*] Generating link, please wait...
[+] Tunnel URL: https://random.trycloudflare.com
[+] Share this link with the target.
[+] Capture started. Press Ctrl+C to stop.
```

---

## 👑 Credits

- **Original Concept:** [RGSecurityTeam](https://github.com/rgsecteam/evil-eye)
- **Rebranded & Enhanced by:** Ahmad Bilal Qureshi (Nexreaper) & Wolf Intelligence
- **Inspiration:** techchip's CamPhish

---

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [techchip](https://github.com/techchipnet) for CamPhish inspiration
- [Cloudflare](https://www.cloudflare.com/) for the tunneling service
- The open‑source security community

---

> *“Nexreaper delivers.”*
