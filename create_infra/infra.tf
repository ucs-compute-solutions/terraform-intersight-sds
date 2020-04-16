resource "intersight_adapter_config_policy" "sds-adapter-config-policy" {
  name        = "sds-adapter-config-policy"
  description = "Adapter Configuration Policy for SDS"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  settings {
    slot_id = "MLOM"
    eth_settings {
      lldp_enabled = true
    }
    fc_settings {
      fip_enabled = true
    }
  }



  profiles {
    moid        = intersight_server_profile.storage-node1.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.storage-node2.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.controller.id
    object_type = "server.Profile"
  }
}


output "out1" {
value=intersight_adapter_config_policy.sds-adapter-config-policy
}



resource "intersight_vnic_eth_adapter_policy" "sds-ethernet-adapter-policy" {
  name = "sds-ethernet-adapter-policy"
  description = "Ethernet Adapter Policy for SDS"
  rss_settings = true
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  vxlan_settings {
    enabled = false
  }

  nvgre_settings {
    enabled = false
  }

  arfs_settings {
    enabled = false
  }

  interrupt_settings {
    coalescing_time = 125
    coalescing_type = "MIN"
    count           = 32
    mode            = "MSI"
  }
  completion_queue_settings {
    count     = 16
    ring_size = 1
  }
  rx_queue_settings {
    count     = 8
    ring_size = 4096
  }
  tx_queue_settings {
    count     = 8
    ring_size = 4096
  }
  tcp_offload_settings {
    large_receive = true
    large_send    = true
    rx_checksum   = true
    tx_checksum   = true
  }

}




resource "intersight_vnic_eth_network_policy" "sds-management-network" {
  name = "sds-management-network"
  description = "Management Network for SDS"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  vlan_settings {
    default_vlan = var.management_vlan
    mode         = "TRUNK"
  }
}



resource "intersight_vnic_eth_network_policy" "sds-client-network" {
  name = "sds-client-network"
  description = "Client Network for SDS"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  vlan_settings {
    default_vlan = var.client_vlan
    mode         = "TRUNK"
  }
}



resource "intersight_vnic_eth_network_policy" "sds-cluster-network" {
  name = "sds-cluster-network"
  description = "Cluster Network for SDS"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  vlan_settings {
    default_vlan = var.cluster_vlan
    mode         = "TRUNK"
  }
}



resource "intersight_vnic_eth_network_policy" "sds-replication-network" {
  name = "sds-replication-network"
  description = "Replication Network for SDS"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  vlan_settings {
    default_vlan = var.replication_vlan
    mode         = "TRUNK"
  }
}


resource "intersight_vnic_eth_qos_policy" "sds-ethernet-qos-policy" {
  name           = "sds-ethernet-qos-policy"
  description = "Ethernet quality of service for SDS"
  mtu            = 9000
  rate_limit     = 0
  cos            = 0
  trust_host_cos = false
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
}



resource "intersight_vnic_lan_connectivity_policy" "sds-lan-connectivity-policy" {
  name = "sds-lan-connectivity-policy"
  description = "LAN Connectivity Policy for SDS"
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  profiles {
    moid        = intersight_server_profile.storage-node1.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.storage-node2.id
    object_type = "server.Profile"
  }
profiles {
    moid        = intersight_server_profile.controller.id
    object_type = "server.Profile"
  }
}


resource "intersight_vnic_eth_if" "eth0" {
  name  = "eth0"
  order = 0
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  placement {
    id     = "MLOM"
    pci_link = 0
    uplink = 0
  }
  cdn {
    source = "vnic"
  }
  vmq_settings {
    enabled = false
  }
  lan_connectivity_policy {
    moid        = intersight_vnic_lan_connectivity_policy.sds-lan-connectivity-policy.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.sds-management-network.id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.sds-ethernet-adapter-policy.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.sds-ethernet-qos-policy.id
  }
}



