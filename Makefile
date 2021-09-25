.PHONY: introduction
introduction:
	@echo "Checkov introduction"
	checkov -d introduction

.PHONY: webapp
webapp:
	@echo "Checkov webapp"
	checkov -d webapp

.PHONY: k8s
k8s:
	@echo "Checkov k8s"
	checkov -d k8s