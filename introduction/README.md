

https://source.coveo.com/2021/03/02/checkov-terragrunt-hook/
terraform init -backend=false -input=false && checkov -d . --quiet --skip-check CKV_AWS_21,CKV_AWS_52
