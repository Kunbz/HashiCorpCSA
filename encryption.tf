module "kms_key" {
  source                  = "cloudposse/kms-key/aws"
  version                 = "0.9.0"
  description             = "terraform-aws-ssm-parameter-store csa KMS key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  alias                   = "alias/csa_parameter_store_key"
}