resource "intersight_vnic_eth_if" "eth1" {
  name  = "eth1"
  order = 1
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  placement {
    id     = "MLOM"
    pci_link = 0
    uplink = 1
  }
  cdn {
    source = "vnic"
  }
  vmq_settings {
    enabled = false
  }
  lan_connectivity_policy {
    moid        = intersight_vnic_lan_connectivity_policy.sds-lan-connectivity-policy.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.sds-client-network.id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.sds-ethernet-adapter-policy.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.sds-ethernet-qos-policy.id
  }
}



resource "intersight_vnic_eth_if" "eth2" {
  name  = "eth2"
  order = 2
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  placement {
    id     = "MLOM"
    pci_link = 0
    uplink = 0
  }
  cdn {
    source = "vnic"
  }
  vmq_settings {
    enabled = false
  }
  lan_connectivity_policy {
    moid        = intersight_vnic_lan_connectivity_policy.sds-lan-connectivity-policy.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.sds-cluster-network.id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.sds-ethernet-adapter-policy.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.sds-ethernet-qos-policy.id
  }
}



resource "intersight_vnic_eth_if" "eth3" {
  name  = "eth3"
  order = 3
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  placement {
    id     = "MLOM"
    pci_link = 0
    uplink = 0
  }
  cdn {
    source = "vnic"
  }
  vmq_settings {
    enabled = false
  }
  lan_connectivity_policy {
    moid        = intersight_vnic_lan_connectivity_policy.sds-lan-connectivity-policy.id
    object_type = "vnic.LanConnectivityPolicy"
  }
  eth_network_policy {
    moid = intersight_vnic_eth_network_policy.sds-replication-network.id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.sds-ethernet-adapter-policy.id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.sds-ethernet-qos-policy.id
  }
}





resource "intersight_ntp_policy" "sds-ntp-policy" {
  name    = "sds-ntp-policy"
  enabled = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "171.68.38.65",
    "173.38.201.115"
  ]
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }

  profiles {
    moid        = intersight_server_profile.storage-node1.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.storage-node2.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.controller.id
    object_type = "server.Profile"
  }
}



resource "intersight_storage_disk_group_policy" "sds-disk-group-policy" {
  name        = "sds-disk-group-policy"
  description = "Disk Group Policy for SDS"
  raid_level  = "Raid1"
  use_jbods   = true
  span_groups {
    disks {
      slot_number = 13
    }
    disks {
      slot_number = 14
    }
  }
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
}



resource "intersight_storage_storage_policy" "sds-storage-policy" {
  name                         = "sds-storage-policy"
  description                  = "Storage Policy for OS boot drive"
  retain_policy_virtual_drives = false
  unused_disks_state           = "Jbod"
  virtual_drives {
    object_type = "storage.VirtualDriveConfig"
    boot_drive = true
    drive_cache = "Default"
    expand_to_available = true
    io_policy = "Default"
    name = "sds-os-boot"
    access_policy = "ReadWrite"
    disk_group_policy = intersight_storage_disk_group_policy.sds-disk-group-policy.id
    read_policy = "ReadAhead"
    write_policy = "WriteBackGoodBbu"
  }
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }

  profiles {
    moid        = intersight_server_profile.storage-node1.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.storage-node2.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.controller.id
    object_type = "server.Profile"
  }
}




resource "intersight_boot_precision_policy" "sds-boot-policy" {
  name                     = "sds-boot-policy"
  description              = "Boot Policy for SDS"
  configured_boot_mode     = "Legacy"
  enforce_uefi_secure_boot = false
  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
  boot_devices {
    enabled     = true
    name        = "disk"
    object_type = "boot.LocalDisk"
    additional_properties = jsonencode({
      Slot = "MRAID"
    })
  }
  boot_devices {
    enabled     = true
    name        = "vmedia"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "cimc-mapped-dvd"
    })
  }

  profiles {
    moid        = intersight_server_profile.storage-node1.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.storage-node2.id
    object_type = "server.Profile"
  }
  profiles {
    moid        = intersight_server_profile.controller.id
    object_type = "server.Profile"
  }
}
