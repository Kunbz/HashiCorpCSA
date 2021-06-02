# module "iam" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
# #   version = "4.1.0"

#   trusted_role_services = [
#     "ec2.amazonaws.com",
#     "ssm.amazonaws.com"
#   ]
#   create_role = true

#   custom_role_policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   ]

#   role_name = "csa-iam-role"

#   create_instance_profile = true
#   role_path               = "/"

# }



module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 3.0"

  trusted_role_services = [
    "ec2.amazonaws.com",
    "ssm.amazonaws.com"
  ]

  create_role = true

  role_name         = "csa-iam-role"
  create_instance_profile = true
  role_path               = "/"

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  number_of_custom_role_policy_arns = 1

}
