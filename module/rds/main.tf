resource "aws_db_instance" "rds-dev" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = false
}
