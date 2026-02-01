output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.webserver.load_balancer_dns_name
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}
