variable "org_name" {
  description = "Name of the Organization to create this environment in."
  type        = string
}

variable "env" {
  description = "Values for the environment."
  type = object({
    name         = string
    project_name = optional(string, "")
    team_name    = optional(string, "")
    varset_name  = optional(string, "")
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
