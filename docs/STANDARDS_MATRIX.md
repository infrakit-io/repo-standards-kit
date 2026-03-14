# Standards Matrix

## Managed files per profile

### vmware
- Makefile
- .github/workflows/ci.yml
- .github/workflows/release.yml
- scripts/install-requirements.sh
- scripts/release-notes.sh

### talos
- Makefile
- .github/workflows/ci.yml
- .github/workflows/release.yml
- scripts/install-requirements.sh
- scripts/release-notes.sh
- internal/tooling/vmbootstrap/vmbootstrap.go
- internal/tooling/vmbootstrap/vmbootstrap_test.go
- tools/vmbootstrapctl/main.go
- internal/cli/vmbootstrap_assets.go

### go-library
- Makefile
- .golangci.yml
- .github/workflows/ci.yml
- .github/workflows/release.yml
- .github/pull_request_template.md
- SECURITY.md
- CONTRIBUTING.md
- CODE_STYLE.md
- scripts/install-requirements.sh
- scripts/decision-contract-check.sh
- scripts/security-check.sh
- scripts/standards-check.sh
- scripts/release-notes.sh
- docs/CHANGELOG.md
- docs/RELEASES.md
- docs/coverage/coverage.json

## Scope

This kit only manages files explicitly listed in `profiles/*.manifest`.
It does not modify application code or sensitive configuration files.

## Cross-repo CLI baseline

- Use `cli-wizard-core` for user-facing CLI errors/hints (`FormatCLIError`, `NewUserError`, `WithHint`).
- Avoid per-repository custom error renderers.
