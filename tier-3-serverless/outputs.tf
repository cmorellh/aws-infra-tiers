output "api_gateway_url" {
  description = "URL of the API Gateway endpoint"
  value       = module.api_gateway.api_url
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.function_name
}

output "aurora_cluster_endpoint" {
  description = "Aurora Serverless cluster endpoint"
  value       = module.rds.cluster_endpoint
}
