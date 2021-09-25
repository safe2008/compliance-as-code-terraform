# compliance-as-code-terraform

```shell
## 1
cd introduction
terraform plan --out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
checkov -f tfplan.json

## 2
checkov -d introduction --soft-fail --download-external-modules true  --framework terraform  --output json

```