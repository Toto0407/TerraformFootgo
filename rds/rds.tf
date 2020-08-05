resource "aws_db_instance" "dbfootgo" {

  identifier = "footgo"

  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "footgo"
  username             = "root"
  password             = "edvIT300!"
  parameter_group_name = "default.mysql5.7"

  availability_zone      = "eu-west-2a"
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_g.name




  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "footgosnap"
}

resource "aws_db_subnet_group" "db_subnet_g" {
  name       = "main"
  subnet_ids = [var.subnet_1, var.subnet_2]

  tags = {
    Name = "My DB subnet group"
  }
}
