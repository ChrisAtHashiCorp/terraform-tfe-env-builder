resource "tfe_project" "project" {
  organization = var.org_name
  name         = var.env.project_name == null ? var.env.name : var.env.project_name
}

resource "tfe_team" "team" {
  count = var.team.id == null ? 1 : 0

  name         = var.env.team_name == null ? var.env.name : var.env.team_name
  organization = var.org_name
  organization_access {
    read_workspaces         = var.env.organization_access.read_workspaces
    read_projects           = var.env.organization_access.read_projects
    manage_policies         = var.env.organization_access.manage_policies
    manage_policy_overrides = var.env.organization_access.manage_policy_overrides
    manage_workspaces       = var.env.organization_access.manage_workspaces
    manage_vcs_settings     = var.env.organization_access.manage_vcs_settings
    manage_providers        = var.env.organization_access.manage_providers
    manage_modules          = var.env.organization_access.manage_modules
    manage_run_tasks        = var.env.organization_access.manage_run_tasks
    manage_projects         = var.env.organization_access.manage_projects
    manage_membership       = var.env.organization_access.manage_membership
  }
}

resource "tfe_team_project_access" "team_access" {
  access     = "admin"
  team_id    = var.team.id == null ? tfe_team.team[0].id : var.team.id
  project_id = tfe_project.project.id
}

resource "tfe_variable_set" "variable_set" {
  name         = var.env.varset_name == null ? var.env.name : var.env.varset_name
  description  = "Variable set for the Team."
  organization = var.org_name
}

resource "tfe_project_variable_set" "project_variable_set" {
  variable_set_id = tfe_variable_set.variable_set.id
  project_id      = tfe_project.project.id
}

resource "tfe_team_token" "team_token" {
  count   = var.team.token == null ? 1 : 0
  team_id = var.team.token == null ? tfe_team.team[0].id : var.team.id
}

resource "tfe_variable" "team_token" {
  key             = "TFE_TOKEN"
  value           = var.team.token == null ? tfe_team_token.team_token[0].token : var.team.token
  sensitive       = true
  category        = "env"
  variable_set_id = tfe_variable_set.variable_set.id
  description     = format("The %s's Team TFE Token", var.env.team_name == null ? var.env.name : var.env.team_name)
}
