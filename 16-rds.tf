resource "aws_db_instance" "rds" {
  # Konfigurasi RDS
  vpc_security_group_ids = [aws_security_group.rawat-jalan.id]

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t2.micro"
  db_name             = "RawatJalanDB"
  username            = "admin"
  password            = "ZZxvcbnmn111"
  allocated_storage   = 20
  storage_type        = "gp2"
  multi_az            = false
  publicly_accessible = false

  skip_final_snapshot       = true
  final_snapshot_identifier = "final-snapshot-1"

}

output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "rds_username" {
  value = aws_db_instance.rds.username
}

output "rds_password" {
  value     = aws_db_instance.rds.password
  sensitive = true
}
