output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of the VPC."
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "Primary IPv4 CIDR block of the VPC."
}

output "public_subnets" {
  value       = aws_subnet.public[*].id
  description = "Public subnet IDs, ordered by AZ."
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "Private subnet IDs, ordered by AZ."
}

output "public_subnet_cidrs" {
  value       = aws_subnet.public[*].cidr_block
  description = "Public subnet CIDR blocks, ordered by AZ."
}

output "private_subnet_cidrs" {
  value       = aws_subnet.private[*].cidr_block
  description = "Private subnet CIDR blocks, ordered by AZ."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "ID of the Internet Gateway."
}

output "nat_gateway_ids" {
  value       = aws_nat_gateway.this[*].id
  description = "IDs of the NAT gateways (empty when `enable_nat_gateway` is false)."
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "ID of the public route table."
}

output "private_route_table_ids" {
  value       = aws_route_table.private[*].id
  description = "IDs of the private route tables (one per AZ when `single_nat_gateway` is false, otherwise one)."
}
