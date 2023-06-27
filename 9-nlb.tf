resource "aws_lb_target_group" "rawat-jalan" {
  name     = "rawat-jalan"
  port     = 8080
  protocol = "TCP"
  vpc_id   = aws_vpc.rawat-jalan.id

  health_check {
    enabled  = true
    protocol = "TCP"
  }
    
}

resource "aws_lb" "rawat-jalan" {
  name               = "rawat-jalan"
  internal           = true
  load_balancer_type = "network"

  subnets = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]
    
}

resource "aws_lb_listener" "rawat-jalan" {
  load_balancer_arn = aws_lb.rawat-jalan.arn
  port              = "8080"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rawat-jalan.arn
  }
    
}
