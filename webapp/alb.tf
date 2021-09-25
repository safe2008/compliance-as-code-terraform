resource "aws_lb" "webapp" {
  name        = "webapp-alb"
  load_balancer_type = "application"
  subnets            = [data.aws_subnet.main.*.id]
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.static_content.bucket
    prefix  = "test-lb"
    enabled = true
  }
}

resource "aws_lb_target_group" "webapp" {
  name     = "webapp"
  port     = 443
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
}

resource "aws_lb_listener" "webapp" {
  load_balancer_arn = aws_lb.webapp.arn
  
  # shall we do SSL at the webapp level?
  port     = "443"
  protocol = "HTTPS"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }
}


resource "aws_security_group" "webapp_lb" {
    name        = "webapp-lb"
    description = "Allow web app traffic"

    ingress {
        description = "Web app traffic from everywhere"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Web app traffic to ASG"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
