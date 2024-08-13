variable "project_id" {
  type    = string
  default = null
}

variable "environment_vm_image_project_id" {
  type    = string
  default = null
}

variable "instance_vm_image_project_id" {
  type    = string
  default = null
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "network_name" {
  type    = string
  default = null
}

variable "subnetwork_name" {
  type    = string
  default = null
}

variable "environment" {
  type = list(object({
    id                         = number
    location                   = string
    name                       = string
    display_name               = optional(string)
    description                = optional(string)
    post_startup_script        = optional(string)
    container_image_repository = optional(any)
    container_image_tag        = optional(string)
    vm_image_project_id        = optional(any)
    vm_image_name              = optional(string)
    vm_image_family            = optional(string)
  }))
  default = []
}

variable "instance" {
  type = list(object({
    id                            = number
    location                      = string
    machine_type                  = string
    name                          = string
    instance_owners               = optional(list(string))
    service_account_scopes        = optional(list(string))
    tags                          = optional(list(string))
    post_startup_script           = optional(string)
    service_account               = optional(string)
    nic_type                      = optional(string)
    network                       = optional(string)
    subnet                        = optional(string)
    custom_gpu_driver_path        = optional(string)
    create_time                   = optional(string)
    boot_disk_type                = optional(string)
    data_disk_type                = optional(string)
    kms_key                       = optional(string)
    desired_state                 = optional(string)
    disk_encryption               = optional(string)
    boot_disk_size_gb             = optional(number)
    data_disk_size_gb             = optional(number)
    no_proxy_access               = optional(bool)
    no_public_ip                  = optional(bool)
    no_remove_data_disk           = optional(bool)
    install_gpu_driver            = optional(bool)
    labels                        = optional(map(string))
    metadata                      = optional(map(string))
    accelerator_config_type       = optional(string)
    accelerator_config_core_count = optional(number)
    container_image_repository    = optional(string)
    container_image_tag           = optional(string)
    vm_image_project_id           = optional(any)
    vm_image_name                 = optional(string)
    vm_image_family               = optional(string)
    reservation_affinity = optional(list(object({
      consume_reservation_type = string
      key                      = optional(string)
      values                   = optional(list(string))
    })))
    shielded_instance_config = optional(list(object({
      enable_integrity_monitoring = optional(bool)
      enable_secure_boot          = optional(bool)
      enable_vtpm                 = optional(bool)
    })))
  }))
  default = []

  description = <<EOF
A Cloud AI Platform Notebook instance.
- nic_type : Possible values are: UNSPECIFIED_NIC_TYPE, VIRTIO_NET, GVNIC.
- boot_disk_type : Possible values are: DISK_TYPE_UNSPECIFIED, PD_STANDARD, PD_SSD, PD_BALANCED, PD_EXTREME.
- boot_disk_size_gb : The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB). The minimum recommended value is 100 GB. If not specified, this defaults to 100.
- data_disk_type : Possible values are: DISK_TYPE_UNSPECIFIED, PD_STANDARD, PD_SSD, PD_BALANCED, PD_EXTREME.
- data_disk_size_gb : The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB). The minimum recommended value is 100 GB. If not specified, this defaults to 100.
- disk_encryption : Possible values are: DISK_ENCRYPTION_UNSPECIFIED, GMEK, CMEK.
- desired_state : Set this field to ACTIVE to start the Instance, and STOPPED to stop the Instance.
- accelerator_config_type : Possible values are: ACCELERATOR_TYPE_UNSPECIFIED, NVIDIA_TESLA_K80, NVIDIA_TESLA_P100, NVIDIA_TESLA_V100, NVIDIA_TESLA_P4, NVIDIA_TESLA_T4, NVIDIA_TESLA_T4_VWS, NVIDIA_TESLA_P100_VWS, NVIDIA_TESLA_P4_VWS, NVIDIA_TESLA_A100, TPU_V2, TPU_V3.
- reservation_affinity.consume_reservation_type : Possible values are: NO_RESERVATION, ANY_RESERVATION, SPECIFIC_RESERVATION.
EOF

  validation {
    condition = length([
      for a in var.instance : true if contains(["UNSPECIFIED_NIC_TYPE", "VIRTIO_NET", "GVNIC"], a.nic_type)
    ]) == length(var.instance)
    error_message = "Possible values are: UNSPECIFIED_NIC_TYPE, VIRTIO_NET, GVNIC."
  }

  validation {
    condition = length([
      for b in var.instance : true if contains(["DISK_TYPE_UNSPECIFIED", "PD_STANDARD", "PD_SSD", "PD_BALANCED", "PD_EXTERNE"], b.boot_disk_type)
    ]) == length(var.instance)
    error_message = "Possible values are: DISK_TYPE_UNSPECIFIED, PD_STANDARD, PD_SSD, PD_BALANCED, PD_EXTREME."
  }

  validation {
    condition = length([
      for c in var.instance : true if c.boot_disk_size_gb >= 100 && c.boot_disk_size_gb <= 64000
    ]) == length(var.instance)
    error_message = "The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB). The minimum recommended value is 100 GB. If not specified, this defaults to 100."
  }

  validation {
    condition = length([
      for d in var.instance : true if contains(["DISK_TYPE_UNSPECIFIED", "PD_STANDARD", "PD_SSD", "PD_BALANCED", "PD_EXTREME"], d.data_disk_type)
    ]) == length(var.instance)
    error_message = "Possible values are: DISK_TYPE_UNSPECIFIED, PD_STANDARD, PD_SSD, PD_BALANCED, PD_EXTREME."
  }

  validation {
    condition = length([
      for e in var.instance : true if e.data_disk_size_gb >= 100 && e.data_disk_size_gb <= 64000
    ]) == length(var.instance)
    error_message = "The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB). The minimum recommended value is 100 GB. If not specified, this defaults to 100."
  }

  validation {
    condition = length([
      for f in var.instance : true if contains(["DISK_ENCRYPTION_UNSPECIFIED", "GMEK", "CMEK"], f.disk_encryption)
    ]) == length(var.instance)
    error_message = "Possible values are: DISK_ENCRYPTION_UNSPECIFIED, GMEK, CMEK."
  }

  validation {
    condition = length([
      for g in var.instance : true if contains(["ACTIVE", "STOPPED"], g.desired_state)
    ]) == length(var.instance)
    error_message = "Set this field to ACTIVE to start the Instance, and STOPPED to stop the Instance."
  }

  validation {
    condition = length([
      for h in var.instance : true if contains(["ACCELERATOR_TYPE_UNSPECIFIED", "NVIDIA_TESLA_K80", "NVIDIA_TESLA_P100", "NVIDIA_TESLA_V100", "NVIDIA_TESLA_P4", "NVIDIA_TESLA_T4", "NVIDIA_TESLA_T4_VWS", "NVIDIA_TESLA_P100_VWS", "NVIDIA_TESLA_P4_VWS", "NVIDIA_TESLA_A100", "TPU_V2", "TPU_V3"], h.accelerator_config_type)
    ]) == length(var.instance)
    error_message = "Possible values are: ACCELERATOR_TYPE_UNSPECIFIED, NVIDIA_TESLA_K80, NVIDIA_TESLA_P100, NVIDIA_TESLA_V100, NVIDIA_TESLA_P4, NVIDIA_TESLA_T4, NVIDIA_TESLA_T4_VWS, NVIDIA_TESLA_P100_VWS, NVIDIA_TESLA_P4_VWS, NVIDIA_TESLA_A100, TPU_V2, TPU_V3."
  }

  validation {
    condition = length([
      for i in var.instance : true if contains(["NO_RESERVATION", "ANY_RESERVATION", "SPECIFIC_RESERVATION"], i.reservation_affinity.consume_reservation_type)
    ]) == length(var.instance)
    error_message = "Possible values are: NO_RESERVATION, ANY_RESERVATION, SPECIFIC_RESERVATION."
  }
}

