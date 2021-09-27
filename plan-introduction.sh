terraform -chdir=introduction init
terraform -chdir=introduction plan --out tfplan.binary
terraform -chdir=introduction show -json tfplan.binary > introduction/tfplan.json
checkov -f introduction/tfplan.json