

resource "aws_security_group" "webserver_sg" {
  name        = "Webserver_SG"
  description = "My first webserver security group"
  vpc_id      = var.aws_vpc_id
  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "AWS_web_serv_sg"
    owner   = "Yurii Bakhur"
    project = "Terraform Lesson2"
  }

}


#======================SG for DB==============================
#Creating Security Group
resource "aws_security_group" "db_sg" {
  name        = "DB_SG"
  description = "My first GS for RDS security group"
  vpc_id      = var.aws_vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }
  tags = {
    Name  = "AWS_rds_sg"
    owner = "Yurii Bakhur"
  }

}
