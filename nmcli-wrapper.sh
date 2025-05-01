#!/usr/bin/env bash

# nmcli-wrapper.sh: A fullscreen, dialog-based Wi-Fi Manager using nmcli
# Usage: chmod +x nmcli-wrapper.sh && ./nmcli-wrapper.sh

set -euo pipefail

# Check dependencies
if ! command -v dialog &>/dev/null; then
  echo "Error: 'dialog' is required. Install with 'sudo apt install dialog'." >&2
  exit 1
fi

# Helper: show infobox for a duration
show_infobox() {
  local message="$1" duration=${2:-2}
  dialog --infobox "$message" 7 50
  sleep "$duration"
}

# Scan for Wi-Fi networks and return array of SSID:SECURITY
scan_networks() {
  nmcli device wifi rescan &>/dev/null
  sleep 2
  mapfile -t networks < <(
    nmcli --terse --fields SSID,SECURITY device wifi list \
      | awk -F: '$1!="" {print $1":"$2}'
  )
}

main_menu() {
  while true; do
    dialog --clear --title "nmcli Wrapper" \
      --menu "Choose action:" 15 50 4 \
      1 "Connect to Wi-Fi" \
      2 "Connection Status" \
      3 "Disconnect Wi-Fi" \
      4 "Exit" 2> choice.tmp
    choice=$(<choice.tmp)
    rm -f choice.tmp

    case "$choice" in
      1) connect_dialog ;;
      2) status_dialog  ;;
      3) disconnect_dialog ;;
      4) break ;;
      *) ;;  # redraw
    esac
  done
  clear
}

connect_dialog() {
  dialog --clear --title "Scan" --yesno "Scan for available Wi-Fi networks?" 7 50
  if [[ $? -ne 0 ]]; then
    return; fi

  show_infobox "Scanning for networks..." 3
  scan_networks
  if [[ ${#networks[@]} -eq 0 ]]; then
    dialog --msgbox "No Wi-Fi networks found." 7 50
    return
  fi

  # Prepare menu items
  menu_items=()
  for entry in "${networks[@]}"; do
    IFS=":" read -r ss sec <<< "$entry"
    menu_items+=("$ss" "$sec")
  done

  dialog --clear --title "Select Network" \
    --menu "Choose SSID:" 20 60 10 \
    "${menu_items[@]}" 2> ssid.tmp
  SSID=$(<ssid.tmp)
  rm -f ssid.tmp
  [[ -z "$SSID" ]] && return

  # Determine security
  SECURITY=$(grep -F "${SSID}:" <<< "${networks[*]}" | awk -F: '{print $2}')

  if [[ -n "$SECURITY" && "$SECURITY" != "--" ]]; then
    dialog --clear --title "Password" --passwordbox "Enter password for '$SSID':" 10 50 2> pass.tmp
    PASSWORD=$(<pass.tmp)
    rm -f pass.tmp
  else
    PASSWORD=""
  fi

  show_infobox "Connecting to '$SSID'..." 2
  if nmcli device wifi connect "$SSID" $( [[ -n "$PASSWORD" ]] && printf 'password %q' "$PASSWORD" ); then
    dialog --msgbox "Successfully connected to '$SSID'!" 7 50
  else
    dialog --msgbox "Failed to connect to '$SSID'." 7 50
  fi
}

status_dialog() {
  SSID=$(nmcli -t -f ACTIVE,SSID dev wifi list | awk -F: '$1=="yes"{print $2; exit}')
  if [[ -n "$SSID" ]]; then
    dialog --msgbox "Currently connected to '$SSID'." 7 50
  else
    dialog --msgbox "Not connected to any Wi-Fi network." 7 50
  fi
}

disconnect_dialog() {
  dev=$(nmcli -t -f DEVICE,TYPE dev status | awk -F: '$2=="wifi"{print $1; exit}')
  if [[ -z "$dev" ]]; then
    dialog --msgbox "No Wi-Fi device found." 7 50
    return
  fi

  show_infobox "Disconnecting '$dev'..." 2
  if nmcli device disconnect "$dev"; then
    dialog --msgbox "Successfully disconnected." 7 50
  else
    dialog --msgbox "Failed to disconnect '$dev'." 7 50
  fi
}

# Launch UI
main_menu

