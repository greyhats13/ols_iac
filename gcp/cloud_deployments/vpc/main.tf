# create vpc from modules network
module "vpc" {
  source = "../../modules/network"
  # Naming Standard
  region  = "asia-southeast2"
  unit    = "bookstore"
  env     = "dev"
  code    = "network"
  feature = ["vpc", "subnet"]
  # vpc arguments
  subnetwork_ip_cidr_range = "10.0.0.0/16"
}