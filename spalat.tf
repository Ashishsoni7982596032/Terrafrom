/*terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAROOZMHT5OGJ3FINJ"
  secret_key = "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"
}

resource "aws_iam_user" "user" {
  name = "user.${count.index}"
  path = "/system/"
  count = 3

  tags = {
    env = "test"
  }
}

output "comb" {
    value = zipmap(aws_iam_user.user[*].arn, aws_iam_user.user[*].name)
}
*/