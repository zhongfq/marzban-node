#!/usr/bin/env bash

# install xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# install requirements
wget -qO- https://bootstrap.pypa.io/get-pip.py | python3 -
python3 -m pip install -r requirements.txt

# store ssl key
mkdir -vp /var/lib/marzban-node

# startup service
cat > /etc/systemd/system/marzban.service << EOF
[Unit]
Description=Marzban Node Service
Documentation=https://github.com/gozargah/Marzban-node
After=network.target nss-lookup.target

[Service]
ExecStart=/usr/bin/env python3 /opt/marzban-node/main.py
Restart=on-failure
WorkingDirectory=/opt/marzban-node

[Install]
WantedBy=multi-user.target
EOF

systemctl enable marzban