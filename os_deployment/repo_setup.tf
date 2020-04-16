
resource "intersight_softwarerepository_operating_system_file" "rhel-custom-iso-with-kickstart" {
  version = "Red Hat Enterprise Linux 7.6"
  description = "RHEL 7.6 installer ISO with embedded kickstart"
  name = "rhel-custom-iso-with-kickstart"
  source {
    additional_properties = jsonencode({
      RemoteIp = var.remote-server
      RemoteShare = var.remote-share
      RemoteFile = var.remote-os-image
    })
    object_type = var.remote-protocol
  }
  vendor = "Red Hat"
  catalog {
    moid = "5d8a41e16567612d30aa0d6e"
  }
}



/*
resource "intersight_firmware_server_configuration_utility_distributable" "c240m5-scu" {
  name = "c240m5-scu"
  source {
    object_type = var.remote-protocol
    additional_properties = jsonencode({
      RemoteIp: var.remote-server
      RemoteShare: var.remote-share
      RemoteFile: var.remote-scu-image
    })
  }
  vendor = "Cisco"
  version = "6.0.(4c)"
  supported_models = [
    "C-series",
  ]
  description = "C240 M5 SCU"
  catalog {
    moid = "5d8a41e16567612d30aa0d6e"
  }
}
*/
