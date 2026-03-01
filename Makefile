.PHONY: help refresh sync-vmware sync-talos verify

help:
	@echo "repo-standards-kit"
	@echo "  make refresh      - refresh templates from source repos"
	@echo "  make sync-vmware  - apply vmware profile to vmware-vm-bootstrap"
	@echo "  make sync-talos   - apply talos profile to talos-vm-bootstrap"
	@echo "  make sync-go-lib  - apply go-library profile to cli-wizard-core"
	@echo "  make verify       - dry-run both profiles"

refresh:
	@./scripts/refresh-from-sources.sh

sync-vmware:
	@./scripts/sync-profile.sh --profile vmware --target ~/work/GDC/vmware-vm-bootstrap

sync-talos:
	@./scripts/sync-profile.sh --profile talos --target ~/work/GDC/talos-vm-bootstrap

sync-go-lib:
	@./scripts/sync-profile.sh --profile go-library --target ~/work/GDC/cli-wizard-core

verify:
	@./scripts/sync-profile.sh --profile vmware --target ~/work/GDC/vmware-vm-bootstrap --dry-run
	@./scripts/sync-profile.sh --profile talos --target ~/work/GDC/talos-vm-bootstrap --dry-run
	@./scripts/sync-profile.sh --profile go-library --target ~/work/GDC/cli-wizard-core --dry-run
