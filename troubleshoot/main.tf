terraform {                             # TERRAFORM BLOCK WAS MISSING
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"             # USE THE CORRECT VERSION
    }
  }
}                                       

provider "docker" {}

variable "container_name" {                                         # THIS
  description = "Value of the name for the Docker container"        # VARIABLE
  # basic types include string, number and bool                     # BLOCK
  type    = string                                                  # WAS
  default = "ExampleNginxContainer"                                 # MISSING
  }                                                                 # !

output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.id      # TYPO- IT'S "docker_image" NOT "dockerimage"
}

resource "docker_image" "nginx" {
  name         = "nginx:1.23.2"            # USING VERSION NUMBER INSTEAD OF "LATEST"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id      # CHANGE "LATEST" TO "IMAGE_ID"
  name  = var.container_name
  ports {
    internal = 80
    external = 8089
  }
}                                          # MISSING CLOSING }
