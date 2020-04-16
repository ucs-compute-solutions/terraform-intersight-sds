//Define all the basic variables here


variable "org_moid" {
  default = "<Managed object ID for Org>"
}


variable "management_vlan" {
  default = <VLAN ID for management>
}


variable "client_vlan" {
  default = <VLAN ID for client network>
}


variable "cluster_vlan" {
  default = <VLAN ID for cluster network>
}

variable "replication_vlan" {
  default = <VLAN ID for replication network>
}


variable "storage-node1" {
  default = "<Managed object ID for this node"
}



variable "storage-node2" {
  default = "<Managed object ID for this node"
}


variable "storage-node3" {
  default = "<Managed object ID for this node"
}



variable "remote-server" {
  default = "<remote_server_ip>"
}



variable "remote-share" {
  default = "<remote_share_path>"
}


variable "remote-os-image" {
  default = "<OS_IMAGE_ISO_name>"
}


variable "remote-scu-image" {
  default = "<SCU_IMAGE_ISO_name>"
}


variable "remote-protocol" {
  default = "<remote_protocol - Ex: softwarerepository.NfsServer>"
}


variable "remote-huu" {
  default = "<HUU_IMAGE_ISO_name>"
}
