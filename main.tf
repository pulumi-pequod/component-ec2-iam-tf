# -----------------------------------------------------------------------
# IAM for an EC2 instance.
#
#   Role             — assumed by ec2.amazonaws.com
#   Policy           — S3 read on a given bucket
#   Instance profile — attaches the role to the EC2 instance
# -----------------------------------------------------------------------

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.42.0"
    }
  }
}

resource "aws_iam_role" "ec2" {
  name_prefix = var.name_prefix
  description = "Instance role for the tf-pulumi demo EC2 instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EC2AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Custom policy: S3 read on the demo bucket.
resource "aws_iam_policy" "ec2" {
  name_prefix = var.name_prefix
  description = "Allow the demo EC2 instance to read from the demo S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3Read"
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:ListBucket"]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_custom" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2.arn
}

resource "aws_iam_instance_profile" "ec2" {
  name_prefix = var.name_prefix
  role        = aws_iam_role.ec2.name
}
