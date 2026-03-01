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

## Scope

This kit only manages files explicitly listed in `profiles/*.manifest`.
It does not modify application code or sensitive configuration files.
