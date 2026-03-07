# Contributing

## Development

Use the Go version from `go.mod`.

Run before opening a PR:

```bash
make standards-check TOPIC="short-topic-for-change"
make decision-contract-check
make security-check
make fmt
make vet
make lint
make test
```

## Release Notes

Update `docs/RELEASES.md` for any user-visible change.

## Rules

- Keep changes minimal, idempotent, and fail-fast.
- Avoid environment-specific hardcoded values.
- Add tests for behavior and validation paths.
- Follow accepted decisions for behavior/UX changes; no local ad-hoc divergence from shared contracts.
- Never leave sensitive plaintext in `*.sops.yaml`.
