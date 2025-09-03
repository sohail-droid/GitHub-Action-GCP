packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "default" {
  project_id         = "training-2024-batch"
  machine_type       = "e2-standard-2"
  zone               = "us-central1-a"
  network            = "projects/training-2024-batch/global/networks/default"
  subnetwork         = "projects/training-2024-batch/regions/us-central1/subnetworks/default"
  source_image_family = "ubuntu-2204-lts"
  ssh_username       = "ubuntu"
  tags = ["allow-ssh"]
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
