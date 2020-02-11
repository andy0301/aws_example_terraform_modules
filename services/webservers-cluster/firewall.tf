###################
# Create security groups 
# By Andy Cai
###################

locals {
  http_port     = 80
  any_port      = 0
  any_protocol  = "-1"
  tcp_protocol  = "tcp"
  http_protocol = "HTTP"
  all_ips       = ["0.0.0.0/0"]
}

resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-example-asg-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = local.tcp_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-example-alb"
}

resource "aws_security_group_rule" "allow_all_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}