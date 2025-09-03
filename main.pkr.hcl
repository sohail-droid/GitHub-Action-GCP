packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "default" {
  project_id      = "training-2024-batch"
  zone            = "us-central1-a"
  source_image_family = "ubuntu-2204-lts"
  source_image_project = ["ubuntu-os-cloud"]

  image_name      = "smd-myapp-${formatdate("YYYYMMDDHHmmss", timestamp())}"
  ssh_username    = "ubuntu"
}

build {
  sources = ["source.googlecompute.default"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx git",
      "echo 'Hello World'"
    ]
  }
}

