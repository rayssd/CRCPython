resource "aws_apigatewayv2_api" "VisitorCounterAPI" {
  name                       = "VisitorCounterAPI"
  description                = "This is my API for visitor counter"
  protocol_type              = "HTTP"
  route_selection_expression = "$request.method $request.path"
  target                     = aws_lambda_function.VisitorCounter.invoke_arn
  cors_configuration {
    allow_credentials = false
    allow_headers     = []
    allow_methods     = []
    allow_origins = [
      "http://my-cloud-resume.s3-website-ap-southeast-2.amazonaws.com/",
    ]
    expose_headers = []
    max_age        = 0
  }
}

resource "aws_apigatewayv2_integration" "VisitorCounter_Lambda" {
  api_id                 = aws_apigatewayv2_api.VisitorCounterAPI.id
  connection_type        = "INTERNET"
  integration_method     = "POST"
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.VisitorCounter.invoke_arn
  payload_format_version = "2.0"
}

# resource "aws_apigatewayv2_stage" "default" {
#   api_id      = aws_apigatewayv2_api.VisitorCounterAPI.id
#   name        = "$default"
#   auto_deploy = true
# }

resource "aws_apigatewayv2_route" "VisitorCounter_Route" {
  api_id    = aws_apigatewayv2_api.VisitorCounterAPI.id
  route_key = "GET /VisitorCounter"
  target    = "integrations/${aws_apigatewayv2_integration.VisitorCounter_Lambda.id}"
}

resource "aws_apigatewayv2_deployment" "VisitorCounter_Trigger" {
  api_id      = aws_apigatewayv2_api.VisitorCounterAPI.id
  description = "Automatic deployment triggered by changes to the Api configuration"
}
