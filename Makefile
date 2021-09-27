.PHONY: introduction
introduction:
	@echo "Checkov introduction"
	checkov -d introduction

.PHONY: eks
eks:
	@echo "Checkov k8s"
	checkov -d eks

.PHONY: k8s
k8s:
	@echo "Checkov k8s"
	checkov -d k8s