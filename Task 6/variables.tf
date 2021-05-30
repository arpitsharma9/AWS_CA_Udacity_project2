# TODO: Define the variable for aws_region

variable "region" {
    description = "default region"
    default = "us-east-1"
}
 
variable "s3_bucket" {
  default = "lab-tf-cf"
}
variable "lambda_function" {
  default = "greet_lambda"
} 

## zip greet_lambda.zip greet_lambda.py
## aws s3api create-bucket --bucket=lab-tf-cf --region=us-east-1
## aws s3 cp greet_lambda.zip s3://lab-tf-cf/greet_lambda.zip

 