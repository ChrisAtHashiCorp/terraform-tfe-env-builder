output "project" {
  value = {
    name = var.env_name
    id = tfe_project.project.id
  }
}

output "team" {
  value = {
    name = var.team.id == null ? var.env_name : null
    id = var.team.id == null ? tfe_team.team[0].id : var.team.id
  }
}
