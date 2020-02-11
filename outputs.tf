output "alb_dns_name" {
  value       = aws_lb.andy_lb_example.dns_name
  description = "This is domain of loadbalancer."
}

output "aws_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the Security Group attached to the load balancer"
}