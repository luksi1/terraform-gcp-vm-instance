variable "instance_name" {
  type        = string
  description = "The name of the instance"
}

variable "credentials" {
  type        = string
  description = "The json file contains the credentials"
}

variable "project" {
  type        = string
  description = "The project name"
}

variable "region" {
  type        = string
  description = "The name of the region"
  default     = "europe-west4"
}

variable "zone" {
  type        = string
  description = "The name of the zone"
  default     = "europe-west4-a"
}

variable "image" {
  type        = string
  description = "The name of the image"
  default     = "ubuntu-1804-lts"
}

variable "machine_type" {
  type        = string
  description = "The machine type"
  default     = "f1-micro"
}

variable "ssh_pub_key_file" {
  type        = string
  description = "Public SSH key file"
  default     = "./id_rsa.pub"
}

provider "google" {
  credentials = var.credentials
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata_startup_script = "sudo add-apt-repository ppa:longsleep/golang-backports; curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add; sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'; sudo apt-get update; sudo apt-get install -y golang-go git docker"

  metadata = {
    ssh-keys = "${file(var.ssh_pub_key_file)}"
  }

  network_interface {
    network = "default"
    # If this is not included, the GCP instance will not contain an external IP
    access_config {
    }
  }

}

output "external_ip" {
  value = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}

