output "network" {
  value = module.network
}

output "compute" {
  value = module.autoscaling
}

output "alb" {
  value = module.alb
}

output "efs" {
  value = module.efs
}

output "asg-sg" {
  value = module.asg-sg
}

output "alb-sg" {
  value = module.alb-sg
}

output "rds-aurora" {
  value     = module.rds-aurora
  sensitive = true
}

output "ssm-parameterstore" {
  value     = module.store_write
  sensitive = true
}

output "iam" {
  value = module.iam_assumable_role
}