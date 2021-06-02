module "alb-sg" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "4.2.0"
  vpc_id              = module.network.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
  name                = "csa-alb-sg"
}

module "asg-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.2.0"
  vpc_id  = module.network.vpc_id
  # ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["https-443-tcp"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.alb-sg.security_group_id
    }
  ]
  egress_rules = ["all-all"]
  name         = "csa-asg-sg"
}