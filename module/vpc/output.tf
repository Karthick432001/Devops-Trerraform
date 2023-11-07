output "vpc_id" {
  description = "vpc id for referencing in the main module"
  value       = aws_vpc.main.id
}

output "route_table_id" {
  value = aws_route_table.two-tier-rt.id
}