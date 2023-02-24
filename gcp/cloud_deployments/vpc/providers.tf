# create gcp provider
provider "google" {
  credentials = file("../../secrets/bookstore-378116-4691bbf162b5.json")
  project     = "bookstore-378116"
  region      = "asia-southeast2"
}