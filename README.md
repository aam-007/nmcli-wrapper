nmcli-wrapper

A fullscreen, dialog-driven Bash wrapper for nmcli that simplifies scanning, connecting, and disconnecting from Wi‑Fi networks.
Table of Contents

    Requirements
    Installation
    Usage
    Adding to PATH
    Creating an Alias
    Optional: Man Page & Completion

Requirements
Operating System: Linux (tested on Debian, Ubuntu, Mint)
Bash: version 4.0 or newer
dialog: for the fullscreen, curses-style UI

sudo apt install dialog

NetworkManager (nmcli): comes with NetworkManager

sudo apt install network-manager

Installation

Clone or download this repository:

git clone https://github.com/PhonexLegend/nmcli-wrapper.git
cd nmcli-wrapper

Make the script executable:

chmod +x nmcli-wrapper.sh

(Recommended) Install system‑wide into /usr/local/bin:

sudo cp nmcli-wrapper.sh /usr/local/bin/nmcli-wrapper
sudo chmod +x /usr/local/bin/nmcli-wrapper

If you lack root privileges, you can install it under your home directory:

mkdir -p ~/.local/bin
cp nmcli-wrapper.sh ~/.local/bin/nmcli-wrapper
chmod +x ~/.local/bin/nmcli-wrapper

Usage

Once installed, simply run:

nmcli-wrapper

You will be presented with a fullscreen menu:

    Connect to Wi‑Fi: Scan, select SSID, and (if necessary) enter password
    Connection Status: Display your current Wi‑Fi SSID
    Disconnect Wi‑Fi: Drop the wireless link
    Exit: Quit the UI

All interactions happen through dialog pop‑ups for a clean, user‑friendly experience.
Adding to PATH

If you installed to a custom location (e.g., ~/.local/bin), ensure that directory is in your PATH. Add the following line to your ~/.bashrc (or ~/.profile):

export PATH="$HOME/.local/bin:$PATH"

After editing, reload your shell:

source ~/.bashrc

Creating an Alias

To make the command even shorter, add an alias in your ~/.bashrc:

# ~/.bashrc
alias wifi="nmcli-wrapper"

Reload your configuration:

source ~/.bashrc

Now you can simply type:

wifi

Optional: Man Page & Completion

Man page

sudo cp docs/nmcli-wrapper.1 /usr/local/share/man/man1/
sudo mandb

Bash completion Copy or write a completion script into /etc/bash_completion.d/nmcli-wrapper:

#!/usr/bin/env bash
_nmcli_wrapper() {
  COMPREPLY=( $( compgen -W "connect status disconnect exit" -- "${COMP_WORDS[1]}" ) )
}
complete -F _nmcli_wrapper nmcli-wrapper

Then reload:

source /etc/bash_completion.d/nmcli-wrapper

