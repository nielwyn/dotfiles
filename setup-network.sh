 #!/bin/bash
set -e

sudo pacman -S --noconfirm iwd

# wlan0 network config
sudo tee /etc/systemd/network/25-wlan0.network > /dev/null << 'EOF'
[Match]
Name=wlan0

[Network]
DHCP=yes
DNS=9.9.9.9
DNSDefaultRoute=yes

[DHCPv4]
UseDNS=false

[DHCPv6]
UseDNS=false

[IPv6AcceptRA]
UseDNS=false
EOF

# systemd-resolved config
sudo tee /etc/systemd/resolved.conf > /dev/null << 'EOF'
[Resolve]
DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
FallbackDNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 8.8.8.8#dns.google 2001:4860:4860::8888#dns.google
Domains=~.
DNSSEC=allow-downgrade
DNSOverTLS=yes
EOF

# resolv.conf symlink — safety net for apps that bypass nss-resolve and read /etc/resolv.conf directly
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

sudo systemctl enable --now systemd-networkd
sudo systemctl enable --now systemd-resolved
sudo systemctl enable --now iwd

sudo systemctl restart systemd-networkd
sudo systemctl restart systemd-resolved

echo "Done. Reconnect to WiFi and run: resolvectl status"
