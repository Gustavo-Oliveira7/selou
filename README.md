# selou

Loyalty program platform for stores: merchants create stamp-based loyalty programs, customers earn stamps on purchases and redeem rewards.

## Requirements

- Go 1.26+
- [golangci-lint](https://golangci-lint.run/) (`brew install golangci-lint`)

## Development

| Command      | Description                          |
|--------------|---------------------------------------|
| `make build` | Build the binary into `bin/api`       |
| `make run`   | Run the API locally                   |
| `make test`  | Run all tests                         |
| `make fmt`   | Format the codebase                   |
| `make lint`  | Run static analysis (golangci-lint)   |
| `make tidy`  | Sync `go.mod` / `go.sum`              |

## Project status

See [docs/progress.md](docs/progress.md) for current progress, decisions, and the full backlog.
