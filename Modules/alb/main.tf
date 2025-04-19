resource "aws_lb" "application_load_balancer" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnet_1a_id, var.public_subnet_2b_id]
  enable_deletion_protection = false

  tags = {
    Name = "${var.name}-alb"
  }
}
resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.name}-tg"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
    health_check {
        enabled = true
        interval = 300
        path = "/"
        timeout = 60
        matcher = 200
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}