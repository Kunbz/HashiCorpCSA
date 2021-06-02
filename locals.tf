locals {
  subnets_cidr = cidrsubnets(var.vpc_cidr, 8, 8, 8, 8, 8, 8, 8, 8, 8)
}