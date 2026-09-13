.PHONY: build run test test-coverage fmt lint tidy

build:
	go build -o bin/api ./cmd/api

run:
	go run ./cmd/api

test:
	go test ./...

test-coverage:
	go test -cover -coverprofile=coverage.out ./...
	go tool cover -func=coverage.out

fmt:
	gofmt -l -w .

lint:
	golangci-lint run

tidy:
	go mod tidy
