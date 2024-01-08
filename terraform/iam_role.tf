data "aws_iam_role" "ecs_role" {
  name = "ecsInstanceRole"
}

resource "aws_iam_instance_profile" "instance_profile" {
  role = data.aws_iam_role.ecs_role.id
  name = "InstanceRoleForECS_${var.env}"
}