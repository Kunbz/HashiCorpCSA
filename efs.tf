module "efs" {
  source  = "cloudposse/efs/aws"
  version = "0.30.1"

  name            = "csa_efs"
  vpc_id          = module.network.vpc_id
  region          = data.aws_region.current.name
  subnets         = module.network.private_subnets
  security_groups = [module.asg-sg.security_group_id] # This will be security group of asg
}