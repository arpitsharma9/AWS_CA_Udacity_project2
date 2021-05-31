## block for declaring provider and refering region though variable

provider "aws" {
  region = var.region
}

## block for lamnba role configuration . A new iam role with name "iam_for_lambda" will be created

resource "aws_iam_role" "iam_for_lambda" {
    name = "iam_for_lambda"
   managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

### code block for invoking lambda function. greet lambda will be stored on S3 bucket.


resource "aws_lambda_function" "lambda" {
   function_name = var.lambda_function
   s3_bucket = var.s3_bucket
   s3_key    = "greet_lambda.zip"
   handler = "greet_lambda.lambda_handler"
   runtime = "python3.8"
   role = aws_iam_role.iam_for_lambda.arn
    environment{
      variables = {
          greeting = "This is a greeting variable. Let's say hello from Lambda!"
      }
  }
}
### code block for cloudwatch logging
resource "aws_cloudwatch_log_group" "cloud_watch_alarms" {
  name              = "/aws/lambda/${var.lambda_function}"
  retention_in_days = 14
}

### Creating a new policy with name "lambda_logging"
resource "aws_iam_policy" "lambda_logging" {
  name = "lambda_logging"
  path = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

### Assocaiting policy "lambda_logging" to role "aws_iam_role"
resource "aws_iam_role_policy_attachment" "lambda_logs" {
role       = aws_iam_role.iam_for_lambda.name
# policy_arn = aws_iam_role.iam_for_lambda.arn
 policy_arn = aws_iam_policy.lambda_logging.arn
}