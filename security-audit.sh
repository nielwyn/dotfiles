#!/bin/bash

BOLD='\033[1m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

section() {
    echo ""
    echo -e "${CYAN}${BOLD}══════════════════════════════════════${RESET}"
    echo -e "${CYAN}${BOLD}  $1${RESET}"
    echo -e "${CYAN}${BOLD}══════════════════════════════════════${RESET}"
}

warn() { echo -e "${YELLOW}[!] $1${RESET}"; }
info() { echo -e "${GREEN}[*] $1${RESET}"; }

if [ "$EUID" -ne 0 ]; then
    warn "Not running as root — some results (process names, lsof) may be incomplete. Re-run with sudo for full output."
fi

TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)

section "1. LOGIN HISTORY"
info "Recent logins:"
printf "%-8s %-12s %-16s %-19s %s\n" "USER" "TTY" "FROM" "LOGIN" "END / DURATION"
last | head -20
echo ""
info "Failed login attempts:"
if [ ! -r /var/log/btmp ]; then
    warn "Cannot read /var/log/btmp — run with sudo for failed login data"
else
    result=$(lastb 2>/dev/null | head -20)
    if [ -n "$result" ]; then
        printf "%-8s %-12s %-16s %-19s %s\n" "USER" "TTY" "FROM" "LOGIN" "END / DURATION"
        echo "$result"
    else
        info "No failed login attempts"
    fi
fi
echo ""
info "Currently logged in:"
w

section "2. SSH ACTIVITY"
info "Successful SSH logins:"
journalctl -u sshd --no-pager 2>/dev/null | grep "Accepted" | tail -20 || warn "No sshd journal found"
echo ""
info "Failed SSH attempts (top IPs):"
journalctl -u sshd --no-pager 2>/dev/null | grep "Failed password" \
    | awk '{print $11}' | sort | uniq -c | sort -rn | head -10

section "3. LISTENING PORTS"
info "Open ports and bound processes:"
ss -tulnp

section "4. ACTIVE NETWORK CONNECTIONS"
info "Current TCP connections with process names:"
ss -tp
echo ""
info "All open network connections (lsof):"
lsof -i 2>/dev/null | head -80 || warn "lsof requires root for full output"

section "5. RECENTLY MODIFIED SYSTEM FILES (last 24h)"
info "Checking /etc /usr /bin /sbin..."
results=$(find /etc /usr /bin /sbin -mtime -1 -type f 2>/dev/null)
if [ -z "$results" ]; then
    if [ "$EUID" -ne 0 ]; then
        warn "No results — run with sudo to get accurate output"
    else
        info "No recently modified system files found"
    fi
else
    echo "$results" | head -30
fi

section "6. RECENTLY MODIFIED FILES IN HOME (last 3 days)"
info "Checking $TARGET_HOME..."
find "$TARGET_HOME" -mtime -3 -type f 2>/dev/null | grep -v ".cache" | grep -v ".mozilla" | grep -v ".local/share" | head -30

section "7. CRON JOBS & SCHEDULED TASKS"
info "Your crontab:"
crontab -l 2>/dev/null || info "No user crontab"
echo ""
info "System crontab:"
cat /etc/crontab 2>/dev/null
echo ""
info "Cron directories:"
ls /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.weekly 2>/dev/null
echo ""
info "Systemd timers:"
systemctl list-timers --all --no-pager 2>/dev/null | head -20

section "8. STARTUP PERSISTENCE"
info "Enabled systemd services:"
systemctl list-unit-files --state=enabled --no-pager | grep -v "systemd\|dbus\|getty\|NetworkManager\|bluetooth\|cups\|avahi\|unit files listed"
echo ""
info "Shell config files (looking for unexpected entries):"
for f in "$TARGET_HOME/.bashrc" "$TARGET_HOME/.bash_profile" "$TARGET_HOME/.zshrc" "$TARGET_HOME/.profile"; do
    if [ -f "$f" ]; then
        echo -e "${BOLD}--- $f ---${RESET}"
        cat "$f"
        echo ""
    fi
done

section "9. OPEN FILES BY NETWORK PROCESSES"
info "Files opened by processes with network connections:"
lsof -i -n -P 2>/dev/null | grep -v "firefox\|chrome\|chromium\|spotify\|discord" | head -30

section "DONE"
