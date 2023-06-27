resource "aws_apigatewayv2_api" "api-rawat-jalan" {
  name          = "api-rawat-jalan"
  protocol_type = "HTTP"
    
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.api-rawat-jalan.id

  name        = "dev"
  auto_deploy = true
    
}

resource "aws_apigatewayv2_vpc_link" "rawat-jalan" {
  name               = "rawat-jalan"
  security_group_ids = [aws_security_group.rawat-jalan.id]
  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
    
  ]
    
}

resource "aws_apigatewayv2_integration" "api-rawat-jalan" {
  api_id = aws_apigatewayv2_api.api-rawat-jalan.id

  integration_uri    = aws_lb_listener.rawat-jalan.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.rawat-jalan.id

  depends_on = [aws_apigatewayv2_integration.api-rawat-jalan]
    
}

resource "aws_apigatewayv2_route" "api-rawat-jalan" {
  api_id = aws_apigatewayv2_api.api-rawat-jalan.id

  route_key  = "ANY /{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.api-rawat-jalan.id}"
  depends_on = [aws_apigatewayv2_integration.api-rawat-jalan]
    
}
