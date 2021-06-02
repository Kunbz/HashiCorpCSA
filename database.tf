resource "random_password" "aurora_master_password" {
  length           = 10
  min_lower        = 2
  min_special      = 2
  min_upper        = 2
  min_numeric      = 2
  override_special = "#$%"
}

module "rds-aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  name           = "csa-aurora-db-mysql"
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.03.2"
  instance_type  = "db.t2.small"

  vpc_id  = module.network.vpc_id
  subnets = module.network.database_subnets

  replica_count           = 1
  allowed_security_groups = [module.asg-sg.security_group_id] # Should be autoscaling sg

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = aws_db_parameter_group.db_pg.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db_cpg.id

  password               = random_password.aurora_master_password.result
  create_random_password = false

  database_name = "csaaurora"

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

}

resource "aws_db_parameter_group" "db_pg" {
  name        = "csa-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "csa-aurora-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "db_cpg" {
  name        = "csa-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "csa-aurora-57-cluster-parameter-group"
}