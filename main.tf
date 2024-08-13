resource "google_notebooks_environment" "this" {
  count               = length(var.environment)
  location            = lookup(var.environment[count.index], "location")
  name                = lookup(var.environment[count.index], "name")
  display_name        = lookup(var.environment[count.index], "display_name")
  description         = lookup(var.environment[count.index], "description")
  post_startup_script = lookup(var.environment[count.index], "post_startup_script")
  project             = data.google_project.this.id

  dynamic "container_image" {
    for_each = lookup(var.environment[count.index], "container_image_repository") != null ? ["container_image"] : []
    content {
      repository = lookup(var.environment[count.index], "container_image_repository")
      tag        = lookup(var.environment[count.index], "container_image_tag")
    }
  }

  dynamic "vm_image" {
    for_each = lookup(var.environment[count.index], "vm_image_project") != null ? ["vm_image"] : []
    content {
      project      = try(element(var.environment_vm_image_project_id, lookup(var.environment[count.index], "vm_image_project_id")))
      image_name   = lookup(var.environment[count.index], "vm_image_image_name")
      image_family = lookup(var.environment[count.index], "vm_image_image_family")
    }
  }
}

resource "google_notebooks_instance" "this" {
  count                  = length(var.instance)
  location               = lookup(var.instance[count.index], "location")
  machine_type           = lookup(var.instance[count.index], "machine_type")
  name                   = lookup(var.instance[count.index], "name")
  project                = data.google_project.this.id
  instance_owners        = lookup(var.instance[count.index], "instance_owners")
  service_account_scopes = lookup(var.instance[count.index], "service_account_scopes")
  tags                   = lookup(var.instance[count.index], "tags")
  post_startup_script    = lookup(var.instance[count.index], "post_startup_script")
  service_account        = lookup(var.instance[count.index], "service_account")
  nic_type               = lookup(var.instance[count.index], "nic_type")
  network                = data.google_compute_network.this.id
  subnet                 = data.google_compute_subnetwork.this.id
  custom_gpu_driver_path = lookup(var.instance[count.index], "custom_gpu_driver_path")
  create_time            = lookup(var.instance[count.index], "create_time")
  boot_disk_type         = lookup(var.instance[count.index], "boot_disk_type")
  data_disk_type         = lookup(var.instance[count.index], "data_disk_type")
  kms_key                = lookup(var.instance[count.index], "kms_key")
  desired_state          = lookup(var.instance[count.index], "desired_state")
  disk_encryption        = lookup(var.instance[count.index], "disk_encryption")
  boot_disk_size_gb      = lookup(var.instance[count.index], "boot_disk_size_gb")
  data_disk_size_gb      = lookup(var.instance[count.index], "data_disk_size_gb")
  no_proxy_access        = lookup(var.instance[count.index], "no_proxy_access")
  no_public_ip           = lookup(var.instance[count.index], "no_public_ip")
  no_remove_data_disk    = lookup(var.instance[count.index], "no_remove_data_disk")
  install_gpu_driver     = lookup(var.instance[count.index], "install_gpu_driver")
  labels                 = merge(var.labels, lookup(var.instance[count.index], "labels"))
  metadata               = merge(lookup(var.instance[count.index], "metadata"), { terraform = "true" })

  dynamic "accelerator_config" {
    for_each = (lookup(var.instance[count.index], "accelerator_config_core_count") && lookup(var.instance[count.index], "accelerator_config_type")) != null ? ["accelerator_config"] : []
    content {
      core_count = lookup(var.instance[count.index], "accelerator_config_core_count")
      type       = lookup(var.instance[count.index], "accelerator_config_type")
    }
  }

  dynamic "container_image" {
    for_each = lookup(var.instance[count.index], "container_image_repository") != null ? ["container_image"] : []
    content {
      repository = lookup(var.instance[count.index], "container_image_repository")
      tag        = lookup(var.instance[count.index], "container_image_tag")
    }
  }

  dynamic "reservation_affinity" {
    for_each = lookup(var.instance[count.index], "reservation_affinity") == null ? [] : ["reservation_affinity"]
    content {
      consume_reservation_type = lookup(reservation_affinity.value, "consume_reservation_type")
      key                      = lookup(reservation_affinity.value, "key")
      values                   = lookup(reservation_affinity.value, "values")
    }
  }

  dynamic "shielded_instance_config" {
    for_each = lookup(var.instance[count.index], "shielded_instance_config") == null ? [] : ["shielded_instance_config"]
    content {
      enable_integrity_monitoring = lookup(shielded_instance_config.value, "enable_integrity_monitoring")
      enable_secure_boot          = lookup(shielded_instance_config.value, "enable_secure_boot")
      enable_vtpm                 = lookup(shielded_instance_config.value, "enable_vtpm")
    }
  }

  dynamic "vm_image" {
    for_each = lookup(var.instance[count.index], "vm_image_project") != null ? ["vm_image"] : []
    content {
      project      = try(element(var.instance_vm_image_project_id, lookup(var.instance[count.index], "vm_image_project_id")))
      image_family = lookup(var.instance[count.index], "vm_image_image_family")
      image_name   = lookup(var.instance[count.index], "vm_image_image_name")
    }
  }
}

