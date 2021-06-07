module "network" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "hashicorp-vpc"
  cidr                 = var.vpc_cidr
  enable_dns_hostnames = true
  azs                  = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  public_subnets       = [local.subnets_cidr[0], local.subnets_cidr[1], local.subnets_cidr[2]]
  private_subnets      = [local.subnets_cidr[3], local.subnets_cidr[4], local.subnets_cidr[5]]
  database_subnets     = [local.subnets_cidr[6], local.subnets_cidr[7], local.subnets_cidr[8]]
  enable_nat_gateway   = true
  tags = {
    Terraform = "true"
  }
}