###################
# Create web server cluster
# By Andy Cai
###################

data "aws_ami" "ubuntu-bionic" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-1804-lts*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["247102896272"]

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# using terraform_remote_state data source to get db outputs
data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket
    key    = var.db_remote_state_key
    region = var.region
  }
}

# using template_file.xxx.rendered to fetch variables values from user scripts or data
data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh") # path.module: returns the filesystem path of the module where the expression is defined

  vars = {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  }
}

resource "aws_launch_configuration" "andy_asg_example" {
  #ami = "ami-0614811e15abdd2ae"
  image_id        = data.aws_ami.ubuntu-bionic.id
  instance_type   = var.vm_type
  security_groups = [aws_security_group.instance.id]

  user_data = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "andy_asg_example" {
  launch_configuration = aws_launch_configuration.andy_asg_example.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = var.autoscale_min_size
  max_size = var.autoscale_max_size

  tag {
    key                 = "Name"
    value               = "andy-asg-example"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}