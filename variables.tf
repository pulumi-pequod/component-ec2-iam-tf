# -----------------------------------------------------------------------
# Inputs for the EC2 IAM module.
# -----------------------------------------------------------------------

variable "name_prefix" {
  description = <<-EOT
    Prefix for the IAM role, policy and instance profile names. AWS appends
    a unique suffix, so this keeps multiple deployments in the same account
    from colliding.
  EOT
  type        = string
  default     = "tf-pulumi-demo-ec2-"
}

variable "s3_bucket_arn" {
  description = <<-EOT
    ARN of the S3 bucket the instance role is granted read access to. The
    module grants s3:GetObject on the bucket's objects and s3:ListBucket on
    the bucket itself.
  EOT
  type        = string
}
