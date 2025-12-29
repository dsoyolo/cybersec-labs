#!/bin/bash
# Don't exit on errors - some packages may not be available
# set -e

# Non-interactive mode
export DEBIAN_FRONTEND=noninteractive

echo "=== Installing Cybersecurity Tools ==="
echo "Note: Some packages may not be available in default repositories"

# Pre-configure wireshark to not prompt
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections

# Network Analysis Tools
echo "Installing network analysis tools..."
apt-get install -y \
    nmap \
    wireshark \
    tshark \
    tcpdump \
    netcat-openbsd \
    socat \
    net-tools \
    dnsutils \
    traceroute \
    whois \
    netdiscover \
    arp-scan

# Web Security Tools
echo "Installing web security tools..."
apt-get install -y \
    curl \
    wget \
    nikto \
    dirb \
    sqlmap || echo "Some web security tools not available, continuing..."

# Password Cracking & Hash Tools
echo "Installing password and hash tools..."
apt-get install -y \
    john \
    hashcat \
    hydra \
    crunch || echo "Some password tools not available, continuing..."

# Exploitation & Penetration Testing
echo "Installing penetration testing frameworks..."
apt-get install -y \
    metasploit-framework \
    exploitdb \
    searchsploit || echo "Some pentesting tools not available, continuing..."

# Forensics Tools
echo "Installing forensics tools..."
apt-get install -y \
    binwalk \
    foremost \
    exiftool \
    steghide \
    autopsy || echo "Some forensics tools not available, continuing..."

# Reverse Engineering & Binary Analysis
echo "Installing reverse engineering tools..."
apt-get install -y \
    gdb \
    radare2 \
    binutils \
    strace \
    ltrace \
    hexedit \
    ghex || echo "Some reverse engineering tools not available, continuing..."

# Development Tools
echo "Installing development tools..."
apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    gcc \
    g++ \
    make \
    cmake \
    ruby \
    ruby-dev

# Install Python security libraries
echo "Installing Python security libraries..."
pip3 install --break-system-packages \
    pwntools \
    scapy \
    requests \
    beautifulsoup4 \
    paramiko \
    cryptography \
    impacket

# Wireless Tools (if needed)
echo "Installing wireless tools..."
apt-get install -y \
    aircrack-ng \
    reaver \
    pixiewps

# Miscellaneous Utilities
echo "Installing miscellaneous utilities..."
apt-get install -y \
    vim \
    tmux \
    tree \
    htop \
    unzip \
    p7zip-full \
    jq \
    yq

# Docker (useful for containerized labs)
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add student user to docker group
usermod -aG docker student

# Configure wireshark to allow non-root capture
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common
usermod -aG wireshark student

echo "=== Security Tools Installation Complete ==="
