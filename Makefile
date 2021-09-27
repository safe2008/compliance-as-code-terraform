.PHONY: introduction
introduction:
	@echo "Checkov introduction"
	checkov -d introduction

.PHONY: eks
eks:
	@echo "Checkov k8s"
	checkov -d eks

.PHONY: plan
plan:
	@echo "Checkov plan introduction"
	terraform -chdir=introduction init
	terraform -chdir=introduction plan --out tfplan.binary
	terraform -chdir=introduction show -json tfplan.binary > introduction/tfplan.json
	checkov -f introduction/tfplan.json