module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "4.1.0"

  # Autoscaling group
  name              = "csa_asg"
  max_size          = 3
  min_size          = 1
  desired_capacity  = 1
  health_check_type = "EC2" #change later

  # Launch template
  lt_name                  = "csa_lc"
  description              = "Launch template for csa_asg"
  update_default_version   = true
  use_lt                   = true
  create_lt                = true
  image_id                 = data.aws_ami.amazon_linux.id
  instance_type            = "t3.micro"
  ebs_optimized            = true
  enable_monitoring        = true
  vpc_zone_identifier      = module.network.public_subnets
  security_groups          = [module.asg-sg.security_group_id]
  user_data_base64         = data.template_cloudinit_config.config.rendered
  iam_instance_profile_arn = module.iam_assumable_role.this_iam_instance_profile_arn
  target_group_arns        = module.alb.target_group_arns

}
