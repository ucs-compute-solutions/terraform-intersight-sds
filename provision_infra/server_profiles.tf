resource "intersight_server_profile" "storage-node1" {
  name = "storage-node1"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }

  assigned_server {
  moid = var.storage-node1
  object_type = "compute.RackUnit"
  }
  action = "Deploy"

}

  resource "intersight_server_profile" "storage-node2" {
    name = "storage-node2"
    organization {
      object_type = "organization.Organization"
      moid = var.org_moid
    }

    assigned_server {
    moid = var.storage-node2
    object_type = "compute.RackUnit"
    }
    action = "Deploy"

  }
