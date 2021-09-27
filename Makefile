.PHONY: introduction
introduction: clear
	@echo "Checkov introduction"
	checkov -d introduction

.PHONY: introduction-solution
introduction-solution: clear
	@echo "Checkov introduction-solution"
	checkov -d introduction-solution

.PHONY: plan
plan:
	@echo "Checkov plan introduction"
	terraform -chdir=introduction init
	terraform -chdir=introduction plan --out tfplan.binary
	terraform -chdir=introduction show -json tfplan.binary > introduction/tfplan.json
	checkov -f introduction/tfplan.json

.PHONY: plan-solution
plan-solution:
	@echo "Checkov plan introduction-solution"
	terraform -chdir=introduction-solution init
	terraform -chdir=introduction-solution plan --out tfplan.binary
	terraform -chdir=introduction-solution show -json tfplan.binary > introduction-solution/tfplan.json
	checkov -f introduction-solution/tfplan.json

.PHONY: clear
clear:
	@echo "Clear all"
	rm -rf */.terraform
	rm -rf */.terraform.lock.hcl
	rm -rf */tfplan.*

.PHONY: fmt
fmt:
	@echo "fmt all"
	terraform -chdir=introduction fmt
	terraform -chdir=introduction-solution fmt

.PHONY: eks
eks:
	@echo "Checkov k8s"
	checkov -d eks