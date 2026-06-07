output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID."
}

output "azs" {
  value       = local.azs
  description = "AZs used."
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "VPC CIDR block."
}

output "public_subnets" {
  value       = aws_subnet.public[*].id
  description = "Public subnet IDs."
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "Private subnet IDs."
}

output "public_subnet_cidrs" {
  value       = aws_subnet.public[*].cidr_block
  description = "Public subnet CIDRs."
}

output "private_subnet_cidrs" {
  value       = aws_subnet.private[*].cidr_block
  description = "Private subnet CIDRs."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "Internet Gateway ID."
}

output "nat_gateway_ids" {
  value       = aws_nat_gateway.this[*].id
  description = "NAT Gateway IDs."
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "Public route table ID."
}

output "private_route_table_ids" {
  value       = aws_route_table.private[*].id
  description = "Private route table IDs."
}
