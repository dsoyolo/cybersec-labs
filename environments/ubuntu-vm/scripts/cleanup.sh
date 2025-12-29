#!/bin/bash
set -e

echo "=== Cleaning Up VM ==="

# Clean apt cache
apt-get autoremove -y
apt-get autoclean -y
apt-get clean -y

# Remove temporary files
rm -rf /tmp/*
rm -rf /var/tmp/*

# Clear bash history
cat /dev/null > ~/.bash_history
cat /dev/null > /home/student/.bash_history || true

# Clear log files
find /var/log -type f -exec truncate -s 0 {} \;

# Remove cloud-init artifacts
rm -rf /var/lib/cloud/instances/*
rm -rf /var/lib/cloud/instance

# Clear machine-id for uniqueness
truncate -s 0 /etc/machine-id
rm -f /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Clear network persistent rules
rm -f /etc/udev/rules.d/70-persistent-net.rules

# Clear SSH host keys (will be regenerated on first boot)
rm -f /etc/ssh/ssh_host_*

# Zero out free space to reduce image size
echo "Zeroing free space (this may take a while)..."
dd if=/dev/zero of=/EMPTY bs=1M 2>/dev/null || true
rm -f /EMPTY

# Sync filesystem
sync

echo "=== Cleanup Complete ==="
