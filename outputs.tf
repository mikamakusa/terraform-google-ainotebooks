## ENVIRONMENT ##

output "environment_id" {
  value = try(
    google_notebooks_environment.this.*.id
  )
}

output "environment_name" {
  value = try(
    google_notebooks_environment.this.*.name
  )
}

output "environment_container_image" {
  value = try(
    google_notebooks_environment.this.*.container_image
  )
}

output "environment_post_startup_script" {
  value = try(
    google_notebooks_environment.this.*.post_startup_script
  )
}

output "environment_project" {
  value = try(
    google_notebooks_environment.this.*.project
  )
}

## INSTANCE ##

output "instance_id" {
  value = try(
    google_notebooks_instance.this.*.id
  )
}

output "instance_name" {
  value = try(
    google_notebooks_instance.this.*.name
  )
}

output "instance_project" {
  value = try(
    google_notebooks_instance.this.*.project
  )
}

output "instance_container_image" {
  value = try(
    google_notebooks_instance.this.*.container_image
  )
}

output "instance_desired_state" {
  value = try(
    google_notebooks_instance.this.*.desired_state
  )
}

output "instance_disk_encryption" {
  value = try(
    google_notebooks_instance.this.*.disk_encryption
  )
}

## RUNTIME ##

output "runtime_id" {
  value = try(
    google_notebooks_runtime.this.*.id
  )
}

output "runtime_name" {
  value = try(
    google_notebooks_runtime.this.*.name
  )
}

output "runtime_project" {
  value = try(
    google_notebooks_runtime.this.*.project
  )
}

output "runtime_labels" {
  value = try(
    google_notebooks_runtime.this.*.labels
  )
}

output "runtime_health_state" {
  value = try(
    google_notebooks_runtime.this.*.health_state
  )
}