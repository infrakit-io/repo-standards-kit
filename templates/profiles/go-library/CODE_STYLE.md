# Code Style

## Go

- Follow standard `gofmt` / `goimports` formatting — enforced by `make fmt`.
- Linting rules are defined in `.golangci.yml` — enforced by `make lint`.
- Use `log/slog` for structured logging; never log secrets, tokens, or passwords.
- All exported functions must accept `context.Context` as their first parameter when performing I/O or long-running work.
- Error handling:
  - Always wrap errors with context: `fmt.Errorf("operation X: %w", err)`.
  - Do not silently discard errors with `_ =` unless the error is truly best-effort (add a comment explaining why).
  - Fail fast: do not mask errors with default values.
- Avoid hardcoding environment-specific values (IPs, ports, versions, URLs) — use constants or configuration.
- Prefer explicit over implicit: avoid global mutable state, init side-effects, and unexported package-level vars for business logic.

## Naming

- Acronyms in identifiers follow Go convention: `ID`, `URL`, `HTTP`, `API` (all caps when short, mixed when compound: `userID`, `apiURL`).
- Test helpers: suffix with `t.Helper()` and name clearly (`mustLoadConfig`, `newTestStore`).

## Tests

- Table-driven tests for all validation and parsing logic.
- Avoid mocking internal packages — test at integration boundary where possible.
- Test files: `_test.go` suffix, same package (white-box) or `_test` suffix package (black-box).

## Commits

- Conventional commit format: `type(scope): short description`.
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
- Keep commits atomic: one logical change per commit.
