.PHONY: help refresh sync-vmware sync-talos verify

help:
	@echo "repo-standards-kit"
	@echo "  make refresh      - refresh templates from source repos"
	@echo "  make sync-vmware  - apply vmware profile to vmware-vm-bootstrap"
	@echo "  make sync-talos   - apply talos profile to talos-vm-bootstrap"
	@echo "  make verify       - dry-run both profiles"

refresh:
	@./scripts/refresh-from-sources.sh

sync-vmware:
	@./scripts/sync-profile.sh --profile vmware --target ~/work/GDC/vmware-vm-bootstrap

sync-talos:
	@./scripts/sync-profile.sh --profile talos --target ~/work/GDC/talos-vm-bootstrap

verify:
	@./scripts/sync-profile.sh --profile vmware --target ~/work/GDC/vmware-vm-bootstrap --dry-run
	@./scripts/sync-profile.sh --profile talos --target ~/work/GDC/talos-vm-bootstrap --dry-run
