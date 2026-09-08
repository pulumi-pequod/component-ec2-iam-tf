# -----------------------------------------------------------------------
# Outputs for the EC2 IAM module.
# -----------------------------------------------------------------------

output "instance_profile_name" {
  description = "Name of the instance profile to attach to the EC2 instance."
  value       = aws_iam_instance_profile.ec2.name
}

output "instance_profile_arn" {
  description = "ARN of the instance profile."
  value       = aws_iam_instance_profile.ec2.arn
}

output "role_name" {
  description = "Name of the EC2 instance role."
  value       = aws_iam_role.ec2.name
}

output "role_arn" {
  description = "ARN of the EC2 instance role."
  value       = aws_iam_role.ec2.arn
}

output "policy_arn" {
  description = "ARN of the S3 read policy attached to the instance role."
  value       = aws_iam_policy.ec2.arn
}
