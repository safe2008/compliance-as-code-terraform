.PHONY: introduction
introduction:
	@echo "Checkov introduction"
	checkov -d introduction --soft-fail --download-external-modules true  --framework terraform

.PHONY: webapp
webapp:
	@echo "Checkov webapp"
	checkov -d webapp --soft-fail --download-external-modules true  --framework terraform

.PHONY: k8s
k8s:
	@echo "Checkov k8s"
	checkov -d k8s --soft-fail --download-external-modules true  --framework kubernetes