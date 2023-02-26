resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-newrelic-alerts-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
attribute {
    name = "LockID"
    type = "S"
  }
tags ={
    Name = "DynamoDB Terraform State Lock Table"
  }
}