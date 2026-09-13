# Testing conventions

How tests are written in this project. Applies from the first domain code onward (TASK-006+).

## Library

Plain stdlib `testing`. No `testify` or other assertion library.

Rationale: the tests we write (entity validation, use case rules, handler behavior) are simple enough that `if got != want { t.Errorf(...) }` doesn't get in the way, and it avoids an external dependency this early. Revisit if assertions become repetitive/verbose enough to justify the dependency.

## Location and package

- Tests live next to the code they test: `merchant.go` → `merchant_test.go`.
- Use the **same package** (`package merchant`, not `package merchant_test`) so tests can exercise unexported behavior directly. Use an external `_test` package only when the goal is explicitly to test a public API surface from a consumer's point of view.

## Table-driven tests

Default shape for any function with more than one meaningful scenario:

```go
func TestSomething(t *testing.T) {
	tests := []struct {
		name    string
		input   int
		want    int
		wantErr bool
	}{
		{name: "valid case", input: 10, want: 20},
		{name: "negative input is rejected", input: -1, wantErr: true},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := Something(tt.input)

			if tt.wantErr {
				if err == nil {
					t.Fatalf("Something(%d): expected error, got nil", tt.input)
				}
				return
			}

			if err != nil {
				t.Fatalf("Something(%d): unexpected error: %v", tt.input, err)
			}
			if got != tt.want {
				t.Errorf("Something(%d) = %d, want %d", tt.input, got, tt.want)
			}
		})
	}
}
```

## Integration tests

Repository implementations backed by Postgres (starting TASK-012) are integration tests, not unit tests. They:

- Live in files named `<file>_integration_test.go`.
- Start with a build tag so they're excluded from the default `make test` run:

  ```go
  //go:build integration

  package merchant
  ```

- Run explicitly via a dedicated Makefile target (added when TASK-012 introduces the first one), not as part of the default suite.

## Coverage

`make test-coverage` runs the suite with coverage enabled and prints a per-package/per-function breakdown (`go tool cover -func`). The raw profile (`coverage.out`) is gitignored — it's a local artifact, not something to commit.

## Handoff process

For any task involving production/business code, the test file(s) already exist in the repo before the task is handed off — the job is to write the code that makes them pass, then run `make test` (or `make test-coverage`).
