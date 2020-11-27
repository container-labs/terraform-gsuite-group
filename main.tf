resource "gsuite_group" "a_team" {
  email       = "${var.name}@${var.org_domain_name}"
  name        = "${var.name}@${var.org_domain_name}"
  description = "terraform managed group"
}

resource "gsuite_group_members" "a_team_members" {
  group_email = gsuite_group.a_team.email

  dynamic "member" {
    for_each = var.owners

    content {
      email = member.value
      role  = "OWNER"
    }
  }

  # womp
  # https://github.com/DeviaVir/terraform-provider-gsuite/issues/108
  dynamic "member" {
    for_each = var.members

    content {
      email = member.value
      role  = "MEMBER"
    }
  }
}
