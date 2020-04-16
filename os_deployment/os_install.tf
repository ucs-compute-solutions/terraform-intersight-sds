
resource "intersight_os_install" "os-install-node1" {
  name = "os-install-node1"
  server {
    object_type = "compute.RackUnit"
    moid = var.storage-node1
  }
  image {
    object_type = "softwarerepository.OperatingSystemFile"
    moid = intersight_softwarerepository_operating_system_file.rhel-custom-iso-with-kickstart.moid
  }
  /*
  osdu_image {
    moid = intersight_firmware_server_configuration_utility_distributable.c240m5-scu.moid
    object_type = "firmware.ServerConfigurationUtilityDistributable"
  }
  */
  answers {
    source = "Embedded"
  }
  description = "OS install"
  install_method = "vMedia"

  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
}



resource "intersight_os_install" "os-install-node2" {
  name = "os-install-node2"
  server {
    object_type = "compute.RackUnit"
    moid = var.storage-node2
  }
  image {
    object_type = "softwarerepository.OperatingSystemFile"
    moid = intersight_softwarerepository_operating_system_file.rhel-custom-iso-with-kickstart.moid
  }
  /*
  osdu_image {
    moid = intersight_firmware_server_configuration_utility_distributable.c240m5-scu.moid
    object_type = "firmware.ServerConfigurationUtilityDistributable"
  }
  */
  answers {
    source = "Embedded"
  }
  description = "OS install"
  install_method = "vMedia"

  organization {
    object_type = "organization.Organization"
    moid = var.org_moid
  }
}