resource "google_notebooks_instance_iam_member" "this" {
  count         = length(var.instance) == 0 ? 0 : length(var.instance_iam_member)
  instance_name = try(element(google_notebooks_instance.this.*.name, lookup(var.instance_iam_member[count.index], "instance_id")))
  member        = lookup(var.instance_iam_member[count.index], "member")
  role          = lookup(var.instance_iam_member[count.index], "role")

  dynamic "condition" {
    for_each = lookup(var.runtime_iam_member[count.index], "condition") == null ? [] : ["condition"]
    content {
      expression  = lookup(condition.value, "expression")
      title       = lookup(condition.value, "title")
      description = lookup(condition.value, "description")
    }
  }
}

resource "google_notebooks_location" "this" {
  count   = length(var.location)
  name    = lookup(var.location[count.index], "name")
  project = data.google_project.this.id
}

resource "google_notebooks_runtime" "this" {
  count    = length(var.runtime)
  location = lookup(var.runtime[count.index], "location")
  name     = lookup(var.runtime[count.index], "name")
  labels   = merge(var.labels, lookup(var.runtime[count.index], "labels"))
  project  = data.google_project.this.id

  dynamic "access_config" {
    for_each = (lookup(var.runtime[count.index], "access_config_type") || lookup(var.runtime[count.index], "access_config_runtime_owner")) == null ? [] : ["access_config"]
    content {
      access_type   = lookup(var.runtime[count.index], "access_config_type")
      runtime_owner = lookup(var.runtime[count.index], "access_config_runtime_owner")
    }
  }

  dynamic "software_config" {
    for_each = lookup(var.runtime[count.index], "software_config") == null ? [] : ["software_config"]
    content {
      notebook_upgrade_schedule    = lookup(software_config.value, "notebook_upgrade_schedule")
      enable_health_monitoring     = lookup(software_config.value, "enable_health_monitoring")
      idle_shutdown                = lookup(software_config.value, "idle_shutdown")
      idle_shutdown_timeout        = lookup(software_config.value, "idle_shutdown_timeout")
      install_gpu_driver           = lookup(software_config.value, "install_gpu_driver")
      custom_gpu_driver_path       = lookup(software_config.value, "custom_gpu_driver_path")
      post_startup_script          = lookup(software_config.value, "post_startup_script")
      post_startup_script_behavior = lookup(software_config.value, "post_startup_script_behavior")

      dynamic "kernels" {
        for_each = lookup(software_config.value, "kernels_repository") == null ? [] : ["kernels"]
        content {
          repository = lookup(software_config.value, "kernels_repository")
          tag        = lookup(software_config.value, "kernels_tag")
        }
      }
    }
  }

  dynamic "virtual_machine" {
    for_each = lookup(var.runtime[count.index], "virtual_machine") == null ? [] : ["virtual_machine"]
    content {
      dynamic "virtual_machine_config" {
        for_each = lookup(virtual_machine.value, "machine_type") == null ? [] : ["virtual_machine_config"]
        content {
          machine_type      = lookup(virtual_machine.value, "machine_type")
          network           = lookup(virtual_machine.value, "network")
          subnet            = lookup(virtual_machine.value, "subnet")
          nic_type          = lookup(virtual_machine.value, "nic_type")
          reserved_ip_range = lookup(virtual_machine.value, "reserved_ip_range")
          internal_ip_only  = lookup(virtual_machine.value, "internal_ip_only")
          tags              = lookup(virtual_machine.value, "tags")
          metadata          = merge(lookup(virtual_machine.value, "metadata"), { terraform = "true" })
          labels            = merge(lookup(virtual_machine.value, "labels"), var.labels)

          dynamic "accelerator_config" {
            for_each = (lookup(virtual_machine.value, "accelerator_config_type") || lookup(virtual_machine.value, "accelerator_config_core_count")) == null ? [] : ["accelerator_config"]
            content {
              type       = lookup(virtual_machine.value, "accelerator_config_type")
              core_count = lookup(virtual_machine.value, "accelerator_config_core_count")
            }
          }

          dynamic "container_images" {
            for_each = lookup(virtual_machine.value, "container_images_repository") == null ? [] : ["container_images"]
            content {
              repository = lookup(virtual_machine.value, "container_images_repository")
              tag        = lookup(virtual_machine.value, "container_images_tag")
            }
          }

          dynamic "data_disk" {
            for_each = lookup(virtual_machine.value, "data_disk") == null ? [] : ["data_disk"]
            content {
              interface = lookup(data_disk.value, "interface")
              mode      = lookup(data_disk.value, "mode")
              source    = lookup(data_disk.value, "source")
              type      = lookup(data_disk.value, "type")

              dynamic "initialize_params" {
                for_each = lookup(data_disk.value, "initialize_params") == null ? [] : ["initialize_params"]
                content {
                  description  = lookup(initialize_params.value, "description")
                  disk_name    = lookup(initialize_params.value, "disk_name")
                  disk_size_gb = lookup(initialize_params.value, "disk_size_gb")
                  disk_type    = lookup(initialize_params.value, "disk_type")
                  labels       = merge(lookup(initialize_params.value, "labels", var.labels))
                }
              }
            }
          }

          dynamic "encryption_config" {
            for_each = lookup(virtual_machine.value, "encryption_config_kms_key_id") == null ? [] : ["encryption_config"]
            content {
              kms_key = lookup(virtual_machine.value, "encryption_config_kms_key_id")
            }
          }

          dynamic "shielded_instance_config" {
            for_each = lookup(virtual_machine.value, "shielded_instance_config") == null ? [] : ["shielded_instance_config"]
            content {
              enable_integrity_monitoring = lookup(shielded_instance_config.value, "enable_integrity_monitoring")
              enable_secure_boot          = lookup(shielded_instance_config.value, "enable_secure_boot")
              enable_vtpm                 = lookup(shielded_instance_config.value, "enable_vtpm")
            }
          }
        }
      }
    }
  }
}

resource "google_notebooks_runtime_iam_member" "this" {
  count        = length(var.runtime) == 0 ? 0 : length(var.runtime_iam_member)
  member       = lookup(var.runtime_iam_member[count.index], "member")
  role         = lookup(var.runtime_iam_member[count.index], "role")
  runtime_name = try(element(google_notebooks_runtime.this.*.name, lookup(var.runtime_iam_member[count.index], "runtime_id")))

  dynamic "condition" {
    for_each = lookup(var.runtime_iam_member[count.index], "condition") == null ? [] : ["condition"]
    content {
      expression  = lookup(condition.value, "expression")
      title       = lookup(condition.value, "title")
      description = lookup(condition.value, "description")
    }
  }
}