output "api_url" {
  description = "URL of the API Gateway endpoint"
  value       = aws_apigatewayv2_stage.main.invoke_url
}

output "api_id" {
  description = "ID of the API Gateway"
  value       = aws_apigatewayv2_api.main.id
}
