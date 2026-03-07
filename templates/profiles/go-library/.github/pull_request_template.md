## Checklist

- [ ] I ran `make decision-check TOPIC="..."` (or `make standards-check TOPIC="..."`) and reviewed relevant decisions.
- [ ] Wizard/menu behavior follows accepted decisions; no local ad-hoc divergence.
- [ ] Shared reusable components/helpers are used (DRY), no duplicated local logic.
- [ ] No sensitive plaintext files were introduced.
- [ ] All `*.sops.yaml` changes remain encrypted with valid `sops:` metadata.
