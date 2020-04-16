resource "intersight_firmware_upgrade" "sds-firmware-update" {
  upgrade_type =  "network_upgrade"


  network_share {
    map_type = "nfs"

    nfs_server {
        remote_ip = var.remote-server
        remote_share = var.remote-share
        remote_file = var.remote-huu
    }

    cifs_server {
        remote_ip = var.remote-server
        remote_share = var.remote-share
        remote_file = var.remote-huu
    }

    http_server {
      location_link = "http://172.21.87.164/ucs-c240m5-huu-4.1.1d.iso"
    }
  }


  server {
    object_type = "compute.RackUnit"
    moid = var.storage-node2
  }
}
