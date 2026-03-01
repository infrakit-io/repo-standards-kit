# repo-standards-kit

Cross-repo standardization kit for Go bootstrap projects.

This repository extracts and keeps the existing standards from:
- `~/work/GDC/vmware-vm-bootstrap`
- `~/work/GDC/talos-vm-bootstrap`

## What it standardizes

- `Makefile` (layout + targets + output style)
- GitHub Actions: `ci.yml`, `release.yml`
- operational scripts: `scripts/install-requirements.sh`, `scripts/release-notes.sh`

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
./scripts/sync-profile.sh --profile vmware --target ~/work/GDC/vmware-vm-bootstrap --dry-run
```

### 2) Sync for real

```bash
./scripts/sync-profile.sh --profile talos --target ~/work/GDC/talos-vm-bootstrap
```

### 3) Sync go-library profile

```bash
./scripts/sync-profile.sh --profile go-library --target ~/work/GDC/cli-wizard-core
```

### 4) Refresh templates from source repos

```bash
./scripts/refresh-from-sources.sh
```

## Recommended workflow

- keep this repo as the single source of truth for standards;
- update standards here first;
- apply updates in target repositories using `sync-profile.sh`;
- validate in each target repo with: `make test && make build`.
