resource "aws_lambda_function" "VisitorCounter" {
  function_name = "VisitorCounter"
  role          = aws_iam_role.MyLambdaRole.arn
  runtime       = "python3.7"
  handler       = "dynamodb.lambda_handler"
  # filename         = data.archive_file.zip.output_path
  # source_code_hash = data.archive_file.zip.output_base64sha256
  s3_bucket = "terraform-lambda-payload"
  s3_key    = "lambda_payload.zip"
}

resource "aws_iam_role" "MyLambdaRole" {
  name = "MyLambdaRole"

  assume_role_policy = <<EOF
{
        "Version"   : "2012-10-17",
        "Statement" : [
                {
                    "Action"    : "sts:AssumeRole",
                    "Effect"    : "Allow",
                    "Principal" : {
                        "Service" : "lambda.amazonaws.com"
                    }
                }
            ] 
        }
    EOF
}

resource "aws_iam_policy" "MyLambdaPolicy" {
  # arn  = "arn:aws:iam::319523825307:policy/MyLambdaPolicy"
  # id   = "arn:aws:iam::319523825307:policy/MyLambdaPolicy"
  name = "MyLambdaPolicy"
  path = "/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "dynamodb:BatchGetItem",
            "dynamodb:GetItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:BatchWriteItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
          ]
          Effect   = "Allow"
          Resource = "arn:aws:dynamodb:ap-southeast-2:319523825307:table/MyTable"
        },
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect   = "Allow"
          Resource = "arn:aws:logs:eu-west-1:123456789012:*"
        },
        {
          Action   = "logs:CreateLogGroup"
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_iam_role_policy_attachment" "Role_Policy_Attachment" {
  role       = aws_iam_role.MyLambdaRole.name
  policy_arn = aws_iam_policy.MyLambdaPolicy.arn
}

resource "aws_lambda_permission" "Lambda_APIGW" {
  statement_id  = "AllowAPIGatewayInvocation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.VisitorCounter.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.VisitorCounterAPI.execution_arn}/*/*/${aws_lambda_function.VisitorCounter.function_name}"
}
