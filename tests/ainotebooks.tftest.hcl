run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "ai_notebooks" {
  command = [plan,apply]

  variables {
    environment = [
      {
        id                          = 0
        name                        = "notebooks-environment"
        location                    = "us-west1-a"
        container_image_repository  = "gcr.io/deeplearning-platform-release/base-cpu"
      }
    ]
    instance = [
      {
        id                              = 0
        name                            = "notebooks-instance"
        location                        = "us-west1-a"
        machine_type                    = "e2-medium"
        install_gpu_driver              = true
        accelerator_config_type         = "NVIDIA_TESLA_T4"
        accelerator_config_core_count   = 1
        instance_owners                 = [ "my@service-account.com"]
        service_account                 = "my@service-account.com"
        boot_disk_type                  = "PD_SSD"
        boot_disk_size_gb               = 110
        no_public_ip                    = true
        no_proxy_access                 = true
        disk_encryption                 = "CMEK"
        kms_key                         = "my-crypto-key"
        desired_state                   = "ACTIVE"
        metadata = {
          proxy-mode = "service_account"
        }
      }
    ]
    instance_iam_member = [
      {
        id          = 0
        instance_id = 0
        role        = "roles/viewer"
        member      = "user:jane@example.com"
      }
    ]
    runtime = [
      {
        id                          = 0
        name                        = "notebooks-runtime-kernel"
        location                    = "us-central1"
        access_config_access_type   = "SINGLE_USER"
        access_config_runtime_owner = "admin@hashicorptest.com"
        software_config = [
          {
            post_startup_script_behavior = "RUN_EVERY_START"
            enable_health_monitoring     = true
            install_gpu_driver           = true
            kernels = [
              {
                repository = "gcr.io/deeplearning-platform-release/base-cpu"
                tag        = "latest"
              }
            ]
          }
        ]
        virtual_machine = [
          {
            machine_type      = "n1-standard-4"
            internal_ip_only  = true
            data_disk = [
              {
                initialize_params = [
                  {
                    disk_size_gb  = "100"
                    disk_type     = "PD_STANDARD"
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
    runtime_iam_member = [
      {
        id          = 0
        runtime_id  = 0
        role        = "roles/viewer"
        member      = "user:jane@example.com"
      }
    ]
  }
}