# component-ec2-iam-tf
Terraform module that provisions the IAM role, policy, and instance profile for an EC2 instance.

Creates:
- An IAM role assumable by `ec2.amazonaws.com`
- A policy granting `s3:GetObject` and `s3:ListBucket` on a given bucket ARN
- An instance profile attaching the role, ready to pass to `aws_instance.iam_instance_profile`

# Usage
## Terraform / OpenTofu

```hcl
module "ec2_iam" {
  source = "github.com/pulumi-pequod/component-ec2-iam-tf?ref=vX.Y.Z"

  name_prefix   = "my-app-ec2-"
  s3_bucket_arn = aws_s3_bucket.this.arn
}
```

Note: If no `ref` is specified, the module tracks the default branch (`main`).
Pin a released tag for reproducible deployments.

## Inputs

| Name            | Description                                                        | Type   | Default                  |
|-----------------|---------------------------------------------------------------------|--------|---------------------------|
| `name_prefix`   | Prefix for the IAM role, policy and instance profile names.        | string | `"tf-pulumi-demo-ec2-"`   |
| `s3_bucket_arn` | ARN of the S3 bucket the instance role is granted read access to.  | string | n/a                       |

## Outputs

| Name                     | Description                                                   |
|--------------------------|----------------------------------------------------------------|
| `instance_profile_name`  | Name of the instance profile to attach to the EC2 instance.   |
| `instance_profile_arn`   | ARN of the instance profile.                                   |
| `role_name`              | Name of the EC2 instance role.                                 |
| `role_arn`               | ARN of the EC2 instance role.                                   |
| `policy_arn`             | ARN of the S3 read policy attached to the instance role.        |

## Release Workflow
* Make your changes and test them.
* Create a PR and merge it to main.
* Create a new release tag:
  ```sh
  git tag vX.Y.Z
  git push origin tag vX.Y.Z
  ```
* This triggers a GitHub Action that publishes the module to the `pequod` org's
  Pulumi Cloud Terraform module registry as `pequod/ec2-iam/aws@X.Y.Z`
  (see `.github/workflows/tag.yml`).
* Consumers can then reference the module either way:
  * From the Pulumi Cloud registry (recommended — versioned via the registry protocol):
    ```hcl
    module "ec2_iam" {
      source  = "tf.pulumi.com/pequod/ec2-iam/aws"
      version = "X.Y.Z"
      # ...
    }
    ```
  * Directly from this repo, pinned to a tag:
    ```hcl
    module "ec2_iam" {
      source = "github.com/pulumi-pequod/component-ec2-iam-tf?ref=vX.Y.Z"
      # ...
    }
    ```