variable "instance_iam_member" {
  type = list(object({
    id          = number
    instance_id = any
    member      = string
    role        = string
    condition = optional(list(object({
      expression  = string
      title       = string
      description = optional(string)
    })))
  }))
  default = []
}

variable "location" {
  type = list(object({
    id   = number
    name = optional(string)
  }))
  default = []
}

variable "runtime" {
  type = list(object({
    id                          = number
    location                    = string
    name                        = string
    labels                      = optional(map(string))
    access_config_type          = optional(string)
    access_config_runtime_owner = optional(string)
    software_config = optional(list(object({
      notebook_upgrade_schedule    = optional(string)
      enable_health_monitoring     = optional(bool)
      idle_shutdown                = optional(bool)
      idle_shutdown_timeout        = optional(number)
      install_gpu_driver           = optional(bool)
      custom_gpu_driver_path       = optional(string)
      post_startup_script          = optional(string)
      post_startup_script_behavior = optional(string)
      kernels_repository           = optional(string)
      kernels_tags                 = optional(string)
    })))
    virtual_machine = optional(list(object({
      machine_type                  = optional(string)
      network                       = optional(string)
      subnet                        = optional(string)
      nic_type                      = optional(string)
      reserved_ip_range             = optional(string)
      internal_ip_only              = optional(bool)
      tags                          = optional(list(string))
      metadata                      = optional(map(string))
      labels                        = optional(map(string))
      accelerator_config_type       = optional(string)
      accelerator_config_core_count = optional(number)
      container_images_repository   = optional(string)
      container_images_tag          = optional(string)
      encryption_config_kms_key_id  = optional(any)
      data_disk = optional(list(object({
        interface = optional(string)
        mode      = optional(string)
        source    = optional(string)
        type      = optional(string)
        initialize_params = optional(list(object({
          description  = optional(string)
          disk_name    = optional(string)
          disk_size_gb = optional(number)
          disk_type    = optional(string)
          labels       = optional(map(string))
        })))
      })))
      shielded_instance_config = optional(list(object({
        enable_integrity_monitoring = optional(bool)
        enable_secure_boot          = optional(bool)
        enable_vtpm                 = optional(bool)
      })))
    })))
  }))
  default = []

  validation {
    condition = length([
      for a in var.runtime : true if contains(["UNSPECIFIED_NIC_TYPE", "VIRTIO_NET", "GVNIC"], a.virtual_machine.nic_type)
    ]) == length(var.instance)
    error_message = "Possible values are: UNSPECIFIED_NIC_TYPE, VIRTIO_NET, GVNIC."
  }

  validation {
    condition = length([
      for b in var.runtime : true if contains(["NVME", "SCSI"], b.virtual_machine.data_disk.interface)
    ]) == length(var.instance)
    error_message = "Valid values: * NVME * SCSI."
  }

  validation {
    condition = length([
      for c in var.runtime : true if contains(["READ_WRITE", "READ_ONLY"], c.virtual_machine.data_disk.mode)
    ]) == length(var.instance)
    error_message = "The mode in which to attach this disk, either READ_WRITE or READ_ONLY."
  }

  validation {
    condition = length([
      for d in var.runtime : true if contains(["SCRATCH", "PERSISTENT"], d.virtual_machine.data_disk.type)
    ]) == length(var.instance)
    error_message = "Specifies the type of the disk, either SCRATCH or PERSISTENT."
  }

  validation {
    condition = length([
      for e in var.runtime : true if contains(["POST_STARTUP_SCRIPT_BEHAVIOR_UNSPECIFIED", "RUN_EVERY_START", "DOWNLOAD_AND_RUN_EVERY_START"], e.software_config.post_startup_script_behavior)
    ]) == length(var.instance)
    error_message = "Possible values are: POST_STARTUP_SCRIPT_BEHAVIOR_UNSPECIFIED, RUN_EVERY_START, DOWNLOAD_AND_RUN_EVERY_START."
  }
}

variable "runtime_iam_member" {
  type = list(object({
    id         = number
    member     = string
    role       = string
    runtime_id = any
    condition = optional(list(object({
      expression  = string
      title       = string
      description = optional(string)
    })))
  }))
  default = []
}