/* main.tf
  Alta3 Research - jhsgtv@gmail.com
  CHALLENGE 01 - terraform configuration file to deploy nginx container */

# Terraform block
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

# Provider block
provider "docker" {}

# Resource block
resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true    // keep image after "destroy"
}

# resource block - ensures an image will become present
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 2224
  }
}

