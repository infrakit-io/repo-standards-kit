# repo-standards-kit

Standardizare cross-repo pentru proiectele Go din seria bootstrap.

Acest repo extrage și păstrează standardele existente din:
- `~/work/GDC/vmware-vm-bootstrap`
- `~/work/GDC/talos-vm-bootstrap`

## Ce standardizează

- `Makefile` (layout + ținte + output style)
- GitHub Actions: `ci.yml`, `release.yml`
- scripturi operaționale: `scripts/install-requirements.sh`, `scripts/release-notes.sh`

## Structură

- `templates/profiles/<profile>/...` — fișiere canonice per profil
- `profiles/*.manifest` — lista fișierelor gestionate per profil
- `scripts/sync-profile.sh` — aplică profilul într-un repo țintă
- `scripts/refresh-from-sources.sh` — re-extrage template-urile din repo-urile sursă

## Profile disponibile

- `vmware-vm-bootstrap`
- `talos-vm-bootstrap`

## Utilizare

### 1) Sync dry-run

```bash
./scripts/sync-profile.sh --profile vmware-vm-bootstrap --target ~/work/GDC/vmware-vm-bootstrap --dry-run
```

### 2) Sync efectiv

```bash
./scripts/sync-profile.sh --profile talos-vm-bootstrap --target ~/work/GDC/talos-vm-bootstrap
```

### 3) Refresh templates din source repos

```bash
./scripts/refresh-from-sources.sh
```

## Recomandare de lucru

- menții acest repo ca sursă de adevăr pentru standarde;
- schimbi standardele aici;
- aplici în repo-urile țintă prin `sync-profile.sh`;
- validezi în fiecare repo: `make test && make build`.
