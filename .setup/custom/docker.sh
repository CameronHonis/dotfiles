#!/bin/bash

# Determine the real user
REAL_USER=$(whoami)

# 1. Find the dockerd binary installed by Nix
DOCKERD_BIN=$(which dockerd 2>/dev/null)
if [ -z "$DOCKERD_BIN" ]; then
    echo "Error: dockerd not found in PATH."
    echo "Make sure you installed docker via nix-env or home-manager."
    exit 1
fi
echo "Found dockerd at: $DOCKERD_BIN"

# 2. Create the docker group if it doesn't exist
if getent group docker >/dev/null; then
    echo "Group 'docker' already exists."
else
    echo "Creating 'docker' group (requires sudo)..."
    sudo groupadd docker
    echo "Group 'docker' created."
fi

# 3. Add the user to the docker group
if id -nG "$REAL_USER" 2>/dev/null | grep -qw docker; then
    echo "User '$REAL_USER' is already in the 'docker' group."
else
    echo "Adding user '$REAL_USER' to 'docker' group (requires sudo)..."
    sudo usermod -aG docker "$REAL_USER"
    echo "User '$REAL_USER' added to 'docker' group."
fi

# 4. Create the Systemd Service file
SERVICE_FILE="/etc/systemd/system/docker.service"
if [ ! -f "$SERVICE_FILE" ]; then
    echo "Creating $SERVICE_FILE (requires sudo)..."
    sudo bash -c "cat <<EOF > $SERVICE_FILE
[Unit]
Description=Docker Application Container Engine (Nix)
After=network-online.target
Wants=network-online.target
[Service]
Type=notify
ExecStart=$DOCKERD_BIN -G docker
ExecReload=/bin/kill -s HUP \$MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF"

    echo "Reloading systemd and starting docker (requires sudo)..."
    sudo systemctl daemon-reload
    sudo systemctl enable docker
    sudo systemctl restart docker
else
    echo "Service file $SERVICE_FILE already exists, skipping."
fi

# 5. Done
echo "-------------------------------------------------------"
echo "SUCCESS!"
echo "1. The Docker daemon is now running as a system service."
echo "2. IMPORTANT: You MUST log out and log back in (or reboot)"
echo "   for the group changes to take effect for your user."
echo "-------------------------------------------------------"
