# Packer configuration - Production approach
# Extends official Ubuntu Vagrant box instead of building from scratch

packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

# Variables
variable "base_box" {
  type    = string
  default = "ubuntu/jammy64"  # Official Ubuntu 22.04 box
}

variable "vm_name" {
  type    = string
  default = "ubuntu-vm"
}

variable "version" {
  type    = string
  default = "1.0.0"
}

# Source: Start from official Ubuntu box
source "vagrant" "ubuntu" {
  communicator = "ssh"
  source_path  = var.base_box
  provider     = "virtualbox"
  
  add_force    = true
  
  output_dir   = "output-${var.vm_name}"
  
  # No need to configure SSH - the base box already has it working
}

# Build
build {
  sources = ["source.vagrant.ubuntu"]
  
  # Update system
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y"
    ]
  }

  # Create student user FIRST (before configure.sh needs it)
  provisioner "shell" {
    inline = [
      "sudo useradd -m -s /bin/bash -G sudo student || echo 'User may already exist'",
      "echo 'student:cybersec2026' | sudo chpasswd",
      "echo 'student ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/student"
    ]
  }

# Install security tools
  provisioner "shell" {
    script          = "../scripts/provision.sh"
    execute_command = "echo 'vagrant' | {{.Vars}} DEBIAN_FRONTEND=noninteractive sudo -S -E bash '{{.Path}}'"
  }
  
  # Configure environment
  provisioner "shell" {
    script          = "../scripts/configure.sh"
    execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
  }
  
  # Cleanup
  provisioner "shell" {
    script          = "../scripts/cleanup.sh"
    execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
  }

}
