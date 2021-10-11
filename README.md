# compliance-as-code-terraform

```shell
## None fix
make introduction
make plan

## Fixed
make introduction-solution
make plan-solution

```
## Existing vulnerabilities (Auto-Generated)


|    | check_id    | file         | resource               | check_name                                                                   | guideline                                                                                    |
|----|-------------|--------------|------------------------|------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
|  0 | CKV_AWS_79  | /resource.tf | aws_instance.instance1 | Ensure Instance Metadata Service Version 1 is not enabled                    | https://docs.bridgecrew.io/docs/bc_aws_general_31                                            |
|  1 | CKV_AWS_135 | /resource.tf | aws_instance.instance1 | Ensure that EC2 is EBS optimized                                             | https://docs.bridgecrew.io/docs/ensure-that-ec2-is-ebs-optimized                             |
|  2 | CKV_AWS_8   | /resource.tf | aws_instance.instance1 | Ensure all data stored in the Launch configuration EBS is securely encrypted | https://docs.bridgecrew.io/docs/general_13                                                   |
|  3 | CKV_AWS_126 | /resource.tf | aws_instance.instance1 | Ensure that detailed monitoring is enabled for EC2 instances                 | https://docs.bridgecrew.io/docs/ensure-that-detailed-monitoring-is-enabled-for-ec2-instances |
|  4 | CKV_AWS_18  | /resource.tf | aws_s3_bucket.data     | Ensure the S3 bucket has access logging enabled                              | https://docs.bridgecrew.io/docs/s3_13-enable-logging                                         |
|  5 | CKV_AWS_19  | /resource.tf | aws_s3_bucket.data     | Ensure all data stored in the S3 bucket is securely encrypted at rest        | https://docs.bridgecrew.io/docs/s3_14-data-encrypted-at-rest                                 |
|  6 | CKV_AWS_145 | /resource.tf | aws_s3_bucket.data     | Ensure that S3 buckets are encrypted with KMS by default                     | https://docs.bridgecrew.io/docs/ensure-that-s3-buckets-are-encrypted-with-kms-by-default     |


---


