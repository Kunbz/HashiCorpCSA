module "store_write" {
  source  = "cloudposse/ssm-parameter-store/aws"
  version = "0.7.1"

  parameter_write = [
    {
      name        = "/csa/database/master_password"
      value       = random_password.aurora_master_password.result
      type        = "SecureString"
      overwrite   = "true"
      description = "csa mysql database master password"
      kms_arn     = module.kms_key.key_arn
    },
    {
      name        = "/csa/database/master_username"
      value       = module.rds-aurora.this_rds_cluster_master_username
      type        = "SecureString"
      overwrite   = "true"
      description = "csa mysql database master username"
      kms_arn     = module.kms_key.key_arn
    },
    {
      name        = "/csa/database/endpoint"
      value       = module.rds-aurora.this_rds_cluster_instance_endpoints[0]
      type        = "SecureString"
      overwrite   = "true"
      description = "csa mysql database master endpoint"
      kms_arn     = module.kms_key.key_arn
    },
    {
      name        = "/csa/database/database_name"
      value       = module.rds-aurora.this_rds_cluster_database_name
      type        = "SecureString"
      overwrite   = "true"
      description = "csa mysql database master endpoint"
      kms_arn     = module.kms_key.key_arn
    }
  ]
}
