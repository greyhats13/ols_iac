resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.unit}-${var.code}-${var.feature[0]}-${var.env}"
  region  = var.region
  version = data.digitalocean_kubernetes_versions.versions.latest_version

  node_pool {
    name       = "${var.unit}-${var.code}-${var.feature[1]}-${var.env}"
    size       = var.node_type
    auto_scale = var.auto_scale
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
    labels     = var.node_labels
    dynamic "taint" {
      for_each = length(var.node_taint) > 0 ? var.node_taint : {}
      content {
        key    = taint.value["key"]
        value  = taint.value["value"]
        effect = taint.value["effect"]
      }
    }
  }
  
  tags     = [var.unit, var.code, var.feature[0], var.env]
  vpc_uuid = data.terraform_remote_state.vpc.outputs.do_vpc_id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
