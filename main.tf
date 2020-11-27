resource "gsuite_group" "a_team" {
  email       = "${var.group_email}@${var.org_domain_name}"
  name        = "${var.group_email}@${var.org_domain_name}"
  description = "team for ${var.group_email}"
}

resource "gsuite_group_members" "a_team_members" {
  group_email = gsuite_group.a_team.email

  member {
    email = var.owner_email
    role  = "OWNER"
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
