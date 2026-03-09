.PHONY: help refresh sync-vmware sync-talos sync-go-lib verify init-profile setup

VMWARE_TARGET ?= ../vmware-vm-bootstrap
TALOS_TARGET ?= ../talos-docker-bootstrap
GO_LIB_TARGET ?= ../cli-wizard-core
PROFILE ?= vmware
TARGET ?= ../new-repo
INIT_GIT ?= 1
INIT_COMMIT ?= 1

help:
	@echo "repo-standards-kit"
	@echo "  make refresh      - refresh templates from source repos"
	@echo "  make sync-vmware  - apply vmware profile to vmware-vm-bootstrap"
	@echo "  make sync-talos   - apply talos profile to talos-docker-bootstrap"
	@echo "  make sync-go-lib  - apply go-library profile to cli-wizard-core"
	@echo "  make verify       - dry-run both profiles"
	@echo "  make init-profile - initialize a new repo from profile"
	@echo ""
	@echo "Targets can be overridden:"
	@echo "  VMWARE_TARGET=$(VMWARE_TARGET)"
	@echo "  TALOS_TARGET=$(TALOS_TARGET)"
	@echo "  GO_LIB_TARGET=$(GO_LIB_TARGET)"
	@echo ""
	@echo "Init options:"
	@echo "  PROFILE=$(PROFILE)"
	@echo "  TARGET=$(TARGET)"
	@echo "  INIT_GIT=$(INIT_GIT)"
	@echo "  INIT_COMMIT=$(INIT_COMMIT)"

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

init-profile:
	@GIT_FLAG=""; COMMIT_FLAG=""; \
	if [ "$(INIT_GIT)" = "1" ] || [ "$(INIT_GIT)" = "true" ]; then GIT_FLAG="--with-git"; fi; \
	if [ "$(INIT_COMMIT)" = "1" ] || [ "$(INIT_COMMIT)" = "true" ]; then COMMIT_FLAG="--commit"; fi; \
	./scripts/init-repo.sh --profile "$(PROFILE)" --target "$(TARGET)" $$GIT_FLAG $$COMMIT_FLAG

setup:
	@mkdir -p .git/hooks
	@cp templates/common/hooks/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@printf "pre-commit hook installed\n"
