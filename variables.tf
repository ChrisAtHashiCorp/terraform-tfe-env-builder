variable "org_name" {
  description = "Name of the Organization to create this environment in."
  type        = string
}

variable "env_name" {
  description = "Name of the environment to create."
  type = string
}

variable "access" {
  description = "Values for the environment."
  type = object({
    organization_access = optional(object({
      read_workspaces         = optional(bool, false)
      read_projects           = optional(bool, false)
      manage_policies         = optional(bool, false)
      manage_policy_overrides = optional(bool, false)
      manage_workspaces       = optional(bool, false)
      manage_vcs_settings     = optional(bool, false)
      manage_providers        = optional(bool, false)
      manage_modules          = optional(bool, false)
      manage_run_tasks        = optional(bool, false)
      manage_projects         = optional(bool, false)
      manage_membership       = optional(bool, false)
    }), {})
  })
}

variable "team" {
  description = "Existing Team to leverage instead of creating new one for this env."
  type = object({
    id    = optional(string, null)
    token = optional(string, null)
  })
  default = {
    id = null
    token = null
  }
}
