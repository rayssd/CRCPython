resource "aws_lambda_function" "VisitorCounter" {
  function_name    = "VisitorCounter"
  role             = aws_iam_role.MyLambdaRole.arn
  runtime          = "python3.7"
  handler          = "dynamodb.lambda_handler"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
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

