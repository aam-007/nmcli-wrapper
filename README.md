
nmcli-wrapper

nmcli-wrapper is a fullscreen, user-friendly Bash script that wraps nmcli with a dialog-based interface, making it easier to scan, connect to, and disconnect from Wi-Fi networks without needing to remember complex commands.
🛠️ Features

    Fullscreen dialog UI (like Debian/Ubuntu installer)

    Scan and list available Wi-Fi networks

    Prompt for password and connect securely

    View current connection status

    Disconnect from a network with one click

    Clean and minimal CLI experience

📦 Requirements

Make sure the following are installed on your system:

    Linux (tested on Linux Mint, Ubuntu, Debian)

    bash

    nmcli (comes with NetworkManager, usually installed by default)

    dialog (for fullscreen UI)

To install dialog, run:

sudo apt install dialog

🚀 Installation
1. Clone the repository

git clone https://github.com/yourusername/nmcli-wrapper.git
cd nmcli-wrapper

2. Make the script executable

chmod +x nmcli-wrapper.sh

3. Install system-wide (so you can run it anywhere)

Copy the script to a directory in your system $PATH:

sudo cp nmcli-wrapper.sh /usr/local/bin/nmcli-wrapper
sudo chmod +x /usr/local/bin/nmcli-wrapper

4. (Optional) Create an alias for quicker access

If you want to launch it with a shorter name (like wifi), add this to your ~/.bashrc:

alias wifi="nmcli-wrapper"

Then apply the change:

source ~/.bashrc

Now you can run the app from anywhere by typing:

wifi

💡 Usage

Launch the wrapper from a terminal:

nmcli-wrapper

Or, if you've set the alias:

wifi

Follow the onscreen prompts to:

    Scan for available Wi-Fi networks

    Enter a password for secured networks

    Check current Wi-Fi connection

    Disconnect from the current network

🧹 Uninstall

To remove the system-wide installed wrapper:

sudo rm /usr/local/bin/nmcli-wrapper

Remove the alias from ~/.bashrc if you added one.
