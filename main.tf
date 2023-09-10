resource "aws_launch_template" "AGS_template" {
  name = "tf-Launch-Template"
  image_id = local.image_id
  instance_type = local.instance_type
    placement {
    availability_zone = local.availability_zone
  }
    network_interfaces {
    associate_public_ip_address = false
    security_groups = var.ags-security
    subnet_id = var.ags-subnet-A
  }
      tags = {
      Name = "tf-Launch-Template"
    }
}

resource "aws_autoscaling_group" "AGS_group" {
  name                      = "tf-AGS_group"
  depends_on                = [ aws_launch_template.AGS_template ]
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 3
  target_group_arns = [var.ALB-target]
  # availability_zones = ["ap-southeast-1a"]
  vpc_zone_identifier       = [var.ags-subnet-A, var.ags-subnet-B]
  # load_balancers = [ var.loadbalancer ]

    launch_template {
    id      = aws_launch_template.AGS_template.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.AGS_group.id
  lb_target_group_arn = var.ALB-target
}