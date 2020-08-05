# Subnets
output "webserver_sg" {
  description = "List of IDs of private subnets"
  value       = aws_security_group.webserver_sg.id
}


output "rds_sg" {
  description = "List of IDs of private subnets"
  value       = aws_security_group.db_sg.id
}
