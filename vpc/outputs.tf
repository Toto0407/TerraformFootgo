# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet.id
}

output "private_subnets_2" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.s_private_subnet.id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnet.id
}

output "main_vpc" {
  description = "List of IDs of public subnets"
  value       = aws_vpc.footgo_vpc.id
}
