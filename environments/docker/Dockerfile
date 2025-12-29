FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update system and install basic utilities
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    gnupg \
    lsb-release \
    curl \
    wget \
    vim \
    git \
    build-essential \
    sudo

# Install Network Analysis Tools
RUN apt-get install -y \
    nmap \
    tcpdump \
    netcat-openbsd \
    socat \
    net-tools \
    dnsutils \
    traceroute \
    whois \
    netdiscover \
    arp-scan

# Install Web Security Tools
RUN apt-get install -y \
    curl \
    wget \
    nikto \
    dirb \
    sqlmap

# Install Password Tools
RUN apt-get install -y \
    john \
    hashcat \
    hydra \
    crunch

# Install Forensics Tools
RUN apt-get install -y \
    foremost \
    exiftool \
    steghide

# Note: binwalk installed later via pip (after Python installation)

# Install Reverse Engineering Tools
RUN apt-get install -y \
    gdb \
    binutils \
    strace \
    ltrace \
    hexedit \
    ghex

# Note: radare2 not in Ubuntu 22.04 default repos
# Alternative: Install manually if needed:
# git clone https://github.com/radareorg/radare2 && cd radare2 && sys/install.sh

# Install Development Tools
RUN apt-get install -y \
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
# First upgrade pip to latest version
RUN python3 -m pip install --upgrade pip

# Install packages (no --break-system-packages needed in Docker)
RUN pip3 install \
    pwntools \
    scapy \
    requests \
    beautifulsoup4 \
    paramiko \
    cryptography

# Note: binwalk has dependency issues in both apt and pip versions
# Skipping binwalk - other forensics tools (foremost, exiftool, steghide) are available
# Students can install manually if needed: pip3 install git+https://github.com/ReFirmLabs/binwalk.git

# Install Miscellaneous Utilities
RUN apt-get install -y \
    tmux \
    tree \
    htop \
    unzip \
    p7zip-full \
    jq

# Clean up
RUN apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create student user
RUN useradd -m -s /bin/bash student && \
    echo "student:cybersec2026" | chpasswd && \
    usermod -aG sudo student && \
    echo "student ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/student && \
    chmod 440 /etc/sudoers.d/student

# Create directory structure
RUN mkdir -p /home/student/labs /home/student/tools /home/student/downloads && \
    chown -R student:student /home/student

# Configure bash for student user
RUN echo "alias ll='ls -alF'" >> /home/student/.bashrc && \
    echo "alias la='ls -A'" >> /home/student/.bashrc && \
    echo "alias l='ls -CF'" >> /home/student/.bashrc && \
    echo "alias ports='netstat -tulanp'" >> /home/student/.bashrc && \
    echo "alias py='python3'" >> /home/student/.bashrc && \
    echo 'export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> /home/student/.bashrc

# Create welcome message
RUN echo '╔══════════════════════════════════════════════════════════╗' > /etc/motd && \
    echo '║                                                          ║' >> /etc/motd && \
    echo '║        Welcome to Cybersecurity Lab Environment          ║' >> /etc/motd && \
    echo '║                  (Docker Container)                      ║' >> /etc/motd && \
    echo '║                                                          ║' >> /etc/motd && \
    echo '╚══════════════════════════════════════════════════════════╝' >> /etc/motd && \
    echo '' >> /etc/motd && \
    echo 'Available Tools:' >> /etc/motd && \
    echo '  Network: nmap, tcpdump, netcat' >> /etc/motd && \
    echo '  Web: nikto, sqlmap, dirb' >> /etc/motd && \
    echo '  Passwords: john, hashcat, hydra' >> /etc/motd && \
    echo '  Forensics: foremost, exiftool, steghide' >> /etc/motd && \
    echo '  Reverse Engineering: gdb, strace, ltrace, hexedit' >> /etc/motd && \
    echo '  Python: pwntools, scapy, requests, cryptography' >> /etc/motd && \
    echo '' >> /etc/motd && \
    echo 'Directories:' >> /etc/motd && \
    echo '  ~/labs - Lab exercises' >> /etc/motd && \
    echo '  ~/tools - Additional tools' >> /etc/motd && \
    echo '' >> /etc/motd

# Switch to student user
USER student
WORKDIR /home/student

# Display motd on container start
CMD ["bash", "-c", "cat /etc/motd && exec bash"]