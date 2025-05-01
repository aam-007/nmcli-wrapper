
# nmcli-wrapper

A fullscreen, dialog-driven Bash wrapper for `nmcli` that simplifies scanning, connecting, and disconnecting from Wi‑Fi networks.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Adding to PATH](#adding-to-path)
5. [Creating an Alias](#creating-an-alias)
6. [Optional: Man Page & Completion](#optional-man-page--completion)

---

## Requirements

- **Operating System:** Linux (tested on Debian, Ubuntu, Mint)
- **Bash:** version 4.0 or newer
- **dialog:** for the fullscreen, curses-style UI
  ```bash
  sudo apt install dialog
  ```
- **NetworkManager (`nmcli`):** comes with NetworkManager
  ```bash
  sudo apt install network-manager
  ```

---

## Installation

1. **Clone or download** this repository:
   ```bash
   git clone https://github.com/PhonexLegend/nmcli-wrapper.git
   cd nmcli-wrapper
   ```

2. **Make the script executable**:
   ```bash
   chmod +x nmcli-wrapper.sh
   ```

3. **(Recommended) Install system‑wide** into `/usr/local/bin`:
   ```bash
   sudo cp nmcli-wrapper.sh /usr/local/bin/nmcli-wrapper
   sudo chmod +x /usr/local/bin/nmcli-wrapper
   ```

   > If you lack root privileges, you can install it under your home directory:
   > ```bash
   > mkdir -p ~/.local/bin
   > cp nmcli-wrapper.sh ~/.local/bin/nmcli-wrapper
   > chmod +x ~/.local/bin/nmcli-wrapper
   > ```

---

## Usage

Once installed, simply run:
```bash
nmcli-wrapper
```
You will be presented with a fullscreen menu:

- **Connect to Wi‑Fi**: Scan, select SSID, and (if necessary) enter password
- **Connection Status**: Display your current Wi‑Fi SSID
- **Disconnect Wi‑Fi**: Drop the wireless link
- **Exit**: Quit the UI

All interactions happen through dialog pop‑ups for a clean, user‑friendly experience.

---

## Adding to PATH

If you installed to a custom location (e.g., `~/.local/bin`), ensure that directory is in your `PATH`. Add the following line to your `~/.bashrc` (or `~/.profile`):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

After editing, reload your shell:
```bash
source ~/.bashrc
```

---

## Creating an Alias

To make the command even shorter, add an alias in your `~/.bashrc`:

```bash
# ~/.bashrc
alias wifi="nmcli-wrapper"
```

Reload your configuration:
```bash
source ~/.bashrc
```

Now you can simply type:
```bash
wifi
```

---

## Optional: Man Page & Completion

1. **Man page**
   ```bash
   sudo cp docs/nmcli-wrapper.1 /usr/local/share/man/man1/
   sudo mandb
   ```

2. **Bash completion**
   Copy or write a completion script into `/etc/bash_completion.d/nmcli-wrapper`:
   ```bash
   #!/usr/bin/env bash
   _nmcli_wrapper() {
     COMPREPLY=( $( compgen -W "connect status disconnect exit" -- "${COMP_WORDS[1]}" ) )
   }
   complete -F _nmcli_wrapper nmcli-wrapper
   ```

Then reload:
```bash
source /etc/bash_completion.d/nmcli-wrapper
```



