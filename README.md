# repo-standards-kit

Cross-repo standardization kit for Go bootstrap projects.

This repository extracts and keeps the existing standards from:
- `../vmware-vm-bootstrap` (example relative path)
- `../talos-docker-bootstrap` (example relative path)

## What it standardizes

- `Makefile` (layout + targets + output style)
- GitHub Actions: `ci.yml`, `release.yml`
- Coverage badge automation (`docs/coverage/coverage.json` updated by CI)
- operational scripts: `scripts/install-requirements.sh`, `scripts/release-notes.sh`
- talos tooling code for vmbootstrap integration:
  - `internal/tooling/vmbootstrap/*`
  - `tools/vmbootstrapctl/main.go`
  - `internal/cli/vmbootstrap_assets.go`

## Structure

- `templates/profiles/<profile>/...` - canonical files per profile
- `profiles/*.manifest` - list of managed files per profile
- `scripts/sync-profile.sh` - applies a profile to a target repository
- `scripts/refresh-from-sources.sh` - re-extracts templates from source repositories

## Available profiles

- `vmware`
- `talos`
- `go-library`

## Usage

### 1) Sync dry-run

```bash
./scripts/sync-profile.sh --profile vmware --target ../vmware-vm-bootstrap --dry-run
```

### 2) Sync for real

```bash
./scripts/sync-profile.sh --profile talos --target ../talos-docker-bootstrap
```

### 3) Sync go-library profile

```bash
./scripts/sync-profile.sh --profile go-library --target ../cli-wizard-core
```

### 4) Refresh templates from source repos

```bash
./scripts/refresh-from-sources.sh
```

### 5) Initialize a new repository from a profile (recommended)

```bash
make init-profile PROFILE=vmware TARGET=../my-new-repo INIT_GIT=1 INIT_COMMIT=1
```

Equivalent script usage:

```bash
./scripts/init-repo.sh --profile vmware --target ../my-new-repo --with-git --commit
```

## Recommended workflow

- keep this repo as the single source of truth for standards;
- update standards here first;
- apply updates in target repositories using `sync-profile.sh`;
- validate in each target repo with: `make test && make build`.
