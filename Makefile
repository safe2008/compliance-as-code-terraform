.PHONY: introduction
introduction: clear
	@echo "Checkov introduction"
	docker pull bridgecrew/checkov:latest
	docker run --tty -v `pwd`/introduction:/introduction bridgecrew/checkov --show-config
	docker run --tty -v `pwd`/introduction:/introduction bridgecrew/checkov --directory /introduction --config-file introduction/.checkov.yaml

.PHONY: introduction-solution
introduction-solution: clear
	@echo "Checkov introduction-solution"
	docker pull bridgecrew/checkov:latest
	docker run --tty -v `pwd`/introduction:/introduction bridgecrew/checkov --show-config
	docker run --tty -v `pwd`/introduction-solution:/introduction-solution bridgecrew/checkov --directory /introduction-solution --config-file introduction-solution/.checkov.yaml

.PHONY: plan
plan: clear
	@echo "Checkov plan introduction"
	terraform -chdir=introduction init
	terraform -chdir=introduction plan --out tfplan.binary
	terraform -chdir=introduction show -json tfplan.binary > introduction/tfplan.json
	docker pull bridgecrew/checkov:latest
	docker run --tty -v `pwd`/introduction:/introduction bridgecrew/checkov -f introduction/tfplan.json --config-file introduction/.checkov.yaml

.PHONY: plan-solution
plan-solution: clear
	@echo "Checkov plan introduction-solution"
	terraform -chdir=introduction-solution init
	terraform -chdir=introduction-solution plan --out tfplan.binary
	terraform -chdir=introduction-solution show -json tfplan.binary > introduction-solution/tfplan.json
	docker pull bridgecrew/checkov:latest
	docker run -v `pwd`/introduction-solution:/introduction-solution bridgecrew/checkov -f introduction-solution/tfplan.json --config-file introduction-solution/.checkov.yaml

.PHONY: clear
clear:
	@echo "Clear all"
	rm -rf */.terraform
	rm -rf */.terraform.lock.hcl
	rm -rf */tfplan.*
	docker rm -f `docker ps -aq` || true

.PHONY: fmt
fmt:
	@echo "fmt all"
	terraform -chdir=introduction fmt
	terraform -chdir=introduction-solution fmt
