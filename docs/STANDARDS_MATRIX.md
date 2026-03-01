# Standards Matrix

## Managed files per profile

### vmware-vm-bootstrap
- Makefile
- .github/workflows/ci.yml
- .github/workflows/release.yml
- scripts/install-requirements.sh
- scripts/release-notes.sh

### talos-vm-bootstrap
- Makefile
- .github/workflows/ci.yml
- .github/workflows/release.yml
- scripts/install-requirements.sh
- scripts/release-notes.sh

## Scope

Acest kit gestionează doar fișierele explicit listate în `profiles/*.manifest`.
Nu modifică codul de aplicație sau config-urile sensibile.
