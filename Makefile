.PHONY: help refresh sync-vmware sync-talos verify

VMWARE_TARGET ?= ../vmware-vm-bootstrap
TALOS_TARGET ?= ../talos-docker-bootstrap
GO_LIB_TARGET ?= ../cli-wizard-core

help:
	@echo "repo-standards-kit"
	@echo "  make refresh      - refresh templates from source repos"
	@echo "  make sync-vmware  - apply vmware profile to vmware-vm-bootstrap"
	@echo "  make sync-talos   - apply talos profile to talos-docker-bootstrap"
	@echo "  make sync-go-lib  - apply go-library profile to cli-wizard-core"
	@echo "  make verify       - dry-run both profiles"
	@echo ""
	@echo "Targets can be overridden:"
	@echo "  VMWARE_TARGET=$(VMWARE_TARGET)"
	@echo "  TALOS_TARGET=$(TALOS_TARGET)"
	@echo "  GO_LIB_TARGET=$(GO_LIB_TARGET)"

refresh:
	@./scripts/refresh-from-sources.sh

sync-vmware:
	@./scripts/sync-profile.sh --profile vmware --target "$(VMWARE_TARGET)"

sync-talos:
	@./scripts/sync-profile.sh --profile talos --target "$(TALOS_TARGET)"

sync-go-lib:
	@./scripts/sync-profile.sh --profile go-library --target "$(GO_LIB_TARGET)"

verify:
	@./scripts/sync-profile.sh --profile vmware --target "$(VMWARE_TARGET)" --dry-run
	@./scripts/sync-profile.sh --profile talos --target "$(TALOS_TARGET)" --dry-run
	@./scripts/sync-profile.sh --profile go-library --target "$(GO_LIB_TARGET)" --dry-run
