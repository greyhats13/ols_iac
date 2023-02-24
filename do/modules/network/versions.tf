## create digital ocean required providers block
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.7.0"
    }
  }
  required_version = ">= 1.3"
}
