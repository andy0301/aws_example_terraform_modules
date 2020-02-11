output "address" {
  value       = aws_db_instance.db_example.address
  description = "Return database endpoint or IP address"
}

output "port" {
  value       = aws_db_instance.db_example.port
  description = "Return database port"
}