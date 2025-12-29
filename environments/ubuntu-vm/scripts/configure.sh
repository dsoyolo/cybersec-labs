#!/bin/bash
set -e

echo "=== Configuring Environment ==="

# Create useful directories
mkdir -p /home/student/labs
mkdir -p /home/student/tools
mkdir -p /home/student/downloads
chown -R student:student /home/student

# Configure bash aliases for student user
cat >> /home/student/.bashrc << 'EOF'

# Cybersecurity Lab Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ports='netstat -tulanp'
alias myip='curl -s ifconfig.me'
alias scan='nmap -sV -sC'
alias listen='netstat -tuln | grep LISTEN'

# Python shortcuts
alias py='python3'
alias venv='python3 -m venv'

# Docker shortcuts
alias dk='docker'
alias dkc='docker compose'

# Tool directories
export TOOLS_DIR="$HOME/tools"
export LABS_DIR="$HOME/labs"

# Add custom tools to PATH
export PATH="$HOME/tools/bin:$PATH"

# Colored prompts
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF

# Create a welcome message
cat > /etc/motd << 'EOF'
╔══════════════════════════════════════════════════════════╗
║                                                          ║
║        Welcome to Cybersecurity Lab Environment         ║
║                                                          ║
╚══════════════════════════════════════════════════════════╝

System Information:
  - OS: Ubuntu 22.04 LTS
  - Tools Directory: ~/tools
  - Labs Directory: ~/labs

Quick Start:
  - List installed tools: dpkg -l | grep -E '(nmap|wireshark|metasploit)'
  - Start lab environment: cd ~/labs
  - Documentation: /usr/share/doc/

Common Tools Installed:
  Network: nmap, wireshark, tcpdump, netcat
  Web: nikto, sqlmap, dirb
  Exploitation: metasploit, searchsploit
  Forensics: binwalk, foremost, autopsy
  Reverse Engineering: gdb, radare2

For help or issues, contact your instructor.

EOF

# Set vim as default editor
update-alternatives --set editor /usr/bin/vim.basic

# Configure tmux
cat > /home/student/.tmux.conf << 'EOF'
# Tmux configuration for better usability
set -g mouse on
set -g history-limit 10000
set -g base-index 1
setw -g pane-base-index 1

# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config
bind r source-file ~/.tmux.conf
EOF

chown student:student /home/student/.tmux.conf

# Create a tools inventory file
cat > /home/student/tools/TOOLS_LIST.md << 'EOF'
# Installed Security Tools

## Network Analysis
- nmap - Network discovery and security auditing
- wireshark/tshark - Network protocol analyzer
- tcpdump - Network packet capture
- netcat - TCP/IP swiss army knife
- netdiscover - Network address discovering tool

## Web Security
- nikto - Web server scanner
- dirb - Web content scanner
- sqlmap - SQL injection tool
- wpscan - WordPress security scanner

## Password & Hashing
- john - John the Ripper password cracker
- hashcat - Advanced password recovery
- hydra - Network logon cracker
- crunch - Wordlist generator

## Exploitation
- metasploit-framework - Penetration testing framework
- searchsploit - Exploit database search tool

## Forensics
- binwalk - Firmware analysis tool
- foremost - File recovery tool
- exiftool - Metadata reader/writer
- steghide - Steganography tool
- autopsy - Digital forensics platform

## Reverse Engineering
- gdb - GNU debugger
- radare2 - Reverse engineering framework
- strace - System call tracer
- ltrace - Library call tracer

## Development
- Python 3 with pip
- GCC/G++ compiler
- Ruby
- Docker

## Python Libraries
- pwntools - CTF framework
- scapy - Packet manipulation
- requests - HTTP library
- impacket - Network protocols
EOF

chown student:student /home/student/tools/TOOLS_LIST.md

# Create a sample lab structure
cat > /home/student/labs/README.md << 'EOF'
# Lab Exercises

This directory contains your lab exercises and solutions.

## Organization
Each lab should have its own directory:
```
labs/
├── lab01-network-scanning/
│   ├── README.md
│   ├── results.txt
│   └── screenshots/
├── lab02-web-security/
└── ...
```

## Best Practices
1. Document all findings
2. Save command outputs
3. Take screenshots of key steps
4. Clean up after each lab (unless instructed otherwise)
5. Never use these tools on networks/systems without permission

Happy hacking (ethically)!
EOF

chown -R student:student /home/student/labs

# Set proper permissions
chmod +x /home/student/.bashrc

# Initialize Metasploit database
msfdb init || true

# Update exploitdb
searchsploit -u || true

echo "=== Environment Configuration Complete ==="
