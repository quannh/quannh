#!/bin/bash

# Ten: install_virtualhere.sh
# Muc tieu: Cai VirtualHere USB Server tren Armbian (TV Box Amlogic S9xxx)

set -e

echo "[*] Dang cap nhat he thong..."
sudo apt update -y

echo "[*] Cai wget neu chua co..."
sudo apt install -y wget

echo "[*] Dang tai VirtualHere USB Server..."
wget -O vhusbdarm https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm
chmod +x vhusbdarm
sudo mv vhusbdarm /usr/local/bin/vhusbdarm

echo "[*] Tao systemd service..."
sudo tee /etc/systemd/system/virtualhere.service > /dev/null <<EOF
[Unit]
Description=VirtualHere USB Server
After=network.target

[Service]
ExecStart=/usr/local/bin/vhusbdarm
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

echo "[*] Dang kich hoat va khoi dong dich vu..."
sudo systemctl daemon-reexec
sudo systemctl enable virtualhere
sudo systemctl start virtualhere

echo "[OK] Cai dat hoan tat!"
echo "[OK] USB Server dang chay tren dia chi IP: $(hostname -I | awk '{print $1}')"
