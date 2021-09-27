.PHONY: introduction
introduction:
	@echo "Checkov introduction"
	checkov -d introduction --skip-check CKV_AWS_144

.PHONY: eks
eks:
	@echo "Checkov k8s"
	checkov -d eks

.PHONY: k8s
k8s:
	@echo "Checkov k8s"
	checkov -d k8s