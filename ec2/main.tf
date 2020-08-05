
resource "aws_instance" "my_webserver" {
  ami           = "ami-00f6a0c18edb19300" #Ubuntu image
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.My_webserver_SG.id]
  subnet_id              = aws_subnet.public_subnet.id
  #depends_on             = ["aws_subnet.public_subnet"]
  tags = {
    Name    = "My_AWS_webs"
    owner   = "Yurii Bakhur"
    project = "Terraform Lesson2"
  }
}
