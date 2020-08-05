resource "aws_launch_configuration" "footgo_lc" {
  name_prefix                 = "FootGo_lc"
  image_id                    = var.aws_image_id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  security_groups             = [var.aws_sg]
  ebs_block_device {
    device_name           = "/dev/xvdz"
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
}
/*
  lifecycle {
    create_before_destroy = true
  }
} */
/*
resource "aws_autoscaling_policy" "scaling_up" {
  name                   = "P_scaling_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.footgo_asg.name
} */

resource "aws_autoscaling_policy" "scaling_up" {
  name = "footgo_scaling_up"

  autoscaling_group_name = aws_autoscaling_group.footgo_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = "ClusterName"
        value = "staging"
      }

      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      statistic   = "Average"
    }

    target_value = "50"
  }
}

resource "aws_autoscaling_group" "footgo_asg" {
  name                      = "Footgo_asg"
  vpc_zone_identifier       = [var.aws_public_subnet]
  launch_configuration      = aws_launch_configuration.footgo_lc.name
  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"

}
/*
  lifecycle {
    create_before_destroy = true
  }
} */
