# Cybersecurity Lab Environment

This repository contains lab environments for cybersecurity coursework.

## Repository Structure

```
cybersec-labs/
├── README.md                          # This file
├── environments/
│   └── docker/                        # Dockerfile
│   └── ubuntu-vm/                     # Base Ubuntu security VM
│       ├── packer/                    # Packer build automation w/ Vagrant
│       └── scripts/                   # Provisioning scripts
└── .github/workflows/                 # GH Actions to build artifacts
    ├── build-docker.yml
    ├── build-vm.yml
    ├── test-docker.yml
    └── test-vm.yml
```

## Prerequisites

Students running Windows may choose either option. Sudents running Mac or Linux must use Docker.
Students may install:
- [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Quick Start

### For Windows Users: VirtualBox VM

**Download:** [Latest Release](https://github.com/dsoyolo/cybersec-labs/releases/latest) → `ubuntu-vm.tar.gz`

```bash
# 1. Install VirtualBox (free)
# Download from: https://www.virtualbox.org/

# 2. Extract the tar.gz file
# On Windows: Right-click → Extract

# 3. Import to VirtualBox
# File → Import Appliance → Select box.ovf

# 4. Start and login
# Username: student
# Password: cybersec2026
```

### VirtualBox VM Default Configuration

- **OS:** Ubuntu 22.04 LTS
- **RAM:** 2GB (configurable)
- **CPUs:** 2 cores (configurable)
- **Disk:** 40GB (configurable)
- **Username:** student
- **Password:** cybersec2026
- **Hostname:** cybersec-lab

### VirtualBox Issues:

**"VT-x not available"**
- Enable virtualization in BIOS/UEFI

**"Import failed"**
- Re-download the .box file
- Extract and import box.ovf manually

**VM is slow**
- Close other programs
- Increase RAM: Settings → System → 4096 MB
- Increase CPUs: Settings → System → Processor → 2-4 CPUs
- If still slow: Switch to Docker setup

---

### Alternative: Docker (AMDx86_64 & ARM64)

```bash
# For Windows & Mac
docker pull ghcr.io/dsoyolo/cybersec-labs/cybersec-lab:latest
docker run -it --rm cybersec-lab
```

```bash
# ALternative: Build locally
git clone https://github.com/dsoyolo/cybersec-labs.git
cd cybersec-labs/environments/docker

# Build natively
docker build -t cybersec-lab .

# Run it
docker run -it --rm cybersec-lab
```

### Docker Container Default Configuration

- **OS:** Ubuntu 22.04 LTS
- **RAM:** ~200 MB
- **Disk:** 500 MB
- **Username:** student
- **Password:** cybersec2026
- **Hostname:** cybersec-lab

Note: Docker container runs as user `student` by default. Login with password is not required for Docker Desktop.

### Docker Troubleshooting

**"Cannot connect to Docker daemon"**
- Make sure Docker Desktop is running.

**"docker: command not found"**
- Install Docker Desktop and restart your terminal.

## Further Support

If you encounter issues:
1. Ensure your VirtualBox and/or Docker Desktop meet requirements
2. Prefer Docker Desktop over VirtualBox if having issue with VirtualBox
3. Contact your professor by email

## License

Educational use only for this course.
