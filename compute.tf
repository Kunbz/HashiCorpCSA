
data "template_file" "hostscript" {
  template = "${file("${path.module}/userdata.sh.tpl")}"
}

data "template_cloudinit_config" "config" {
  gzip = false
  base64_encode = true
# Main cloud-config configuration file.
  part {
    content = data.template_file.hostscript.rendered
 }
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "4.1.0"

  # Autoscaling group
  name              = "csa_asg"
  max_size          = 3
  min_size          = 1
  desired_capacity  = 1
  health_check_type = "EC2"

  # Launch template
  lt_name                = "csa_lc"
  description            = "Launch template for csa_asg"
  update_default_version = true
  use_lt                 = true
  create_lt              = true
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  ebs_optimized          = true
  enable_monitoring      = true
  vpc_zone_identifier    = module.network.private_subnets
  security_groups        = [module.asg-sg.security_group_id]
  # user_data              = filebase64("./userdata.sh")
  user_data              = data.template_cloudinit_config.config.rendered
  iam_instance_profile_arn = module.iam_assumable_role.this_iam_instance_profile_arn

}
