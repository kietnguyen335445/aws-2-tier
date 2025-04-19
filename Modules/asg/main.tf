resource "aws_launch_template" "lt-name" {
    name = "${var.name}-tpl"
    image_id = var.ami
    instance_type = var.cpu
    user_data = filebase64("/Modules/asg/config.sh")

    vpc_security_group_ids = [var.client_sg_id]
    tags = {
        Name = "${var.name}-tpl"
    }
}
resource "aws_autoscaling_group" "asg-name" {
    name = "${var.name}-asg"
    max_size = var.max_size
    min_size = var.min_size
    desired_capacity = var.desired_capacity
    health_check_grace_period = 300
    health_check_type = var.asg_health_check_type
    vpc_zone_identifier = [var.private_subnet_3a_id, var.private_subnet_4b_id]
    target_group_arns = [var.tg_arn]
    enabled_metrics = [ 
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupTotalInstances",
        "GroupMinSize",
        "GroupMaxSize",
     ]
     metrics_granularity = "1Minute"
     launch_template {
        id = aws_launch_template.lt-name.id
        version = aws_launch_template.lt-name.latest_version
     }
}
resource "aws_autoscaling_policy" "scale_up" {
    name = "${var.name}-asg"
    scaling_adjustment = "1"
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.asg-name.name
    policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
     alarm_name          = "${var.name}-asg-scale-up-cpu-alarm"
  alarm_description   = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70" # New instance will be created once CPU utilization is higher than 30 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg-name.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.name}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.asg-name.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1" # decreasing instance by 1 
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "${var.name}-asg-scale-down-cpu-alarm"
  alarm_description   = "asg-scale-down-cpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5" # Instance will scale down when CPU utilization is lower than 5 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg-name.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}

