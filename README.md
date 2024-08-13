## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_notebooks_environment.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_environment) | resource |
| [google_notebooks_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance) | resource |
| [google_notebooks_instance_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance_iam_member) | resource |
| [google_notebooks_location.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_location) | resource |
| [google_notebooks_runtime.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_runtime) | resource |
| [google_notebooks_runtime_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_runtime_iam_member) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | <pre>list(object({<br>    id                         = number<br>    location                   = string<br>    name                       = string<br>    display_name               = optional(string)<br>    description                = optional(string)<br>    post_startup_script        = optional(string)<br>    container_image_repository = optional(any)<br>    container_image_tag        = optional(string)<br>    vm_image_project_id        = optional(any)<br>    vm_image_name              = optional(string)<br>    vm_image_family            = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_environment_vm_image_project_id"></a> [environment\_vm\_image\_project\_id](#input\_environment\_vm\_image\_project\_id) | n/a | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | A Cloud AI Platform Notebook instance.<br>- nic\_type : Possible values are: UNSPECIFIED\_NIC\_TYPE, VIRTIO\_NET, GVNIC.<br>- boot\_disk\_type : Possible values are: DISK\_TYPE\_UNSPECIFIED, PD\_STANDARD, PD\_SSD, PD\_BALANCED, PD\_EXTREME.<br>- boot\_disk\_size\_gb : The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB). The minimum recommended value is 100 GB. If not specified, this defaults to 100.<br>- data\_disk\_type : Possible values are: DISK\_TYPE\_UNSPECIFIED, PD\_STANDARD, PD\_SSD, PD\_BALANCED, PD\_EXTREME.<br>- data\_disk\_size\_gb : The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB). The minimum recommended value is 100 GB. If not specified, this defaults to 100.<br>- disk\_encryption : Possible values are: DISK\_ENCRYPTION\_UNSPECIFIED, GMEK, CMEK.<br>- desired\_state : Set this field to ACTIVE to start the Instance, and STOPPED to stop the Instance.<br>- accelerator\_config\_type : Possible values are: ACCELERATOR\_TYPE\_UNSPECIFIED, NVIDIA\_TESLA\_K80, NVIDIA\_TESLA\_P100, NVIDIA\_TESLA\_V100, NVIDIA\_TESLA\_P4, NVIDIA\_TESLA\_T4, NVIDIA\_TESLA\_T4\_VWS, NVIDIA\_TESLA\_P100\_VWS, NVIDIA\_TESLA\_P4\_VWS, NVIDIA\_TESLA\_A100, TPU\_V2, TPU\_V3.<br>- reservation\_affinity.consume\_reservation\_type : Possible values are: NO\_RESERVATION, ANY\_RESERVATION, SPECIFIC\_RESERVATION. | <pre>list(object({<br>    id                            = number<br>    location                      = string<br>    machine_type                  = string<br>    name                          = string<br>    instance_owners               = optional(list(string))<br>    service_account_scopes        = optional(list(string))<br>    tags                          = optional(list(string))<br>    post_startup_script           = optional(string)<br>    service_account               = optional(string)<br>    nic_type                      = optional(string)<br>    network                       = optional(string)<br>    subnet                        = optional(string)<br>    custom_gpu_driver_path        = optional(string)<br>    create_time                   = optional(string)<br>    boot_disk_type                = optional(string)<br>    data_disk_type                = optional(string)<br>    kms_key                       = optional(string)<br>    desired_state                 = optional(string)<br>    disk_encryption               = optional(string)<br>    boot_disk_size_gb             = optional(number)<br>    data_disk_size_gb             = optional(number)<br>    no_proxy_access               = optional(bool)<br>    no_public_ip                  = optional(bool)<br>    no_remove_data_disk           = optional(bool)<br>    install_gpu_driver            = optional(bool)<br>    labels                        = optional(map(string))<br>    metadata                      = optional(map(string))<br>    accelerator_config_type       = optional(string)<br>    accelerator_config_core_count = optional(number)<br>    container_image_repository    = optional(string)<br>    container_image_tag           = optional(string)<br>    vm_image_project_id           = optional(any)<br>    vm_image_name                 = optional(string)<br>    vm_image_family               = optional(string)<br>    reservation_affinity = optional(list(object({<br>      consume_reservation_type = string<br>      key                      = optional(string)<br>      values                   = optional(list(string))<br>    })))<br>    shielded_instance_config = optional(list(object({<br>      enable_integrity_monitoring = optional(bool)<br>      enable_secure_boot          = optional(bool)<br>      enable_vtpm                 = optional(bool)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_instance_iam_member"></a> [instance\_iam\_member](#input\_instance\_iam\_member) | n/a | <pre>list(object({<br>    id          = number<br>    instance_id = any<br>    member      = string<br>    role        = string<br>    condition = optional(list(object({<br>      expression  = string<br>      title       = string<br>      description = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_instance_vm_image_project_id"></a> [instance\_vm\_image\_project\_id](#input\_instance\_vm\_image\_project\_id) | n/a | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | <pre>list(object({<br>    id   = number<br>    name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | `null` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | n/a | <pre>list(object({<br>    id                          = number<br>    location                    = string<br>    name                        = string<br>    labels                      = optional(map(string))<br>    access_config_type          = optional(string)<br>    access_config_runtime_owner = optional(string)<br>    software_config = optional(list(object({<br>      notebook_upgrade_schedule    = optional(string)<br>      enable_health_monitoring     = optional(bool)<br>      idle_shutdown                = optional(bool)<br>      idle_shutdown_timeout        = optional(number)<br>      install_gpu_driver           = optional(bool)<br>      custom_gpu_driver_path       = optional(string)<br>      post_startup_script          = optional(string)<br>      post_startup_script_behavior = optional(string)<br>      kernels_repository           = optional(string)<br>      kernels_tags                 = optional(string)<br>    })))<br>    virtual_machine = optional(list(object({<br>      machine_type                  = optional(string)<br>      network                       = optional(string)<br>      subnet                        = optional(string)<br>      nic_type                      = optional(string)<br>      reserved_ip_range             = optional(string)<br>      internal_ip_only              = optional(bool)<br>      tags                          = optional(list(string))<br>      metadata                      = optional(map(string))<br>      labels                        = optional(map(string))<br>      accelerator_config_type       = optional(string)<br>      accelerator_config_core_count = optional(number)<br>      container_images_repository   = optional(string)<br>      container_images_tag          = optional(string)<br>      encryption_config_kms_key_id  = optional(any)<br>      data_disk = optional(list(object({<br>        interface = optional(string)<br>        mode      = optional(string)<br>        source    = optional(string)<br>        type      = optional(string)<br>        initialize_params = optional(list(object({<br>          description  = optional(string)<br>          disk_name    = optional(string)<br>          disk_size_gb = optional(number)<br>          disk_type    = optional(string)<br>          labels       = optional(map(string))<br>        })))<br>      })))<br>      shielded_instance_config = optional(list(object({<br>        enable_integrity_monitoring = optional(bool)<br>        enable_secure_boot          = optional(bool)<br>        enable_vtpm                 = optional(bool)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_runtime_iam_member"></a> [runtime\_iam\_member](#input\_runtime\_iam\_member) | n/a | <pre>list(object({<br>    id         = number<br>    member     = string<br>    role       = string<br>    runtime_id = any<br>    condition = optional(list(object({<br>      expression  = string<br>      title       = string<br>      description = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment_container_image"></a> [environment\_container\_image](#output\_environment\_container\_image) | n/a |
| <a name="output_environment_id"></a> [environment\_id](#output\_environment\_id) | n/a |
| <a name="output_environment_name"></a> [environment\_name](#output\_environment\_name) | n/a |
| <a name="output_environment_post_startup_script"></a> [environment\_post\_startup\_script](#output\_environment\_post\_startup\_script) | n/a |
| <a name="output_environment_project"></a> [environment\_project](#output\_environment\_project) | n/a |
| <a name="output_instance_container_image"></a> [instance\_container\_image](#output\_instance\_container\_image) | n/a |
| <a name="output_instance_desired_state"></a> [instance\_desired\_state](#output\_instance\_desired\_state) | n/a |
| <a name="output_instance_disk_encryption"></a> [instance\_disk\_encryption](#output\_instance\_disk\_encryption) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | n/a |
| <a name="output_instance_project"></a> [instance\_project](#output\_instance\_project) | n/a |
| <a name="output_runtime_health_state"></a> [runtime\_health\_state](#output\_runtime\_health\_state) | n/a |
| <a name="output_runtime_id"></a> [runtime\_id](#output\_runtime\_id) | n/a |
| <a name="output_runtime_labels"></a> [runtime\_labels](#output\_runtime\_labels) | n/a |
| <a name="output_runtime_name"></a> [runtime\_name](#output\_runtime\_name) | n/a |
| <a name="output_runtime_project"></a> [runtime\_project](#output\_runtime\_project) | n/a |
